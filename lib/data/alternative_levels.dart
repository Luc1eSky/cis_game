import 'package:cis_game/classes/alternative_level_bundle.dart';
import 'package:cis_game/constants.dart';

import '../classes/level.dart';

List<AlternativeLevels> allAlternativeLevels = [
  alternativeLevelsI1,
  alternativeLevelsI7,
];

AlternativeLevels alternativeLevelsI1 = AlternativeLevels(
  linkedLevelId: 'I1',
  levels: [
    // 1)
    // wife: forecast 0
    // husband: forecast 0
    AlternativeLevelBundle(
      husbandLevel: Level(
        levelID: "I1AH",
        rainForecast: 0,
        isRaining: false,
        plantingAdvice: null,
      ),
      wifeLevel: Level(
        levelID: "I1AW",
        rainForecast: 0,
        isRaining: false,
        plantingAdvice: null,
      ),
    ),
    // 2)
    // wife: forecast 5
    // husband: forecast 5
    AlternativeLevelBundle(
      husbandLevel: Level(
        levelID: "I1BH",
        rainForecast: 5,
        isRaining: false,
        plantingAdvice: null,
      ),
      wifeLevel: Level(
        levelID: "I1BW",
        rainForecast: 5,
        isRaining: false,
        plantingAdvice: null,
      ),
    ),
  ],
);

AlternativeLevels alternativeLevelsI7 = AlternativeLevels(
  linkedLevelId: 'I7',
  levels: [
    // 1)
    // wife: forecast + advice Elephant
    // husband: forecast + advice Elephant
    AlternativeLevelBundle(
      husbandLevel: Level(
        levelID: "I7AH",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: adviceElephant,
      ),
      wifeLevel: Level(
        levelID: "I7AW",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: adviceElephant,
      ),
    ),
    // 2)
    // husband: forecast only
    // wife: forecast 4 + advice Elephant
    AlternativeLevelBundle(
      husbandLevel: Level(
        levelID: "I7BH",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: null,
      ),
      wifeLevel: Level(
        levelID: "I7BW",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: adviceElephant,
      ),
    ),
    // 3)
    // husband: forecast 4 + advice Elephant
    // wife: forecast 4 only
    AlternativeLevelBundle(
      husbandLevel: Level(
        levelID: "I7CH",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: adviceElephant,
      ),
      wifeLevel: Level(
        levelID: "I7CW",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: null,
      ),
    ),
    // 4)
    // husband: forecast only
    // wife: forecast only
    AlternativeLevelBundle(
      husbandLevel: Level(
        levelID: "I7DH",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: null,
      ),
      wifeLevel: Level(
        levelID: "I7DW",
        rainForecast: 4,
        isRaining: false,
        plantingAdvice: null,
      ),
    ),
  ],
);
