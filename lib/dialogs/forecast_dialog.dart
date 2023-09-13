import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main_screen/widgets/forecast_widget.dart';
import '../state_management/game_data_notifier.dart';

class ForecastDialog extends ConsumerWidget {
  const ForecastDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text(
        'Weather Forecast',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      content: Stack(
        children: [
          Center(
            // check if there is a forecast or not and display weather presenter accordingly
            child:
                ref.read(gameDataNotifierProvider).currentLevel.rainForecast ==
                        null
                    ? Image.asset('assets/images/tv_no_forecast.png')
                    : Image.asset('assets/images/tv_forecast_background.png'),
          ),
          Positioned.fill(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1.6,
                child: Column(
                  children: [
                    const Spacer(),
                    const Expanded(
                      flex: 3,
                      child: ForecastWidget(),
                    ),
                    const Spacer(flex: 6),
                    ref
                                .read(gameDataNotifierProvider)
                                .currentLevel
                                .plantingAdvice !=
                            null
                        ? Expanded(
                            flex: 4,
                            child: Text(
                              ref
                                  .read(gameDataNotifierProvider)
                                  .currentLevel
                                  .plantingAdvice!,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          )
                        : const Spacer(flex: 4),
                    const Spacer(),
                  ],
                ),
              ),
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
    );
  }
}
