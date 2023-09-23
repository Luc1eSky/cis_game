import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DieRoleDialog extends ConsumerWidget {
  const DieRoleDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogTemplate(
      title: const Text('Result of Die Roll'),
      content: Container(
        // Add a text field for the enumerator to add in the result of the
        // die roll
        // save result of the die roll in the results of the game!!! If there
        // is a question later about the result
        color: Colors.blue,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Close the current dialog
            Navigator.of(context).pop();
            // This should pop up the summary screens and highlight the row
            // based on the die roll from this dialog
            // open warning dialog
            showDialog(
              context: context,
              builder: (context) {
                // Show the two buttons for wife and couple via a button
                // make the buttons showing up dependent on the die roll result
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
