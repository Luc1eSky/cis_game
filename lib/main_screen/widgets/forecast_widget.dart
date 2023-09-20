import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../state_management/game_data_notifier.dart';

class ForecastWidget extends ConsumerWidget {
  const ForecastWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int? currentForecast = ref.watch(gameDataNotifierProvider).currentLevel.rainForecast;
    if (currentForecast == null) {
      return Container();
    }

    List<Widget> cloudList = List.generate(
      maxNumberForecast,
      (i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Icon(
          i < currentForecast ? Icons.cloudy_snowing : Icons.cloud,
          color: i < currentForecast ? Colors.blue : Colors.white,
          size: 100,
        ),
      ),
    );

    return FractionallySizedBox(
      widthFactor: 0.6,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cloudList,
        ),
      ),
    );
  }
}
