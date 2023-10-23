import 'package:cis_game/classes/enumerator.dart';

import '../classes/couple.dart';
import '../classes/field.dart';
import '../classes/level.dart';
import '../classes/level_result.dart';
import '../classes/location.dart';
import '../classes/seed_type.dart';
import '../classes/session.dart';

class GameData {
  final Enumerator? currentEnumerator;
  final Couple currentCouple;
  final Location currentLocation;
  final Session currentSession;
  final DateTime startingTime;
  final double cash;
  final double savings;
  final List<Field> currentFieldList;
  final List<LevelResult> savedResults;
  final int levelIndex;
  final Level currentLevel;
  final SeedType? currentSeedType;
  final int season;
  final bool newSeasonHasStarted;
  final bool allFieldsAreSeeded;
  final bool showingWeatherAnimation;
  final int? dieRollResult;
  final bool isInPracticeMode;
  final bool buttonsAreActive;

  // number of zebra fields in fieldLists
  List<int> get zebras {
    int zebras = 0;
    int yieldZebras = 0;
    for (Field field in currentFieldList) {
      SeedType? seedType = field.seedType;
      if (seedType.animalName == 'zebra') {
        zebras++;
        if (currentLevel.isRaining) {
          yieldZebras += seedType.yieldRain;
        } else {
          yieldZebras += seedType.yieldNoRain;
        }
      }
    }
    return [zebras, yieldZebras];
  }

  // number of lion fields in fieldLists
  List<int> get lions {
    int lions = 0;
    int yieldLions = 0;
    for (Field field in currentFieldList) {
      SeedType? seedType = field.seedType;
      if (seedType.animalName == 'lion') {
        lions++;
        if (currentLevel.isRaining) {
          yieldLions += seedType.yieldRain;
        } else {
          yieldLions += seedType.yieldNoRain;
        }
      }
    }
    return [lions, yieldLions];
  }

  // number of elephant fields in fieldLists
  List<int> get elephants {
    int elephants = 0;
    int yieldElephants = 0;

    for (Field field in currentFieldList) {
      SeedType? seedType = field.seedType;
      if (seedType.animalName == 'elephant') {
        elephants++;
        if (currentLevel.isRaining) {
          yieldElephants += seedType.yieldRain;
        } else {
          yieldElephants += seedType.yieldNoRain;
        }
      }
    }
    return [elephants, yieldElephants];
  }

  // number of total fields in fieldLists and returns from all fields
  List<int> get total {
    return [
      zebras[0] + lions[0] + elephants[0],
      zebras[1] + lions[1] + elephants[1], // + savings.toInt()
    ];
  }

  // check if all fields are seeded and cash is left over
  bool get allSeededAndCashLeft {
    return allFieldsAreSeeded && cash > 0;
  }

  GameData({
    this.currentEnumerator,
    required this.currentCouple,
    required this.currentLocation,
    required this.currentSession,
    required this.startingTime,
    required this.cash,
    required this.savings,
    required this.currentFieldList,
    required this.savedResults,
    required this.levelIndex,
    required this.currentLevel,
    this.currentSeedType,
    required this.season,
    required this.newSeasonHasStarted,
    required this.allFieldsAreSeeded,
    this.showingWeatherAnimation = false,
    this.dieRollResult,
    required this.isInPracticeMode,
    required this.buttonsAreActive,
  });

  GameData copyWith({
    Enumerator? currentEnumerator,
    Couple? currentCouple,
    Location? currentLocation,
    Session? currentSession,
    DateTime? startingTime,
    double? cash,
    double? savings,
    List<Field>? currentFieldList,
    List<LevelResult>? savedResults,
    int? levelIndex,
    Level? currentLevel,
    SeedType? currentSeedType,
    int? season,
    bool? newSeasonHasStarted,
    bool? allFieldsAreSeeded,
    bool? showingWeatherAnimation,
    int? dieRollResult,
    bool? isInPracticeMode,
    bool? buttonsAreActive,
  }) {
    return GameData(
      currentEnumerator: currentEnumerator ?? this.currentEnumerator?.copyWith(),
      currentCouple: currentCouple ?? this.currentCouple.copyWith(),
      currentLocation: currentLocation ?? this.currentLocation.copyWith(),
      currentSession: currentSession ?? this.currentSession,
      startingTime: startingTime ?? this.startingTime.copyWith(),
      cash: cash ?? this.cash,
      savings: savings ?? this.savings,
      currentFieldList: currentFieldList ?? copyFieldList(this.currentFieldList),
      savedResults: savedResults ?? copySavedResults(this.savedResults),
      levelIndex: levelIndex ?? this.levelIndex,
      currentLevel: currentLevel ?? this.currentLevel.copyWith(),
      currentSeedType: currentSeedType ?? this.currentSeedType,
      season: season ?? this.season,
      newSeasonHasStarted: newSeasonHasStarted ?? this.newSeasonHasStarted,
      allFieldsAreSeeded: allFieldsAreSeeded ?? this.allFieldsAreSeeded,
      showingWeatherAnimation: showingWeatherAnimation ?? this.showingWeatherAnimation,
      dieRollResult: dieRollResult ?? this.dieRollResult,
      isInPracticeMode: isInPracticeMode ?? this.isInPracticeMode,
      buttonsAreActive: buttonsAreActive ?? this.buttonsAreActive,
    );
  }
}

// copy list of fields
List<Field> copyFieldList(List<Field> fieldList) {
  List<Field> copiedFieldList = [];
  for (Field field in fieldList) {
    copiedFieldList.add(field.copyWith());
  }
  return copiedFieldList;
}

// copy list of results
List<LevelResult> copySavedResults(List<LevelResult> resultList) {
  List<LevelResult> copiedResultList = [];
  for (LevelResult result in resultList) {
    copiedResultList.add(result.copyWith());
  }
  return copiedResultList;
}
