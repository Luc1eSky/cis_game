import '../classes/couple.dart';
import '../classes/field.dart';
import '../classes/level.dart';
import '../constants.dart';

class GameData {
  final double cash;
  final double savings;
  final List<Field> fieldList;
  final int levelIndex;
  final Level currentLevel;
  final Couple currentCouple;
  final SeedType? currentSeedType;
  // TODO: NEEDED OR MODIFY?
  final int season;
  final bool isNewSeason;
  final bool allFieldsAreSeeded;

  // number of zebra fields in fieldLists
  List<int> get zebras {
    int zebras = 0;
    int yieldZebras = 0;
    for (Field field in fieldList) {
      SeedType? seedType = field.seedType;
      if (seedType != null && seedType.animalName == 'zebra') {
        zebras++;
        if (currentLevel.rainActual < thresholdLowRain) {
          yieldZebras += seedType.yieldLowRain;
        } else {
          yieldZebras += seedType.yieldHighRain;
        }
      }
    }
    return [zebras, yieldZebras];
  }

  // number of lion fields in fieldLists
  List<int> get lions {
    int lions = 0;
    int yieldLions = 0;
    for (Field field in fieldList) {
      SeedType? seedType = field.seedType;
      if (seedType != null && seedType.animalName == 'lion') {
        lions++;
        if (currentLevel.rainActual < thresholdLowRain) {
          yieldLions += seedType.yieldLowRain;
        } else {
          yieldLions += seedType.yieldHighRain;
        }
      }
    }
    return [lions, yieldLions];
  }

  // number of elephant fields in fieldLists
  List<int> get elephants {
    int elephants = 0;
    int yieldElephants = 0;
    for (Field field in fieldList) {
      SeedType? seedType = field.seedType;
      if (seedType != null && seedType.animalName == 'elephant') {
        elephants++;
        if (currentLevel.rainActual < thresholdLowRain) {
          yieldElephants += seedType.yieldLowRain;
        } else {
          yieldElephants += seedType.yieldHighRain;
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
    required this.fieldList,
    required this.levelIndex,
    required this.currentLevel,
    required this.currentCouple,
    this.currentSeedType,
    required this.season,
    required this.isNewSeason,
    required this.allFieldsAreSeeded,
  });

  GameData copyWith({
    double? cash,
    double? savings,
    List<Field>? fieldList,
    int? levelIndex,
    Level? currentLevel,
    Couple? currentCouple,
    SeedType? currentSeedType,
    int? season,
    bool? isNewSeason,
    bool? allFieldsAreSeeded,
  }) {
    return GameData(
      cash: cash ?? this.cash,
      savings: savings ?? this.savings,
      fieldList: fieldList ?? copyFieldList(this.fieldList),
      levelIndex: levelIndex ?? this.levelIndex,
      currentLevel: currentLevel ?? this.currentLevel.copyWith(),
      currentCouple: currentCouple ?? this.currentCouple.copyWith(),
      currentSeedType: currentSeedType ?? this.currentSeedType,
      season: season ?? this.season,
      isNewSeason: isNewSeason ?? this.isNewSeason,
      allFieldsAreSeeded: allFieldsAreSeeded ?? this.allFieldsAreSeeded,
    );
  }
}

// update list of fields by going through each element
List<Field> copyFieldList(List<Field> fieldList) {
  List<Field> copiedFieldList = [];
  for (Field field in fieldList) {
    copiedFieldList.add(field.copyWith());
  }

  return copiedFieldList;
}
