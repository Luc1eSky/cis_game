import 'package:cis_game/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'color_palette.dart';
import 'constants.dart';
import 'custom_pattern_seeded.dart';
import 'field.dart';

class FieldWidget extends ConsumerWidget {
  final SeedType? seedType;
  final FieldStatus fieldStatus;
  const FieldWidget({
    super.key,
    this.seedType,
    required this.fieldStatus,
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

    return fieldStatus == FieldStatus.seeded
        ? CustomPaint(
            painter: ContainerPatternPainter(),
            child: Container(
              decoration: BoxDecoration(
                //borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: seedType == null
                    ? Border.all(width: 0.0)
                    : Border.all(color: seedType!.seedColor, width: 5.0),
              ),
            ),
          )
        : fieldStatus == FieldStatus.harvested
            ? Container(
                decoration: BoxDecoration(
                    color: fieldWidgetColor,
                    border: Border.all(color: seedType!.seedColor, width: 5.0)),
                child: Center(
                  child: Text(
                      // based on the forecast return high or low yield
                      // Todo: Need to be changed to be based on actual weather
                      //  event
                      ref.read(gameDataNotifierProvider).currentForecast <
                              thresholdLowRain
                          ? '${seedType!.yieldLowRain} kwacha'
                          : '${seedType!.yieldHighRain} kwacha'),
                ))
            : Container(
                decoration: BoxDecoration(
                  color: fieldWidgetColor,
                  //borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: seedType == null
                      ? Border.all(width: 0.0)
                      : Border.all(color: seedType!.seedColor, width: 5.0),
                ),
              );
  }
}
