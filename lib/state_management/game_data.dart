import 'package:cis_game/classes/enumerator.dart';

import '../classes/couple.dart';
import '../classes/field.dart';
import '../classes/level.dart';
import '../classes/result.dart';

class GameData {
  final double cash;
  final double savings;
  final List<Field> currentFieldList;
  final List<Result> savedResults;
  final int levelIndex;
  final Level currentLevel;
  final Couple currentCouple;
  final SeedType? currentSeedType;
  // TODO: NEEDED OR MODIFY?
  final int season;
  final bool isNewSeason;
  final bool allFieldsAreSeeded;
  final bool showingWeatherAnimation;
  final Enumerator? currentEnumerator;

  // number of zebra fields in fieldLists
  List<int> get zebras {
    int zebras = 0;
    int yieldZebras = 0;
    for (Field field in currentFieldList) {
      SeedType? seedType = field.seedType;
      if (seedType != null && seedType.animalName == 'zebra') {
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
      if (seedType != null && seedType.animalName == 'lion') {
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
      if (seedType != null && seedType.animalName == 'elephant') {
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

  // number of total fields in fieldLists
  List<int> get total {
    return [
      zebras[0] + lions[0] + elephants[0],
      zebras[1] + lions[1] + elephants[1] + savings.toInt()
    ];
  }

  // check if all fields are seeded and cash is left over
  bool get allSeededAndCashLeft {
    return allFieldsAreSeeded && cash > 0;
  }

  GameData({
    required this.cash,
    required this.savings,
    required this.currentFieldList,
    required this.savedResults,
    required this.levelIndex,
    required this.currentLevel,
    required this.currentCouple,
    this.currentSeedType,
    required this.season,
    required this.isNewSeason,
    required this.allFieldsAreSeeded,
    this.showingWeatherAnimation = false,
    this.currentEnumerator,
  });

  GameData copyWith({
    double? cash,
    double? savings,
    List<Field>? currentFieldList,
    List<Result>? savedResults,
    int? levelIndex,
    Level? currentLevel,
    Couple? currentCouple,
    SeedType? currentSeedType,
    int? season,
    bool? isNewSeason,
    bool? allFieldsAreSeeded,
    bool? showingWeatherAnimation,
    Enumerator? currentEnumerator,
  }) {
    return GameData(
      cash: cash ?? this.cash,
      savings: savings ?? this.savings,
      currentFieldList: currentFieldList ?? copyFieldList(this.currentFieldList),
      savedResults: savedResults ?? copySavedResults(this.savedResults),
      levelIndex: levelIndex ?? this.levelIndex,
      currentLevel: currentLevel ?? this.currentLevel.copyWith(),
      currentCouple: currentCouple ?? this.currentCouple.copyWith(),
      currentSeedType: currentSeedType ?? this.currentSeedType,
      season: season ?? this.season,
      isNewSeason: isNewSeason ?? this.isNewSeason,
      allFieldsAreSeeded: allFieldsAreSeeded ?? this.allFieldsAreSeeded,
      showingWeatherAnimation: showingWeatherAnimation ?? this.showingWeatherAnimation,
      currentEnumerator: currentEnumerator ?? this.currentEnumerator?.copyWith(),
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
List<Result> copySavedResults(List<Result> resultList) {
  List<Result> copiedResultList = [];
  for (Result result in resultList) {
    copiedResultList.add(result.copyWith());
  }
  return copiedResultList;
}
