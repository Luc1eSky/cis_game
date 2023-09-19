import 'package:cis_game/rive/rive_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

final riveDataNotifierProvider =
    StateNotifierProvider<RiveDataNotifier, RiveData>((ref) => RiveDataNotifier());

class RiveDataNotifier extends StateNotifier<RiveData> {
  RiveDataNotifier()
      : super(
          RiveData(
              // stateNumberInputsDot: List.generate(allLevels.length, (index) => null),
              // clickedTriggers: List.generate(allLevels.length, (index) => null),
              // lengthInputs: List.generate(allLevels.length, (index) => null),
              // stateNumberInputsLine: List.generate(allLevels.length, (index) => null),
              ),
        );

  void loadRiveData() async {
    try {
      // TODO: REMOVE (JUST FOR TESTING LOADING SCREEN)
      //await Future.delayed(const Duration(seconds: 2));

      // load rive cosmos file from the bundle
      ByteData rainData = await rootBundle.load('assets/rive/rain.riv');
      RiveFile riveFileRain = RiveFile.import(rainData);

      debugPrint('Rive files loaded.');
      state = state.copyWith(
        riveFileRain: riveFileRain,
        riveFilesAreLoaded: true,
      );
    } catch (error) {
      // TODO: IMPLEMENT ERROR HANDLING
      debugPrint(error.toString());
    }
  }
}
