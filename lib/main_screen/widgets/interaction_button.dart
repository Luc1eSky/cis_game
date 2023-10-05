import 'package:flutter/material.dart';

class InteractionButton extends StatelessWidget {
  const InteractionButton({
    super.key,
    required this.color,
    required this.icon,
    required this.returnBoolean,
  });

  final Color color;
  final Icon icon;
  final bool returnBoolean;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7),
        ),
        child: SizedBox(
          width: 100,
          height: 50,
          child: IconButton(
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(returnBoolean),
            icon: icon,
          ),
        ),
      ),
    );
  }
}
