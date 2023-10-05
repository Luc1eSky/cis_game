import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../color_palette.dart';
import '../../state_management/game_data_notifier.dart';

class SavingsWidget extends ConsumerWidget {
  const SavingsWidget({
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
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundColor: ColorPalette().plusMinusButtonColor,
                radius: 500,
                child: FittedBox(
                  child: IconButton(
                    iconSize: 100,
                    color: ColorPalette().iconColor,
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      ref
                          .read(gameDataNotifierProvider.notifier)
                          .savingsToCash();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: AspectRatio(
                        aspectRatio: 2.0,
                        child: Image.asset('assets/images/cash_box.png')),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      child: Text(
                        'ZK${ref.watch(gameDataNotifierProvider).savings}',
                        style: const TextStyle(fontSize: 100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundColor:
                    ref.watch(gameDataNotifierProvider).allSeededAndCashLeft
                        ? Colors.lightGreen
                        : ColorPalette().plusMinusButtonColor,
                radius: 500,
                child: FittedBox(
                  child: IconButton(
                    iconSize: 100,
                    color: ColorPalette().iconColor,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      ref.read(gameDataNotifierProvider.notifier).cashToSavings(
                          transferAll: ref
                              .read(gameDataNotifierProvider)
                              .allSeededAndCashLeft);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
