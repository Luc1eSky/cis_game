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
          "Do you really want to start a new game? "
          "Previous summary data won't be accessible.",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No, go back'),
        ),
        ElevatedButton(
          onPressed: () {
            // Close the current dialog
            Navigator.of(context).pop();
            ref.read(gameDataNotifierProvider.notifier).startNewGame();
            // open the dialog to choose a new player
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                // TODO: SHOW WARNING
                // Start new Game
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
