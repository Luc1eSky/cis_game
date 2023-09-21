import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../classes/field.dart';
import '../../color_palette.dart';
import '../../constants.dart';
import '../../dialogs/seed_selection_dialog.dart';
import '../../state_management/game_data_notifier.dart';

class FieldWidget extends ConsumerWidget {
  final int fieldID;
  final SeedType? seedType;
  final FieldStatus fieldStatus;
  const FieldWidget({
    required this.fieldID,
    this.seedType,
    required this.fieldStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color fieldWidgetColor = ColorPalette().fieldColorEmpty;
    switch (fieldStatus) {
      case FieldStatus.empty:
        break;
      case FieldStatus.seeded:
        fieldWidgetColor = ColorPalette().fieldColorSeeded;
        break;
      case FieldStatus.harvested:
        fieldWidgetColor = ColorPalette().fieldColorGrown;
        break;
      // if there is no field status provided
      default:
        break;
    }

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return SeedSelectionDialog(fieldIndex: fieldID);
            });
      },

      child: LayoutBuilder(builder: (context, constraints) {
        //return RiveAnimation.asset('assets/rive/maize.riv');
        return Container(
          decoration: BoxDecoration(
            color: fieldWidgetColor,
            border: seedType == null
                ? Border.all(width: 0.0)
                : Border.all(color: seedType!.seedColor, width: constraints.maxWidth * 0.05),
            borderRadius: BorderRadius.circular(constraints.maxWidth * 0.1),
          ),
          child: fieldStatus == FieldStatus.harvested
              ? Center(
                  child: Text(ref.read(gameDataNotifierProvider).currentLevel.isRaining
                      ? '${seedType!.yieldRain} kwacha'
                      : '${seedType!.yieldNoRain} kwacha'),
                )
              : fieldStatus == FieldStatus.empty
                  ? Container()
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        return LayoutBuilder(builder: (context, constraints) {
                          return Center(
                            child: AnimatedContainer(
                              height: fieldStatus == FieldStatus.seeded
                                  ? constraints.maxHeight * 0.45
                                  : ref.read(gameDataNotifierProvider).currentLevel.isRaining
                                      ? constraints.maxHeight * 0.75
                                      : constraints.maxHeight * 0.55,
                              duration: const Duration(milliseconds: growingAnimationTimeInMs),
                              //curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: fieldStatus == FieldStatus.seeded
                                    ? Colors.brown
                                    : ref.read(gameDataNotifierProvider).currentLevel.isRaining
                                        ? Colors.green
                                        : Colors.lightGreenAccent.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        });
                      }),
        );
      }),

      // fieldStatus == FieldStatus.seeded
      //     ? Container(
      //         decoration: BoxDecoration(
      //           color: fieldWidgetColor,
      //           border: seedType == null
      //               ? Border.all(width: 0.0)
      //               : Border.all(color: seedType!.seedColor, width: 5.0),
      //         ),
      //         child: GridView.builder(
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      //             itemCount: 100,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 decoration: const BoxDecoration(
      //                   color: Colors.brown,
      //                   shape: BoxShape.circle,
      //                 ),
      //               );
      //             }),
      //       )
      //     : fieldStatus == FieldStatus.harvested
      //         ? Container(
      //             decoration: BoxDecoration(
      //                 color: fieldWidgetColor,
      //                 border: Border.all(color: seedType!.seedColor, width: 5.0)),
      //             child: Center(
      //               child: Text(ref.read(gameDataNotifierProvider).currentLevel.isRaining
      //                   ? '${seedType!.yieldRain} kwacha'
      //                   : '${seedType!.yieldNoRain} kwacha'),
      //             ),
      //           )
      //         : Container(
      //             decoration: BoxDecoration(
      //               color: fieldWidgetColor,
      //               //borderRadius: const BorderRadius.all(Radius.circular(10)),
      //               border: seedType == null
      //                   ? Border.all(width: 0.0)
      //                   : Border.all(color: seedType!.seedColor, width: 5.0),
      //             ),
      //           ),
    );
  }
}
