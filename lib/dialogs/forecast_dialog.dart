import 'dart:math';

import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../main_screen/widgets/forecast_widget.dart';
import '../state_management/game_data_notifier.dart';

class ForecastDialog extends ConsumerWidget {
  const ForecastDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double dialogHeight = min(MediaQuery.of(context).size.height, forecastDialogMaxHeight);
    return SizedBox(
      height: dialogHeight,
      child: DialogTemplate(
        title: const Text(
          'Weather Forecast',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            ref.read(gameDataNotifierProvider).currentLevel.rainForecast == null
                ? Image.asset('assets/images/tv_no_forecast.png')
                : Image.asset('assets/images/tv_forecast_background.png'),
            AspectRatio(
              aspectRatio: 1.3,
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Expanded(
                    flex: 3,
                    child: ForecastWidget(),
                  ),
                  const Spacer(flex: 5),
                  ref.read(gameDataNotifierProvider).currentLevel.plantingAdvice != null
                      ? Expanded(
                          flex: 1,
                          child: FractionallySizedBox(
                            widthFactor: 0.4,
                            child: FittedBox(
                              child: Text(
                                ref.read(gameDataNotifierProvider).currentLevel.plantingAdvice!,
                                style: const TextStyle(
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Spacer(flex: 1),
                  const Spacer(flex: 4),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              ref.read(gameDataNotifierProvider.notifier).setSeasonToCurrent();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
