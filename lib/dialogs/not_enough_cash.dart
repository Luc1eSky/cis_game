import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:flutter/material.dart';

class NotEnoughCash extends StatelessWidget {
  const NotEnoughCash({super.key});

  @override
  Widget build(BuildContext context) {
    return const DialogTemplate(
      title: Text("Warning"),
      content: Text('You do not have enough cash.'),
    );
  }
}
