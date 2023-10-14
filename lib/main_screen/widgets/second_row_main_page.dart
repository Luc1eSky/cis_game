import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../state_management/game_data_notifier.dart';
import 'forecast_widget.dart';

class SecondRowMainPage extends ConsumerWidget {
  const SecondRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FractionallySizedBox(
            heightFactor: 0.4,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'V$appVersion / '
                'Level ${ref.watch(gameDataNotifierProvider).currentLevel.levelID}',
                style: const TextStyle(fontSize: 100, color: Colors.red),
              ),
            ),
          ),
        ),
        const Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: ForecastWidget(),
          ),
        ),
      ],
    );
  }
}
