import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotEnoughCash extends ConsumerWidget {
  const NotEnoughCash({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogTemplate(
      //title: Text("Not enough money"),
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
              Icons.arrow_back,
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
