import 'package:cis_game/data/levels.dart';
import 'package:cis_game/dialogs/choose_player_for_summary_dialog.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/game_result.dart';
import '../classes/level_result.dart';
import '../color_palette.dart';
import '../localData/sembastDataRepository.dart';

class DieRollDialog extends ConsumerStatefulWidget {
  const DieRollDialog({super.key});

  @override
  ConsumerState<DieRollDialog> createState() => _DieRoleDialogState();
}

class _DieRoleDialogState extends ConsumerState<DieRollDialog> {
  int? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DialogTemplate(
        title: const Text('Result of Die Roll'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/12_sided_die_small.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 10.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: const Text('please select'),
                      value: dropDownValue,
                      items: List.generate(
                        // should be 12 (7 individual and 5 couple)
                        individualLevels.length + coupleLevels.length,
                        (index) {
                          int number = index + 1;
                          return DropdownMenuItem(
                            value: number,
                            child: Text(number.toString()),
                          );
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value!;
                        });
                      }),
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              int? dieRollResult = dropDownValue;
              // show error if nothing is selected
              if (dieRollResult == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: ColorPalette().snackBar,
                    content: const Center(
                      child: Text('Please select die roll result.'),
                    ),
                  ),
                );
                // do nothing
                return;
              }

              // save die roll result in game data
              ref
                  .read(gameDataNotifierProvider.notifier)
                  .setDieRollResult(result: dieRollResult);

              // save results locally
              List<LevelResult> savedLevelResults =
                  ref.read(gameDataNotifierProvider).savedResults;

              // add game result to local memory
              await ref
                  .read(localDataRepositoryProvider)
                  .addGameResult(GameResult(savedLevelResults, dieRollResult));

              if (context.mounted) {
                // Close the current dialog
                Navigator.of(context).pop();

                // open selection dialog
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    // Show the two buttons for wife and couple via a button
                    // make the buttons showing up dependent on the die roll result
                    return const ChoosePlayerForSummaryDialog();
                  },
                );
              }
            },
            child: const Text('CONTINUE'),
          )
        ],
      ),
    );
  }
}
