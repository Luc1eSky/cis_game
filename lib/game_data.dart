import 'constants.dart';
import 'field.dart';

class GameData {
  final double cash;
  final double savings;
  final List<Field> fieldList;
  final int currentForecast;
  final SeedType? currentSeedType;
  final int season;
  final bool isNewSeason;
  // number of zebra fields in fieldLists
  List<int> get zebras {
    int zebras = 0;
    int yieldZebras = 0;
    for (Field field in fieldList) {
      SeedType? seedType = field.seedType;
      if (seedType != null && seedType.animalName == 'zebra') {
        zebras++;
        if (currentForecast < thresholdLowRain) {
          yieldZebras += seedType.yieldLowRain;
        } else {
          yieldZebras += seedType.yieldHighRain;
        }
      }
    }
    return [zebras, yieldZebras];
  }

  List<int> get lions {
    int lions = 0;
    int yieldLions = 0;
    for (Field field in fieldList) {
      SeedType? seedType = field.seedType;
      if (seedType != null && seedType.animalName == 'lion') {
        lions++;
        if (currentForecast < thresholdLowRain) {
          yieldLions += seedType.yieldLowRain;
        } else {
          yieldLions += seedType.yieldHighRain;
        }
      }
    }
    return [lions, yieldLions];
  }

  List<int> get elephants {
    int elephants = 0;
    int yieldElephants = 0;
    for (Field field in fieldList) {
      SeedType? seedType = field.seedType;
      if (seedType != null && seedType.animalName == 'elephant') {
        elephants++;
        if (currentForecast < thresholdLowRain) {
          yieldElephants += seedType.yieldLowRain;
        } else {
          yieldElephants += seedType.yieldHighRain;
        }
      }
    }
    return [elephants, yieldElephants];
  }

  List<int> get total {
    return [
      zebras[0] + lions[0] + elephants[0],
      zebras[1] + lions[1] + elephants[1] + savings.toInt()
    ];
  }

  GameData({
    required this.cash,
    required this.savings,
    required this.fieldList,
    required this.currentForecast,
    this.currentSeedType,
    required this.season,
    required this.isNewSeason,
  });

  GameData copyWith({
    double? cash,
    double? savings,
    List<Field>? fieldList,
    int? currentForecast,
    SeedType? currentSeedType,
    int? season,
    bool? isNewSeason,
  }) {
    return GameData(
      cash: cash ?? this.cash,
      savings: savings ?? this.savings,
      fieldList: fieldList ?? copyFieldList(this.fieldList),
      currentForecast: currentForecast ?? this.currentForecast,
      currentSeedType: currentSeedType ?? this.currentSeedType,
      season: season ?? this.season,
      isNewSeason: isNewSeason ?? this.isNewSeason,
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
