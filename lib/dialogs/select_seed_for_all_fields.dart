import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/seed_type.dart';
import 'dialog_template.dart';

class PlantAllFieldDialog extends ConsumerWidget {
  final SeedType selectedSeedType;
  const PlantAllFieldDialog({super.key, required this.selectedSeedType});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DialogTemplate(
      content: const SizedBox(
        width: 50,
        child: Text(
          "Plant all empty fields",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No, go back'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            ref
                .read(gameDataNotifierProvider.notifier)
                .plantAllFields(selectedSeedType);
            // print('Print from Dialog');
            // print(selectedSeedType.animalName);
          },
          child: const Text('Plant all fields'),
        ),
      ],
    );
  }
}
