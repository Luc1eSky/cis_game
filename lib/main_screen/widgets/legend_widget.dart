import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../classes/seed_type.dart';
import '../../dialogs/select_seed_for_all_fields.dart';

class AnimalLegend extends ConsumerWidget {
  final SeedType legendSeedType;
  const AnimalLegend({
    super.key,
    required this.legendSeedType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () {
          // print animal name that was selected
          //print(legendSeedType.animalName);
          showDialog(
              context: context,
              builder: (context) {
                return PlantAllFieldDialog(
                  selectedSeedType: legendSeedType,
                );
              });
        },
        child: AspectRatio(
          aspectRatio: 1.6,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: legendSeedType.seedColor,
            ),
            child: FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.8,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                        'assets/images/${legendSeedType.animalImage}'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                        'assets/images/${legendSeedType.rainImage}'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
