import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/player_done_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/result.dart';
import '../constants.dart';
import '../state_management/game_data_notifier.dart';

class SeasonSummaryDialog extends ConsumerStatefulWidget {
  const SeasonSummaryDialog({super.key});

  @override
  ConsumerState<SeasonSummaryDialog> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<SeasonSummaryDialog> {
  @override
  Widget build(BuildContext context) {
    Result result = ref.read(gameDataNotifierProvider).savedResults.last;
    return DialogTemplate(
      content: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Seed Type',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Number of fields',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Yields',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(
                  SizedBox(
                    width: 40,
                    child: Image.asset('assets/images/zebra.png'),
                  ),
                ),
                DataCell(Text(result.zebraFields.toString())),
                DataCell(
                  Text('${result.zebraPayout.toString()} $currency'),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(SizedBox(
                  width: 40,
                  child: Image.asset('assets/images/lion.png'),
                )),
                DataCell(Text(result.lionFields.toString())),
                DataCell(Text('${result.lionPayout} $currency')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(SizedBox(
                  width: 40,
                  child: Image.asset('assets/images/elephant.png'),
                )),
                DataCell(
                  Text(result.elephantFields.toString()),
                ),
                DataCell(Text('${result.elephantPayout.toString()} $currency')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/cash_box'
                        '.png'),
                  ),
                ),
                const DataCell(Text('')),
                DataCell(
                  Text('${result.savings} $currency'),
                ),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                const DataCell(
                  Text(
                    "Total Payoff",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                DataCell(
                  Text(
                    result.amountOfPlantedFields.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                DataCell(
                  Text(
                    '${result.totalPayout.toString()} $currency',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ref.read(gameDataNotifierProvider).currentCouple.currentPlayer!.hasPlayed
            ? ElevatedButton(
                onPressed: () {
                  // Close the current dialog
                  Navigator.of(context).pop();
                  // open a dialog for the enumerator to get results of one person

                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const PlayerDoneDialog();
                      });
                },
                child: Text(
                  ref.read(gameDataNotifierProvider).currentCouple.everyoneHasPlayed
                      ? 'Summary Page'
                      : 'Next Player',
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the current dialog
                  ref.read(gameDataNotifierProvider.notifier).startNewSeason();
                },
                child: const Text('Next Season'),
              )
      ],
    );
  }
}
