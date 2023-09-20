import 'package:cis_game/constants.dart';
import 'package:cis_game/main_screen/widgets/field_widget.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../color_palette.dart';
import 'legend_widget.dart';

class FieldsMainPage extends ConsumerWidget {
  const FieldsMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int fieldsPerRow = (numberOfFields / numberOfFieldRows).round();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Spacer(),
        // Expanded(
        //   flex: 12,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: ColorPalette().fieldBackground,
        //       borderRadius: const BorderRadius.all(
        //         Radius.circular(10),
        //       ),
        //     ),
        //     child: Column(
        //       children: [
        //         const Spacer(),
        //         Expanded(
        //           flex: 4,
        //           child: Row(
        //             // creates row with list of fields
        //             children: topRowList,
        //           ),
        //         ),
        //         const Spacer(),
        //         Expanded(
        //           flex: 4,
        //           child: Row(
        //             children: bottomRowList,
        //           ),
        //         ),
        //         const Spacer(),
        //       ],
        //     ),
        //   ),
        // ),
        // const Spacer(),
        Expanded(
          child: Container(
            //color: Colors.blue,
            child: Align(
              alignment: Alignment.centerRight,
              child: AspectRatio(
                aspectRatio: fieldsPerRow / numberOfFieldRows,
                child: LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    color: ColorPalette().fieldBackground,
                    child: GridView.count(
                      crossAxisCount: fieldsPerRow,
                      children: List.generate(
                        numberOfFields,
                        (index) => FractionallySizedBox(
                          widthFactor: 0.8,
                          heightFactor: 0.8,
                          child: FieldWidget(
                            fieldID: index,
                            fieldStatus: ref
                                .watch(gameDataNotifierProvider)
                                .currentFieldList[index]
                                .fieldStatus,
                            seedType: ref
                                .watch(gameDataNotifierProvider)
                                .currentFieldList[index]
                                .seedType,
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: ColorPalette().fieldBackground,
                          //     borderRadius: BorderRadius.all(
                          //       Radius.circular(constraints.maxHeight * 0.05),
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 0.55,
          child: Container(
            //color: Colors.green,
            child: FractionallySizedBox(
              widthFactor: 0.7,
              heightFactor: 0.8,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: AnimalLegend(
                      color: ColorPalette().seedEarlyMaturing,
                      animalString: 'zebra',
                      rainDropString: 'drop',
                      price: 2,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: AnimalLegend(
                      color: ColorPalette().seedNormalMaturing,
                      animalString: 'lion',
                      rainDropString: 'drops',
                      price: 3,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 3,
                    child: AnimalLegend(
                      color: ColorPalette().seedNormalMaturingHighYield,
                      animalString: 'elephant',
                      rainDropString: 'dropsandplus',
                      price: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //const Spacer(),
      ],
    );
  }
}
