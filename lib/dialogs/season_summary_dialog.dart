import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/player_done_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/level_result.dart';
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
    LevelResult result = ref.read(gameDataNotifierProvider).savedResults.last;
    return DialogTemplate(
      title: Text(
        'Season ${ref.read(gameDataNotifierProvider).season}',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            width: 350,
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
                      style: TextStyle(fontSize: 20),
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
            width: 350,
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
                      '${result.storedInSavings}\n$currency',
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                    )),
                  ),
                ),
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
                      '- ${result.costsTotal}\n$currency',
                      style: const TextStyle(
                        fontSize: 20,
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
            width: 350,
            child: Row(
              children: [
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
                      '+ ${result.earningsTotal} $currency',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
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
            width: 350,
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
                      '${result.totalMoneyAtEnd} $currency',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // if player has not yet finished their levels
        !ref.read(gameDataNotifierProvider).currentCouple.currentPlayer!.hasPlayed
            ? SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // close the current dialog
                    Navigator.of(context).pop();
                    // start a new season with the next level
                    ref.read(gameDataNotifierProvider.notifier).startNewSeason();
                  },
                  child: const FittedBox(
                    child: Icon(
                      Icons.arrow_forward,
                      size: 100,
                    ),
                  ),
                ),
              )
            :
            // if the player has finished their levels and is in practice mode
            ref.read(gameDataNotifierProvider).isInPracticeMode
                ? SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        // Close the current dialog
                        Navigator.of(context).pop();
                        // start a new game (is in practice mode by default)
                        ref
                            .read(gameDataNotifierProvider.notifier)
                            .startNewGame(newSeasonHasStarted: true);
                      },
                      child: const Text('Keep Practicing'),
                    ),
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
                          // TODO: SAVE RESULTS OF ALL PLAYED SEASONS OF PLAYER
                          ref.read(gameDataNotifierProvider.notifier).printPlayerResults();
                          return const PlayerDoneDialog();
                        },
                      );
                    },
                    child: Text(
                      // change text of button based on if everyone has played already
                      ref.read(gameDataNotifierProvider).currentCouple.everyoneHasPlayed
                          ? 'Summary Page'
                          : 'Next Player',
                    ),
                  ),
      ],
    );
  }
}
