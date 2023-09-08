import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/couple.dart';

class HusbandOrWifeDialog extends ConsumerWidget {
  final Couple couple;
  const HusbandOrWifeDialog({required this.couple, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('Couple ${couple.coupleID}'),
      content: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                ref
                    .read(gameDataNotifierProvider.notifier)
                    .changePlayer(newPlayer: CurrentPlayer.wife);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Wife'),
                    const SizedBox(height: 10),
                    Text(couple.wifeID),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                ref
                    .read(gameDataNotifierProvider.notifier)
                    .changePlayer(newPlayer: CurrentPlayer.husband);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Husband'),
                    const SizedBox(height: 10),
                    Text(couple.wifeID),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: const Text('Back'),
        // ),
      ],
    );
  }
}
