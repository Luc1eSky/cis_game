import 'package:rive/rive.dart';

class RiveData {
  final RiveFile? riveFileRain;
  final RiveFile? riveFileMaize;
  final bool riveFilesAreLoaded;

  // final List<SMIInput<double>?> stateNumberInputsDot;
  // final List<SMITrigger?> clickedTriggers;
  // final List<SMIInput<double>?> lengthInputs;
  // final List<SMIInput<double>?> stateNumberInputsLine;

  RiveData({
    this.riveFileRain,
    this.riveFileMaize,
    this.riveFilesAreLoaded = false,
    // required this.stateNumberInputsDot,
    // required this.clickedTriggers,
    // required this.lengthInputs,
    // required this.stateNumberInputsLine,
  });

  // method to copy custom class
  RiveData copyWith({
    RiveFile? riveFileRain,
    RiveFile? riveFileMaize,
    bool? riveFilesAreLoaded,
  }) {
    return RiveData(
      riveFileRain: riveFileRain ?? this.riveFileRain,
      riveFileMaize: riveFileMaize ?? this.riveFileMaize,
      riveFilesAreLoaded: riveFilesAreLoaded ?? this.riveFilesAreLoaded,
    );
  }
}
