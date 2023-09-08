import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state_management/game_data_notifier.dart';

class ForecastDialog extends ConsumerWidget {
  const ForecastDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Weather Forecast'),
      content: Image.asset('assets/images/tv_forecast.png'),
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
