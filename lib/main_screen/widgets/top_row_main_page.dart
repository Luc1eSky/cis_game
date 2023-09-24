import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/game_data_notifier.dart';

class TopRowMainPage extends ConsumerWidget {
  const TopRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          child: IconButton(
            iconSize: 100,
            onPressed: () {
              // TODO: OPEN SETTINGS TO CHANGE PARTICIPANT
              print('Icon pressed');
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return Container();
              //     });
            },
            icon: const Icon(Icons.settings),
          ),
        ),
        Expanded(
          flex: 11,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const SizedBox(width: 10),
                FittedBox(
                  child: Text(
                    ref.watch(gameDataNotifierProvider).isInPracticeMode
                        ? 'Practice Mode'
                        : 'Enumerator: ${ref.watch(gameDataNotifierProvider).currentEnumerator?.firstName ?? ""}',
                    style: const TextStyle(fontSize: 100),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: FittedBox(
            alignment: Alignment.centerRight,
            child: Text(
              'Season: ${ref.watch(gameDataNotifierProvider).season}',
              style: const TextStyle(fontSize: 100),
            ),
          ),
        ),
      ],
    );
  }
}
