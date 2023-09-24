import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/pin_unlock_dialog.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectDialog extends ConsumerWidget {
  const SelectDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isInPracticeMode = ref.read(gameDataNotifierProvider).isInPracticeMode;
    return DialogTemplate(
      title: const Text('Settings'),
      content: ElevatedButton(
        onPressed: () {
          // change game mode
          ref.read(gameDataNotifierProvider.notifier).changeGameMode();

          if (isInPracticeMode) {
            // create a new plain game data object that doesn't trigger forecast
            ref.read(gameDataNotifierProvider.notifier).startNewGame(isNewSeason: false);
          } else {
            // create a new plain game data that triggers forecast right away
            ref.read(gameDataNotifierProvider.notifier).startNewGame(isNewSeason: true);
          }

          // close dialog
          Navigator.of(context).pop();

          // show pin unlock dialog if switching from practice to real mode
          if (isInPracticeMode) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const PinUnlockDialog();
              },
            );
          }
        },
        child: Text(
          isInPracticeMode ? 'CHANGE TO REAL MODE' : 'CHANGE TO PRACTICE MODE',
        ),
      ),
    );
  }
}
