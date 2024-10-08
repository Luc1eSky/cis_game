import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/select_new_couple_dialog.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isInPracticeMode = ref.read(gameDataNotifierProvider).isInPracticeMode;
    return DialogTemplate(
      title: const Text('Settings'),
      content: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isInPracticeMode ? Colors.deepOrange : Colors.green,
        ),
        onPressed: () {
          // change game mode
          ref.read(gameDataNotifierProvider.notifier).changeGameMode();

          if (isInPracticeMode) {
            // create a new plain game data object that doesn't trigger forecast
            ref.read(gameDataNotifierProvider.notifier).startNewGame(newSeasonHasStarted: false);
          } else {
            // create a new plain game data that triggers forecast right away
            ref.read(gameDataNotifierProvider.notifier).startNewGame(newSeasonHasStarted: true);
          }

          // close dialog
          Navigator.of(context).pop();

          // show pin unlock dialog if switching from practice to real mode
          if (isInPracticeMode) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const SelectNewCoupleDialog();
              },
            );
          }
        },
        child: Text(
          isInPracticeMode ? 'CHANGE TO REAL MODE' : 'CHANGE TO PRACTICE MODE',
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        )
      ],
    );
  }
}
