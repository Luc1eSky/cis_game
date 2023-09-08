import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/dialogs/select_new_couple_dialog.dart';
import 'package:cis_game/main_screen/widgets/top_row_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../color_palette.dart';
import '../dialogs/forecast_dialog.dart';
import '../state_management/game_data_notifier.dart';
import 'main_screen_logic.dart';
import 'widgets/bottom_row_main_page.dart';
import 'widgets/fields_main_page.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.watch(gameDataNotifierProvider).currentCouple.currentPlayer == CurrentPlayer.none) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const SelectNewCoupleDialog();
            });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fullWidgetList = createFieldWidgets(ref.watch(gameDataNotifierProvider).fieldList);
    int topRowLength = fullWidgetList.length ~/ 2;
    List<Widget> topRowList = fullWidgetList.sublist(0, topRowLength);
    topRowList.add(const Spacer());
    List<Widget> bottomRowList = fullWidgetList.sublist(topRowLength);

    return Scaffold(
      backgroundColor: ColorPalette().backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: TopRowMainPage(),
                ),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: createForecastWidgets(
                          ref.watch(gameDataNotifierProvider).currentLevel.rainForecast),
                    ),
                  ),
                ),
                FieldsMainPage(topRowList: topRowList, bottomRowList: bottomRowList),
                const Spacer(),
                const BottomRowMainPage(),
              ],
            ),
            if (ref.watch(gameDataNotifierProvider).isNewSeason == true &&
                ref.watch(gameDataNotifierProvider).currentCouple.currentPlayer !=
                    CurrentPlayer.none)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: ForecastDialog(),
                ),
              ),
            // if (ref.watch(gameDataNotifierProvider).currentPlayerID == playerIDPlaceholder)
            //   Container(
            //     color: Colors.black.withOpacity(0.4),
            //     child: const Center(
            //       child: SelectNewCoupleDialog(),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
