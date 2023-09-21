import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

import '../../rive/rive_data_notifier.dart';
import '../../state_management/game_data_notifier.dart';

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
        ref.read(riveDataNotifierProvider).riveFileRain!.artboardByName('Light Rain')?.instance();
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
