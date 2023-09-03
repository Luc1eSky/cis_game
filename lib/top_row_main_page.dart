import 'package:cis_game/game_data_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopRowMainPage extends ConsumerWidget {
  const TopRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: FittedBox(
            child: Text(
              'Participant: John Doe',
              style: TextStyle(fontSize: 100),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: FittedBox(
            child: Text(
              "Season: ${ref.watch(gameDataNotifierProvider).season}",
              style: const TextStyle(fontSize: 100),
            ),
          ),
        ),
      ],
    );
  }
}
