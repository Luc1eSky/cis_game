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
      title: Text(
        'Season ${ref.read(gameDataNotifierProvider).season}',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
            width: 400,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.asset('assets/images/K100_note.jpeg'),
                    ),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: SizedBox(
                        child: Text(
                      '$startingCash $currency',
                      style: TextStyle(fontSize: 25),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            //color: Colors.orangeAccent,
            child: const Icon(Icons.arrow_downward),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
            width: 400,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.asset('assets/images/planting_seed.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                        child: Text(
                      '- ${result.moneySpent} $currency',
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            //color: Colors.orangeAccent,
            child: const Icon(Icons.arrow_downward),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
            width: 400,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.asset('assets/images/cash_box.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                        child: Text(
                      '+ ${result.savings}',
                      style: const TextStyle(fontSize: 25, color: Colors.green),
                    )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.asset('assets/images/harvest_icon.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                        child: Text(
                      '+ ${result.moneyEarned}',
                      style: const TextStyle(fontSize: 25, color: Colors.green),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            //color: Colors.orangeAccent,
            child: const Icon(Icons.arrow_downward),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
            width: 400,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.asset('assets/images/K100_note.jpeg'),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                        child: Text(
                      '${result.moneyAtEndOfSeason} $currency',
                      style: const TextStyle(fontSize: 25),
                    )),
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   //color: Colors.blue,
          //   child: Text(
          //     'Money at beginning of season: ${result.startingCash} $currency\n'
          //     'Money saved during the season: ${result.startingCash - result.moneySpent} $currency\n'
          //     'Money Spent: ${result.moneySpent} $currency\n'
          //     'Money earned: ${result.moneyEarned} $currency\n'
          //     'Money at end of season: ${result.moneyAtEndOfSeason} $currency',
          //     style: const TextStyle(fontSize: 20),
          //   ),
          // ),
        ],
      ),
      //   DataRow(
      //     cells: <DataCell>[
      //       const DataCell(
      //         Text(
      //           "Total Payoff",
      //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      //         ),
      //       ),
      //       DataCell(
      //         Text(
      //           result.amountOfPlantedFields.toString(),
      //           style: const TextStyle(
      //               fontWeight: FontWeight.bold, fontSize: 20),
      //         ),
      //       ),
      //       DataCell(
      //         Text(
      //           '${result.totalPayout.toString()} $currency',
      //           style: const TextStyle(
      //               fontWeight: FontWeight.bold, fontSize: 20),
      //         ),
      //       ),
      //     ],
      //   ),
      // ],

      actions: [
        // if player has not yet finished their levels
        !ref
                .read(gameDataNotifierProvider)
                .currentCouple
                .currentPlayer!
                .hasPlayed
            ? ElevatedButton(
                onPressed: () {
                  // close the current dialog
                  Navigator.of(context).pop();
                  // start a new season with the next level
                  ref.read(gameDataNotifierProvider.notifier).startNewSeason();
                },
                child: const Text('Next Season'),
              )
            :
            // if the player has finished their levels and is in practice mode
            ref.read(gameDataNotifierProvider).isInPracticeMode
                ? ElevatedButton(
                    onPressed: () {
                      // Close the current dialog
                      Navigator.of(context).pop();
                      // start a new game (is in practice mode by default)
                      ref
                          .read(gameDataNotifierProvider.notifier)
                          .startNewGame(newSeasonHasStarted: true);
                    },
                    child: const Text('Keep Practicing'),
                  )
                :
                // if the player has finished their levels and is NOT in practice mode
                ElevatedButton(
                    onPressed: () {
                      // close the current dialog
                      Navigator.of(context).pop();
                      // ask player to hand tablet to enumerator
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const PlayerDoneDialog();
                        },
                      );
                    },
                    child: Text(
                      // change text of button based on if everyone has played already
                      ref
                              .read(gameDataNotifierProvider)
                              .currentCouple
                              .everyoneHasPlayed
                          ? 'Summary Page'
                          : 'Next Player',
                    ),
                  ),
      ],
    );
  }
}
