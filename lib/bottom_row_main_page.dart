import 'package:cis_game/savings_widget.dart';
import 'package:cis_game/summary_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cash_widget.dart';
import 'color_palette.dart';
import 'game_data_notifier.dart';

class BottomRowMainPage extends ConsumerWidget {
  const BottomRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 6,
      child: Row(
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
                        ref
                            .read(gameDataNotifierProvider.notifier)
                            .harvestFields();
                        //print('before delay');
                        // add delay before displaying summary
                        await Future.delayed(const Duration(seconds: 2));
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                                title: Text("Summary Page"),
                                content: SummaryPage());
                          },
                        );
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
      ),
    );
  }
}
