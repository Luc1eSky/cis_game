import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main_screen/widgets/forecast_widget.dart';
import '../state_management/game_data_notifier.dart';

class ForecastDialog extends ConsumerWidget {
  const ForecastDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Weather Forecast'),
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
                aspectRatio: 1.4,
                child: Column(
                  children: const [
                    Spacer(),
                    Expanded(child: ForecastWidget()),
                    Spacer(flex: 4),
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
