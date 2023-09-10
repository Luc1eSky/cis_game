import 'package:cis_game/classes/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../state_management/game_data_notifier.dart';
import 'choose_player_dialog.dart';

class SummaryDialog extends ConsumerStatefulWidget {
  const SummaryDialog({super.key});

  @override
  ConsumerState<SummaryDialog> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<SummaryDialog> {
  SeedType? selectedSeedType = seedTypeList[0];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Summary Page"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataTable(
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
                  DataCell(Text(ref.watch(gameDataNotifierProvider).zebras[0].toString())),
                  DataCell(
                    Text('${ref.watch(gameDataNotifierProvider).zebras[1].toString()} kwecha'),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(SizedBox(
                    width: 40,
                    child: Image.asset('assets/images/lion.png'),
                  )),
                  DataCell(Text(ref.watch(gameDataNotifierProvider).lions[0].toString())),
                  DataCell(Text('${ref.watch(gameDataNotifierProvider).lions[1]} $currency')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(SizedBox(
                    width: 40,
                    child: Image.asset('assets/images/elephant.png'),
                  )),
                  DataCell(
                    Text(ref.watch(gameDataNotifierProvider).elephants[0].toString()),
                  ),
                  DataCell(Text(
                      '${ref.watch(gameDataNotifierProvider).elephants[1].toString()} $currency')),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/images/cash_box'
                          '.png'))),
                  const DataCell(Text('')),
                  DataCell(
                    Text('${ref.watch(gameDataNotifierProvider).savings} $currency'),
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
                  DataCell(Text(
                    ref.watch(gameDataNotifierProvider).total[0].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
                  DataCell(
                    Text(
                      '${ref.watch(gameDataNotifierProvider).total[1].toString()} $currency',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ref.read(gameDataNotifierProvider).currentCouple.currentPlayer!.hasPlayed
              ? ref.read(gameDataNotifierProvider).currentCouple.everyoneHasPlayed
                  ? ElevatedButton(
                      onPressed: () {
                        // Close the current dialog
                        Navigator.of(context).pop();
                        // open the dialog to choose a new player
                        showDialog(
                            context: context,
                            builder: (context) {
                              // TODO: SUMMARY DIALOG
                              return Container(
                                color: Colors.green,
                              );
                            });
                      },
                      child: const Text('Summary Page'),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        // Close the current dialog
                        Navigator.of(context).pop();
                        // open the dialog to choose a new player
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ChoosePlayerDialog();
                            });
                      },
                      child: const Text('Next Player'),
                    )
              : ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the current dialog
                    ref.read(gameDataNotifierProvider.notifier).startNewSeason();
                  },
                  child: const Text('Next Season'),
                )
        ],
      ),
    );
  }
}
