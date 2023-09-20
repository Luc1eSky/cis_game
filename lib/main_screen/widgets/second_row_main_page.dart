import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/game_data_notifier.dart';

class SecondRowMainPage extends ConsumerWidget {
  const SecondRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 44),
        Expanded(
          flex: 11,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              'Participant: ${ref.watch(gameDataNotifierProvider).currentCouple.currentPlayer?.formattedID ?? ""}',
              style: const TextStyle(fontSize: 100),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: FittedBox(
            alignment: Alignment.centerRight,
          ),
        ),
      ],
    );
  }
}
