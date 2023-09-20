import 'package:cis_game/constants.dart';
import 'package:cis_game/dialogs/season_summary_dialog.dart';
import 'package:cis_game/main_screen/widgets/savings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../color_palette.dart';
import '../../state_management/game_data_notifier.dart';
import 'cash_widget.dart';

class BottomRowMainPage extends ConsumerWidget {
  const BottomRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Expanded(
          flex: 3,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.8,
            child: CashWidget(),
          ),
        ),
        const Expanded(
          flex: 3,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.8,
            child: SavingsWidget(),
          ),
        ),
        Expanded(
          flex: 2,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.8,
            child: Center(
              child: FittedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    if (ref.read(gameDataNotifierProvider).cash > 0) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Warning"),
                              content: Text('Please use or '
                                  'save all '
                                  'cash'),
                            );
                          });
                    } else {
                      ref.read(gameDataNotifierProvider.notifier).checkIfLastLevelWasPlayed();

                      ref.read(gameDataNotifierProvider.notifier).randomizeWeatherEvent();

                      ref.read(gameDataNotifierProvider.notifier).saveResult();

                      // show weather animation and wait until it is done
                      await ref.read(gameDataNotifierProvider.notifier).showWeatherAnimation();

                      // show growing animation and wait until it is done
                      await ref.read(gameDataNotifierProvider.notifier).showGrowingAnimation();

                      await Future.delayed(
                        const Duration(milliseconds: pauseAfterGrowingAnimationInMs),
                      );

                      //ref.read(gameDataNotifierProvider.notifier).harvestFields();

                      if (context.mounted) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return const SeasonSummaryDialog();
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: const CircleBorder(),
                    //padding: const EdgeInsets.all(10),
                    backgroundColor: ColorPalette().plantButton,
                  ),
                  child: Image.asset('assets/images/planting_seed.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
