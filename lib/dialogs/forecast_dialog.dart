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
    var notifier = ref.read(gameDataNotifierProvider.notifier);
    var gameDataNotifier = ref.read(gameDataNotifierProvider);
    double dialogHeight =
        min(MediaQuery.of(context).size.height, forecastDialogMaxHeight);
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
            gameDataNotifier.currentLevel.rainForecast == null
                ? Image.asset('assets/images/tv_no_forecast.png')
                : Image.asset('assets/images/tv_forecast_background.png'),
            AspectRatio(
              aspectRatio: 1.3,
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  const Expanded(
                    flex: 3,
                    child: ForecastWidget(),
                  ),
                  const Spacer(flex: 2),
                  gameDataNotifier.currentLevel.plantingAdvice == true &&
                          notifier.getAnimalRiskHigh() != null &&
                          notifier.getAnimalLowHigh() != null
                      ? Expanded(
                          flex: 6,
                          child: FractionallySizedBox(
                            widthFactor: 0.4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AdviceWidget(
                                      adviceImageName: 'speedometer_high.png',
                                      animalImageName:
                                          notifier.getAnimalRiskHigh()!,
                                    ),
                                  ),
                                  Expanded(
                                    child: AdviceWidget(
                                      adviceImageName: 'speedometer_low.png',
                                      animalImageName:
                                          notifier.getAnimalLowHigh()!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Spacer(flex: 6),
                  const Spacer(flex: 5),
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

class AdviceWidget extends StatelessWidget {
  const AdviceWidget({
    required this.animalImageName,
    required this.adviceImageName,
    super.key,
  });

  final String animalImageName;
  final String adviceImageName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            //color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/$adviceImageName'),
            ),
          ),
        ),
        Expanded(
          child: Container(
            //color: Colors.pink,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/$animalImageName'),
            ),
          ),
        ),
      ],
    );
  }
}
