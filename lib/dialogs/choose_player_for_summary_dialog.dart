import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/die_roll_result_dialog.dart';
import 'package:cis_game/dialogs/game_summary_dialog.dart';
import 'package:cis_game/dialogs/warning_dialog.dart';
import 'package:cis_game/levels/levels.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/couple.dart';

class ChoosePlayerForSummaryDialog extends ConsumerWidget {
  const ChoosePlayerForSummaryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Couple currentCouple = ref.read(gameDataNotifierProvider).currentCouple;
    int? dieRollResult = ref.read(gameDataNotifierProvider).dieRollResult;

    return dieRollResult == null
        ? const DieRollDialog()
        : DialogTemplate(
            title: const Text('Select Player Summary'),
            content: dieRollResult <= individualLevels.length
                ? Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                          onPressed: () {
                            // open summary dialog of wife (and couple)
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                // Show Warning
                                return const GameSummaryDialog(
                                  playerType: PlayerType.wife,
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Wife'),
                                const SizedBox(height: 10),
                                Text(currentCouple.wife.formattedID),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          onPressed: () {
                            // open summary dialog of husband
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                // Show Warning
                                return const GameSummaryDialog(
                                  playerType: PlayerType.husband,
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Husband'),
                                const SizedBox(height: 10),
                                Text(currentCouple.husband.formattedID),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () {
                            // open summary dialog of husband (and couple)
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                // Show Warning
                                return const GameSummaryDialog(
                                  playerType: PlayerType.both,
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Couple'),
                                const SizedBox(height: 10),
                                Text(currentCouple.both.formattedID),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Close the current dialog
                  Navigator.of(context).pop();
                  // open warning dialog
                  showDialog(
                    context: context,
                    builder: (context) {
                      // Show Warning
                      return const WarningDialog();
                    },
                  );
                },
                child: const Text('NEW GAME'),
              )
            ],
          );
  }
}
