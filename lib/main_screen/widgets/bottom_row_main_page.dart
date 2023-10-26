import 'package:cis_game/constants.dart';
import 'package:cis_game/dialogs/season_summary_dialog.dart';
import 'package:cis_game/dialogs/warning_use_cash_dialog.dart';
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
                  onPressed: ref
                          .watch(gameDataNotifierProvider)
                          .buttonsAreActive
                      ? () async {
                          if (ref.read(gameDataNotifierProvider).cash > 0) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const WarningUseCashDialog();
                                });
                          } else {
                            bool inPracticeMode = ref
                                .read(gameDataNotifierProvider)
                                .isInPracticeMode;
                            ref
                                .read(gameDataNotifierProvider.notifier)
                                .disableButtons();

                            // simulate if it is raining or not
                            ref
                                .read(gameDataNotifierProvider.notifier)
                                .randomizeWeatherEvent();

                            // save the results based on the fields and the weather
                            ref
                                .read(gameDataNotifierProvider.notifier)
                                .saveResult();

                            //ref.read(gameDataNotifierProvider.notifier).printPlayerResults();

                            // show weather animation and wait until it is done
                            await ref
                                .read(gameDataNotifierProvider.notifier)
                                .showWeatherAnimation();

                            // check if something has been planted
                            if (ref.read(gameDataNotifierProvider).total[0] >
                                0) {
                              // show growing animation and wait until it is done
                              await ref
                                  .read(gameDataNotifierProvider.notifier)
                                  .showGrowingAnimation();

                              // slow animation down in practice mode

                              double slowDown = inPracticeMode
                                  ? practiceModeSlowDownFactor
                                  : 1.0;

                              await Future.delayed(Duration(
                                  milliseconds:
                                      (pauseAfterGrowingAnimationInMs *
                                              slowDown)
                                          .toInt()));

                              ref
                                  .read(gameDataNotifierProvider.notifier)
                                  .harvestFields();

                              await Future.delayed(Duration(
                                  milliseconds:
                                      (pauseAfterHarvestShownOnFieldInMs *
                                              slowDown)
                                          .toInt()));
                            }

                            // check if he last level was played by current player
                            ref
                                .read(gameDataNotifierProvider.notifier)
                                .checkIfLastLevelWasPlayed();

                            // open the season summary dialog
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
                        }
                      : null,
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
