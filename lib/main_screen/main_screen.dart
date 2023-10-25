import 'package:cis_game/main_screen/screen_too_small_page.dart';
import 'package:cis_game/main_screen/widgets/second_row_main_page.dart';
import 'package:cis_game/main_screen/widgets/top_row_main_page.dart';
import 'package:cis_game/main_screen/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../color_palette.dart';
import '../classes/couple.dart';
import '../constants.dart';
import '../dialogs/forecast_dialog.dart';
import '../rive/rive_data_notifier.dart';
import '../state_management/game_data_notifier.dart';
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
    ref.read(riveDataNotifierProvider.notifier).loadRiveData();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (ref.watch(gameDataNotifierProvider).currentCouple.currentPlayerType == PlayerType.none) {
    //     showDialog(
    //         barrierDismissible: false,
    //         context: context,
    //         builder: (context) {
    //           return const PinUnlockDialog();
    //         });
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;

                if (height < minimumScreenHeight) {
                  return const ScreenTooSmallPage();
                }

                // if (height > width) {
                //   return const TestPortrait();
                // } else {
                //   return const TestLandScape();

                return const LandScapeLayout();
              },
            ),
            if (ref.watch(gameDataNotifierProvider).newSeasonHasStarted == true &&
                ref.watch(gameDataNotifierProvider).currentCouple.currentPlayerType !=
                    PlayerType.none)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: ForecastDialog(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class LandScapeLayout extends ConsumerWidget {
  const LandScapeLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          const Column(
            children: [
              SizedBox(
                height: topRowHeight,
                child: TopRowMainPage(),
              ),
              SizedBox(
                height: secondRowHeight,
                child: SecondRowMainPage(),
              ),
              Spacer(flex: 1),
              Expanded(
                flex: 10,
                child: FieldsMainPage(),
              ),
              Spacer(),
              Expanded(
                flex: 5,
                child: BottomRowMainPage(),
              ),
            ],
          ),
          if (ref.watch(gameDataNotifierProvider).showingWeatherAnimation)
            Container(color: Colors.transparent),
          if (ref.watch(gameDataNotifierProvider).showingWeatherAnimation) const WeatherWidget(),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {
          //       createExcel();
          //     },
          //     child: const Text('Create Excel'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
