import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        // const SizedBox(width: 32),
        // Expanded(
        //   flex: 11,
        //   child: FittedBox(
        //     alignment: Alignment.centerLeft,
        //     child: Text(
        //       ref.watch(gameDataNotifierProvider).isInPracticeMode
        //           ? ' '
        //           : 'Participant: ${ref.watch(gameDataNotifierProvider).currentCouple.currentPlayer?.formattedID ?? ""}',
        //       style: const TextStyle(fontSize: 100),
        //     ),
        //   ),
        // ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: ForecastWidget(),
          ),
        ),
      ],
    );
  }
}
