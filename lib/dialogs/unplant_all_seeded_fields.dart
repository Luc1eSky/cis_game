import 'package:cis_game/data/seedtypes.dart';
import 'package:cis_game/main_screen/widgets/field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/field.dart';
import '../main_screen/widgets/interaction_button.dart';
import 'dialog_template.dart';

class UnplantAllSeededFieldsDialog extends ConsumerWidget {
  const UnplantAllSeededFieldsDialog({
    required this.fieldCount,
    super.key,
  });

  final int fieldCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogTemplate(
      content: SizedBox(
        height: 70,
        width: 300,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$fieldCount x',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(width: 10),
              AspectRatio(
                aspectRatio: 1.0,
                child: FieldWidget(
                  fieldID: 0,
                  seedType: seedTypeNone,
                  fieldStatus: FieldStatus.empty,
                  isDemoOnly: true,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: const [
        InteractionButton(
          color: Colors.red,
          icon: Icon(Icons.close),
          returnBoolean: false,
        ),
        InteractionButton(
          color: Colors.green,
          icon: Icon(Icons.check),
          returnBoolean: true,
        ),
      ],
    );
  }
}
