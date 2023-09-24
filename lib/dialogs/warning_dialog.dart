import 'package:cis_game/dialogs/choose_player_for_summary_dialog.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/pin_unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state_management/game_data_notifier.dart';

class WarningDialog extends ConsumerWidget {
  const WarningDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogTemplate(
      title: const Text(
        'Warning',
        style: TextStyle(color: Colors.red),
      ),
      content: const SizedBox(
        width: 50,
        child: Text(
          "Did the current couple receive their payment?"
          "\n\nPrevious summary data won't be accessible when you start a new "
          "game.",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            // open the dialog to choose a new player
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                // Show selection dialog again
                return const ChoosePlayerForSummaryDialog();
              },
            );
          },
          child: const Text('No, go back'),
        ),
        ElevatedButton(
          onPressed: () {
            // Close the current dialog
            Navigator.of(context).pop();
            // create a new plain game data object that doesn't trigger forecast
            ref.read(gameDataNotifierProvider.notifier).startNewGame(isNewSeason: false);
            // open the dialog to choose a new player
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                // Start new Game via unlock
                return const PinUnlockDialog();
              },
            );
          },
          child: const Text('Yes, new game'),
        ),
      ],
    );
  }
}
