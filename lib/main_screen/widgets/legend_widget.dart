import 'package:cis_game/dialogs/not_enough_cash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../classes/seed_type.dart';
import '../../dialogs/plant_all_selected_fields_dialog.dart';
import '../../state_management/game_data_notifier.dart';

class AnimalLegend extends ConsumerWidget {
  final SeedType legendSeedType;
  const AnimalLegend({
    super.key,
    required this.legendSeedType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () async {
          int emptyFieldsCount =
              ref.read(gameDataNotifierProvider.notifier).selectAllEmptyFields(legendSeedType);

          if (emptyFieldsCount > 0) {
            // check if enough cash to plant all empty fields
            if (ref
                .read(gameDataNotifierProvider.notifier)
                .enoughCashForSelectedFields(legendSeedType)) {
              // if not show NotEnoughCash Dialog and unselect fields
              // else plant empty fields
              bool shouldPlant = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return PlantAllSelectedFieldsDialog(
                      emptyFieldsCount: emptyFieldsCount,
                      selectedSeedType: legendSeedType,
                    );
                  });
              if (shouldPlant) {
                ref.read(gameDataNotifierProvider.notifier).plantAllSelectedFields(legendSeedType);
              } else {
                ref.read(gameDataNotifierProvider.notifier).unselectAllSelectedFields();
              }
            }
            // if not enough cash - deselect
            else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const NotEnoughCash();
                  });
              ref.read(gameDataNotifierProvider.notifier).unselectAllSelectedFields();
            }
          }
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
                    child: Image.asset('assets/images/${legendSeedType.animalImage}'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset('assets/images/${legendSeedType.rainImage}'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
