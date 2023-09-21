import 'dart:math';

import 'package:cis_game/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../color_palette.dart';
import '../../state_management/game_data_notifier.dart';
import 'field_widget.dart';
import 'legend_widget.dart';

class FieldsMainPage extends ConsumerWidget {
  const FieldsMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      // fixed legend width
      double legendWidth = maxHeight * legendAspectRatio;
      // field area widths depending if screen limits its size
      double fieldAreaWidthUnrestricted = maxHeight * fieldAreaAspectRatio;
      double fieldAreaWidthRestricted = maxWidth - legendWidth;
      // use smaller width as the actual width for widget
      double actualFieldAreaWidth = min(fieldAreaWidthUnrestricted, fieldAreaWidthRestricted);

      double theoreticalAreaHeight = maxWidth / fieldAreaAspectRatio;

      double availableVerticalSpace = maxHeight - theoreticalAreaHeight;

      // print('maxHeight: $maxHeight');
      // print('theoreticalAreaHeight: $theoreticalAreaHeight');
      // print('availableVerticalSpace: $availableVerticalSpace');
      // print('-----');

      if (availableVerticalSpace > 85) {
        return Container(
          //color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FieldAreaWidget(
                actualFieldAreaWidth: actualFieldAreaWidth,
              ),
              Container(
                height: 85,
                //color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AnimalLegend(
                          color: ColorPalette().seedEarlyMaturing,
                          animalString: 'zebra',
                          rainDropString: 'drop',
                          price: 2,
                        ),
                        //const Spacer(),
                        AnimalLegend(
                          color: ColorPalette().seedNormalMaturing,
                          animalString: 'lion',
                          rainDropString: 'drops',
                          price: 3,
                        ),
                        //const Spacer(),
                        AnimalLegend(
                          color: ColorPalette().seedNormalMaturingHighYield,
                          animalString: 'elephant',
                          rainDropString: 'dropsandplus',
                          price: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //color: Colors.blue,
              width: actualFieldAreaWidth,
              child: Center(
                child: FieldAreaWidget(
                  actualFieldAreaWidth: actualFieldAreaWidth,
                ),
              ),
            ),
            SizedBox(
              width: legendWidth,
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ],
        );
      }
    });
  }
}

class FieldAreaWidget extends ConsumerWidget {
  const FieldAreaWidget({
    super.key,
    required this.actualFieldAreaWidth,
  });

  final double actualFieldAreaWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette().fieldBackground,
        borderRadius: BorderRadius.circular(actualFieldAreaWidth * 0.03),
      ),
      child: AspectRatio(
        aspectRatio: fieldAreaAspectRatio,
        child: GridView.count(
          crossAxisCount: fieldsPerRow,
          children: List.generate(
            numberOfFields,
            (index) => FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.8,
              child: FieldWidget(
                fieldID: index,
                fieldStatus:
                    ref.watch(gameDataNotifierProvider).currentFieldList[index].fieldStatus,
                seedType: ref.watch(gameDataNotifierProvider).currentFieldList[index].seedType,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
