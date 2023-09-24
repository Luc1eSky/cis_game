import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:flutter/material.dart';

class WarningUseCashDialog extends StatelessWidget {
  const WarningUseCashDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const DialogTemplate(
      title: Text("Warning"),
      content: Text('Please use or save all cash.'),
    );
  }
}
