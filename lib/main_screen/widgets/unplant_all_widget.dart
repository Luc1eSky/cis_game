import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dialogs/unplant_all_seeded_fields.dart';

class UnplantAllWidget extends ConsumerWidget {
  const UnplantAllWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameDataNotifier = ref.read(gameDataNotifierProvider.notifier);
    return GestureDetector(
      onTap: () async {
        int seededFieldCount = gameDataNotifier.countSeededFields();
        if (seededFieldCount > 0) {
          // ask user to unplant all planted fields
          bool shouldUnplant = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return UnplantAllSeededFieldsDialog(fieldCount: seededFieldCount);
              });
          if (shouldUnplant) {
            gameDataNotifier.unplantAllFields();
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.blueGrey[200],
          ),
          child: const FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 0.7,
            child: FittedBox(
              child: Icon(
                Icons.close,
                size: 200,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
