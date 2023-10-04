import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:flutter/material.dart';

class WarningUseCashDialog extends StatelessWidget {
  const WarningUseCashDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogTemplate(
      //title: Text("Warning"),
      content: SizedBox(
        height: 80,
        width: 250,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Image.asset(
                'assets/images/K100_note.jpeg',
                height: 50,
              ),
            ),
            const FittedBox(
                child: Icon(
              Icons.arrow_forward,
              size: 200,
            )),
            FittedBox(
              child: Image.asset(
                'assets/images/cash_box.png',
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
