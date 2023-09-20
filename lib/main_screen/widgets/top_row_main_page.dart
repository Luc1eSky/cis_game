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
      children: [
        const Spacer(),
        Expanded(
          flex: 15,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  Text(
                    'Participant: ${ref.watch(gameDataNotifierProvider).currentCouple.currentPlayer?.formattedID ?? ""}',
                    style: const TextStyle(fontSize: 100),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              child: Text(
                'Season: ${ref.watch(gameDataNotifierProvider).season}',
                style: const TextStyle(fontSize: 100),
              ),
            ),
          ),
        ),
        const Spacer(),

        // const Padding(
        //   padding: EdgeInsets.only(left: 15.0),
        //   child: FittedBox(
        //     child: Text(
        //       'Participant: John Doe',
        //       style: TextStyle(fontSize: 100),
        //     ),
        //   ),
        // ),
        // const Spacer(),
        // Padding(
        //   padding: const EdgeInsets.only(right: 15.0),
        //   child: FittedBox(
        //     child: Text(
        //       "Season: ${ref.watch(gameDataNotifierProvider).season}",
        //       style: const TextStyle(fontSize: 100),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
