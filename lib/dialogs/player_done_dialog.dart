import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/dialogs/pin_unlock_dialog.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerDoneDialog extends ConsumerStatefulWidget {
  const PlayerDoneDialog({super.key});

  @override
  ConsumerState<PlayerDoneDialog> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<PlayerDoneDialog> {
  @override
  Widget build(BuildContext context) {
    return DialogTemplate(
      content: SizedBox(
        width: 250,
        height: 250,
        //color: Colors.red,
        child: Column(
          // all children in column left aligned
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(child: Icon(Icons.tablet_android_outlined, size: 500)),
                  ),
                  Expanded(
                    child: FittedBox(
                        child: Icon(
                      Icons.arrow_forward,
                      size: 500,
                    )),
                  ),
                  Expanded(
                    child: FittedBox(child: Icon(Icons.person, size: 500)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Enumerator:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 25,
              child: FittedBox(
                child: Text(
                  ref.read(gameDataNotifierProvider).currentEnumerator!.fullName,
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Close the current dialog
            Navigator.of(context).pop();
            // open the dialog to choose a new player

            showDialog(
              context: context,
              builder: (context) {
                return const PinUnlockDialog();
              },
            );
          },
          child: const Icon(Icons.arrow_right_alt_outlined),
        ),
      ],
    );
  }
}
