import 'package:cis_game/classes/seed_type.dart';
import 'package:cis_game/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main_screen/widgets/interaction_button.dart';
import 'dialog_template.dart';

class PlantAllSelectedFieldsDialog extends ConsumerWidget {
  const PlantAllSelectedFieldsDialog({
    super.key,
    required this.emptyFieldsCount,
    required this.selectedSeedType,
  });

  final int emptyFieldsCount;
  final SeedType selectedSeedType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogTemplate(
      content: SizedBox(
        height: 100,
        width: 400,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$emptyFieldsCount x',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(width: 10),
              Image.asset('assets/images/${selectedSeedType.animalImage}'),
              const SizedBox(width: 10),
              Text(
                '= ${emptyFieldsCount * selectedSeedType.price} $currency',
                style: const TextStyle(fontSize: 25),
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
