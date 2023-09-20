import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/main_screen/screen_too_small_page.dart';
import 'package:cis_game/main_screen/widgets/forecast_widget.dart';
import 'package:cis_game/main_screen/widgets/second_row_main_page.dart';
import 'package:cis_game/main_screen/widgets/top_row_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../color_palette.dart';
import '../constants.dart';
import '../dialogs/forecast_dialog.dart';
import '../dialogs/pin_unlock_dialog.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.watch(gameDataNotifierProvider).currentCouple.currentPlayerType == PlayerType.none) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const PinUnlockDialog();
            });
      }
    });

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
            if (ref.watch(gameDataNotifierProvider).isNewSeason == true &&
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
    return Stack(
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
            Expanded(
              flex: 2,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                child: ForecastWidget(),
              ),
            ),
            Expanded(
              flex: 8,
              child: FieldsMainPage(),
            ),
            Spacer(),
            Expanded(
              flex: 6,
              child: BottomRowMainPage(),
            ),
          ],
        ),
        if (ref.watch(gameDataNotifierProvider).showingWeatherAnimation)
          Container(color: Colors.transparent),
        if (ref.watch(gameDataNotifierProvider).showingWeatherAnimation) const WeatherWidget(),
      ],
    );
  }
}

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double riveWidth = screenWidth * 1.0;
    double riveHeight = riveWidth / 1150 * 500;

    // get artboards from file
    final Artboard? rainArtboard =
        ref.read(riveDataNotifierProvider).riveFileRain!.artboardByName('Rain')?.instance();
    final Artboard? noRainArtboard =
        ref.read(riveDataNotifierProvider).riveFileRain!.artboardByName('No Rain')?.instance();
    //mainArtboard.instance();

    if (rainArtboard == null || noRainArtboard == null) {
      // TODO: ERROR HANDLING FOR NO CONTROLLER FOUND
      return const Placeholder();
    }
    // get state machine controller from artboard
    var rainController = StateMachineController.fromArtboard(rainArtboard, 'State Machine 1');
    var noRainController = StateMachineController.fromArtboard(noRainArtboard, 'State Machine 1');

    if (rainController == null || noRainController == null) {
      // TODO: ERROR HANDLING FOR NO CONTROLLER FOUND
      return const Placeholder();
    }

    // add controller to artboard
    rainArtboard.addController(rainController);
    noRainArtboard.addController(noRainController);

    return Positioned(
      top: 20,
      left: MediaQuery.of(context).size.width / 2 - riveWidth / 2,
      child: SizedBox(
        width: riveWidth,
        height: riveHeight,
        child: Rive(
          artboard: ref.read(gameDataNotifierProvider).currentLevel.isRaining
              ? rainArtboard
              : noRainArtboard,
        ),

        //const RiveAnimation.asset('assets/rive/rain.riv'),
      ),
    );
  }
}
