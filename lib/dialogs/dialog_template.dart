import 'package:cis_game/color_palette.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DialogTemplate extends StatelessWidget {
  final Widget? title;
  final Widget content;
  final bool scrollable;
  final List<Widget>? actions;
  const DialogTemplate({
    this.title,
    required this.content,
    this.actions,
    this.scrollable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < minimumScreenHeight) {
      return const SizedBox();
    }
    return AlertDialog(
      scrollable: scrollable,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.all(15),
      backgroundColor: ColorPalette().dialogBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: title,
      content: content,
      actions: actions,
    );
  }
}
