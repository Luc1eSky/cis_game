import 'package:cis_game/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../color_palette.dart';
import '../../state_management/game_data_notifier.dart';

class CashWidget extends ConsumerWidget {
  const CashWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: ColorPalette().tileColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: FractionallySizedBox(
        heightFactor: 0.8,
        widthFactor: 0.8,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child:
                  AspectRatio(aspectRatio: 2.0, child: Image.asset('assets/images/K100_note.jpeg')),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: FittedBox(
                child: Text(
                  '${ref.watch(gameDataNotifierProvider).cash} $currency',
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
