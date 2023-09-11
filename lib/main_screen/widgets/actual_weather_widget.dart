import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../state_management/game_data_notifier.dart';

class ActualWeatherWidget extends ConsumerWidget {
  const ActualWeatherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? actualWeather =
        ref.watch(gameDataNotifierProvider).currentLevel.rainActual;

    List<Widget> cloudList = List.generate(
      maxNumberForecast,
      (i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: FittedBox(
          child: Icon(
            i < actualWeather ? Icons.cloudy_snowing : Icons.cloud,
            color: i < actualWeather ? Colors.blue : Colors.white,
            size: 100,
          ),
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cloudList,
    );
  }
}
