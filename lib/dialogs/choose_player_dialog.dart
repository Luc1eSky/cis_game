import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/couple.dart';

class ChoosePlayerDialog extends ConsumerWidget {
  const ChoosePlayerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Couple currentCouple = ref.read(gameDataNotifierProvider).currentCouple;
    return AlertDialog(
      //title: Text('Couple ${currentCouple.both.formattedID}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: ref.read(gameDataNotifierProvider).currentCouple.coupleCanPlay
                      ? () {
                          ref
                              .read(gameDataNotifierProvider.notifier)
                              .changePlayer(newPlayerType: PlayerType.both);
                          Navigator.of(context).pop();
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Couple'),
                        const SizedBox(height: 10),
                        Text(currentCouple.both.formattedID),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: ref.read(gameDataNotifierProvider).currentCouple.wife.hasPlayed
                      ? null
                      : () {
                          ref
                              .read(gameDataNotifierProvider.notifier)
                              .changePlayer(newPlayerType: PlayerType.wife);
                          Navigator.of(context).pop();
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Wife'),
                        const SizedBox(height: 10),
                        Text(currentCouple.wife.formattedID),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: ref.read(gameDataNotifierProvider).currentCouple.husband.hasPlayed
                      ? null
                      : () {
                          ref
                              .read(gameDataNotifierProvider.notifier)
                              .changePlayer(newPlayerType: PlayerType.husband);
                          Navigator.of(context).pop();
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Husband'),
                        const SizedBox(height: 10),
                        Text(currentCouple.husband.formattedID),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      //actions: <Widget>[
      // ElevatedButton(
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   child: const Text('Back'),
      // ),
      //],
    );
  }
}
