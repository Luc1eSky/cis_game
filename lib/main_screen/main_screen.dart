import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/dialogs/pin_unlock_dialog.dart';
import 'package:cis_game/main_screen/widgets/forecast_widget.dart';
import 'package:cis_game/main_screen/widgets/top_row_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../color_palette.dart';
import '../constants.dart';
import '../dialogs/forecast_dialog.dart';
import '../rive/rive_data_notifier.dart';
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
    ref.read(riveDataNotifierProvider.notifier).loadRiveData();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.watch(gameDataNotifierProvider).currentCouple.currentPlayerType == PlayerType.none) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const PinUnlockDialog(); //SelectNewCoupleDialog();
            });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fullWidgetList =
        createFieldWidgets(ref.watch(gameDataNotifierProvider).currentFieldList);
    int topRowLength = fullWidgetList.length ~/ 2;
    List<Widget> topRowList = fullWidgetList.sublist(0, topRowLength);
    topRowList.add(const Spacer());
    List<Widget> bottomRowList = fullWidgetList.sublist(topRowLength);

    return Scaffold(
      backgroundColor: ColorPalette().backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                // if (height > width) {
                //   return const TestPortrait();
                // } else {
                //   return const TestLandScape();

                return LandScapeLayout(
                  topRowList: topRowList,
                  bottomRowList: bottomRowList,
                );
                //}
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

// class TestPortrait extends ConsumerWidget {
//   const TestPortrait({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         SizedBox(
//           height: topRowHeight,
//           child: Container(
//             color: Colors.blue,
//             child: const TopRowMainPage(),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Container(
//             color: Colors.white,
//             child: const FractionallySizedBox(
//               heightFactor: 0.5,
//               child: ForecastWidget(),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 8,
//           child: Container(
//             color: Colors.purple,
//             child: Container(
//               color: Colors.red,
//               child: Center(
//                 child: Container(
//                   color: Colors.orange,
//                   child: AspectRatio(
//                     aspectRatio: fieldAreaWidthRatio / fieldAreaHeightRatioWithLegend,
//                     child: LayoutBuilder(builder: (context, constraints) {
//                       double fieldSize = constraints.maxWidth / fieldAreaWidthRatio;
//                       return Column(
//                         children: [
//                           Expanded(
//                             flex: (100 / fieldAreaHeightRatioWithLegend * fieldAreaHeightRatio)
//                                 .round(),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex:
//                                 (100 / fieldAreaHeightRatioWithLegend * legendHeightRatio).round(),
//                             child: Container(
//                               color: Colors.purple,
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const Spacer(),
//         const Expanded(
//           flex: 6,
//           child: BottomRowMainPage(),
//         ),
//       ],
//     );
//   }
// }
//
// class TestLandScape extends ConsumerWidget {
//   const TestLandScape({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         SizedBox(
//           height: topRowHeight,
//           child: Container(
//             color: Colors.blue,
//             child: const TopRowMainPage(),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: Container(
//             color: Colors.white,
//             child: const FractionallySizedBox(
//               heightFactor: 0.5,
//               child: ForecastWidget(),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 8,
//           child: Container(
//             color: Colors.purple,
//             child: Container(
//               color: Colors.red,
//               child: Center(
//                 child: Container(
//                   color: Colors.orange,
//                   child: AspectRatio(
//                     aspectRatio: fieldAreaWidthRatioWithLegend / fieldAreaHeightRatio,
//                     child: LayoutBuilder(builder: (context, constraints) {
//                       double fieldSize = constraints.maxWidth / fieldAreaWidthRatioWithLegend;
//                       return Row(
//                         children: [
//                           Expanded(
//                             flex:
//                                 (100 / fieldAreaWidthRatioWithLegend * fieldAreaWidthRatio).round(),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                     Container(
//                                       color: Colors.brown,
//                                       width: fieldSize,
//                                       height: fieldSize,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex: (100 / fieldAreaWidthRatioWithLegend * legendWidthRatio).round(),
//                             child: Container(
//                               color: Colors.white,
//                               child: Column(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       color: Colors.lightBlueAccent,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       color: Colors.limeAccent,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       color: Colors.purpleAccent,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const Spacer(),
//         const Expanded(
//           flex: 6,
//           child: BottomRowMainPage(),
//         ),
//       ],
//     );
//   }
// }

class LandScapeLayout extends ConsumerWidget {
  const LandScapeLayout({
    super.key,
    required this.topRowList,
    required this.bottomRowList,
  });

  final List<Widget> topRowList;
  final List<Widget> bottomRowList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: topRowHeight,
              child: TopRowMainPage(),
            ),
            const Expanded(
              flex: 2,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                child: ForecastWidget(),
              ),
            ),
            Expanded(
              flex: 8,
              child: FieldsMainPage(
                topRowList: topRowList,
                bottomRowList: bottomRowList,
              ),
            ),
            const Spacer(),
            const Expanded(
              flex: 6,
              child: BottomRowMainPage(),
            ),
          ],
        ),
        if (ref.watch(gameDataNotifierProvider).showingAnimation)
          Container(color: Colors.transparent),
        if (ref.watch(gameDataNotifierProvider).showingAnimation) const WeatherWidget(),
      ],
    );
  }
}

// class WeatherWidget extends ConsumerWidget {
//   const WeatherWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Positioned(
//       top: 100,
//       left: MediaQuery.of(context).size.width / 2 - 100,
//       child: Container(
//         //duration: const Duration(milliseconds: 1000),
//         //curve: Curves.easeInOut,
//         width: 200,
//         height: 200,
//         color: ref.read(gameDataNotifierProvider).currentLevel.isRaining
//             ? Colors.blue
//             : Colors.yellow,
//       ),
//     );
//   }
// }

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
