import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import 'forecast_widget.dart';

class SecondRowMainPage extends ConsumerWidget {
  const SecondRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FractionallySizedBox(
            heightFactor: 0.4,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'V$appVersion',
                style: TextStyle(fontSize: 100),
              ),
            ),
          ),
        ),
        Expanded(
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
