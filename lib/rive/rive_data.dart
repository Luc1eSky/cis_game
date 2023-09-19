import 'package:rive/rive.dart';

class RiveData {
  final RiveFile? riveFileRain;
  final bool riveFilesAreLoaded;

  // final List<SMIInput<double>?> stateNumberInputsDot;
  // final List<SMITrigger?> clickedTriggers;
  // final List<SMIInput<double>?> lengthInputs;
  // final List<SMIInput<double>?> stateNumberInputsLine;

  RiveData({
    this.riveFileRain,
    this.riveFilesAreLoaded = false,
    // required this.stateNumberInputsDot,
    // required this.clickedTriggers,
    // required this.lengthInputs,
    // required this.stateNumberInputsLine,
  });

  // method to copy custom class
  RiveData copyWith({
    RiveFile? riveFileRain,
    bool? riveFilesAreLoaded,
  }) {
    return RiveData(
      riveFileRain: riveFileRain ?? this.riveFileRain,
      riveFilesAreLoaded: riveFilesAreLoaded ?? this.riveFilesAreLoaded,
    );
  }
}
