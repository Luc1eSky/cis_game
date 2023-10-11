import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../classes/field.dart';
import '../../classes/seed_type.dart';
import '../../color_palette.dart';
import '../../constants.dart';
import '../../dialogs/seed_selection_dialog.dart';
import '../../state_management/game_data_notifier.dart';

class FieldWidget extends ConsumerWidget {
  const FieldWidget({
    required this.fieldID,
    required this.seedType,
    required this.fieldStatus,
    this.isDemoOnly = false,
    super.key,
  });

  final int fieldID;
  final SeedType seedType;
  final FieldStatus fieldStatus;
  final bool isDemoOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color fieldWidgetColor = ColorPalette().fieldColorEmpty;
    switch (fieldStatus) {
      case FieldStatus.empty:
        break;
      case FieldStatus.selected:
        break;
      case FieldStatus.seeded:
        fieldWidgetColor = ColorPalette().fieldColorSeeded;
        break;
      case FieldStatus.grown:
        fieldWidgetColor = ColorPalette().fieldColorSeeded;
        break;
      case FieldStatus.harvested:
        fieldWidgetColor = ColorPalette().fieldColorHarvested;
        break;
    }

    return GestureDetector(
      onTap: isDemoOnly
          ? null
          : () async {
              bool buySeed = await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return SeedSelectionDialog(fieldIndex: fieldID);
                  });
              if (buySeed) {
                ref.read(gameDataNotifierProvider.notifier).selectSeedTypeAndBuySeed(fieldID);
              }
            },
      child: LayoutBuilder(
        builder: (context, constraints) {
          //return RiveAnimation.asset('assets/rive/maize.riv');
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: fieldWidgetColor,
                  border: fieldStatus == FieldStatus.empty
                      ? Border.all(width: 0.0)
                      : Border.all(color: seedType.seedColor, width: constraints.maxWidth * 0.05),
                  borderRadius: BorderRadius.circular(constraints.maxWidth * 0.1),
                ),
                child: fieldStatus == FieldStatus.harvested
                    ? Center(
                        child: FittedBox(
                          child: Text(
                            ref.read(gameDataNotifierProvider).currentLevel.isRaining
                                ? '${seedType.yieldRain}\nkwacha'
                                : '${seedType.yieldNoRain}\nkwacha',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : fieldStatus == FieldStatus.empty || fieldStatus == FieldStatus.selected
                        ? Container()
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                            itemCount: 25,
                            itemBuilder: (context, index) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return Center(
                                    child: AnimatedContainer(
                                      height: fieldStatus == FieldStatus.seeded
                                          // initial size of the dots on the field
                                          ? constraints.maxHeight * 0.40
                                          : ref
                                                  .read(gameDataNotifierProvider)
                                                  .currentLevel
                                                  .isRaining
                                              // size of dots when it rains
                                              ? constraints.maxHeight * 0.80
                                              // size of dots when it does not rain
                                              : constraints.maxHeight * 0.50,
                                      duration:
                                          const Duration(milliseconds: growingAnimationTimeInMs),
                                      //curve: Curves.easeInOut,
                                      decoration: BoxDecoration(
                                        color: fieldStatus == FieldStatus.seeded
                                            ? Colors.brown
                                            : ref
                                                    .read(gameDataNotifierProvider)
                                                    .currentLevel
                                                    .isRaining
                                                ? Colors.lightGreen[800]
                                                : Colors.lightGreen[300],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
              ),
              // show animal picture during seeded phase
              if (seedType.animalImage.isNotEmpty && fieldStatus == FieldStatus.seeded)
                Center(
                  child: SizedBox(
                    height: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth * 0.5,
                    child: Image.asset('assets/images/${seedType.animalImage}'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
