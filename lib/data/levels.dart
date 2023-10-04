import 'package:cis_game/constants.dart';

import '../classes/level.dart';

List<Level> practiceLevels = const [
  Level(
    levelID: "P1",
    rainForecast: 4,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P2",
    rainForecast: 5,
    isRaining: false,
    plantingAdvice: adviceElephant,
  ),
  Level(
    levelID: "P3",
    rainForecast: null,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P4",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P5",
    rainForecast: 0,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P6",
    rainForecast: 5,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P7",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P8",
    rainForecast: 0,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P9",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "P10",
    rainForecast: 3,
    isRaining: false,
    plantingAdvice: null,
  ),
];

List<Level> individualLevels = [
  // INFO: I1 has alternative levels
  Level(
    levelID: "I1",
    rainForecast: 0,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "I2",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: adviceZebra,
  ),
  Level(
    levelID: "I3",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "I4",
    rainForecast: null,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "I5",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "I6",
    rainForecast: 3,
    isRaining: false,
    plantingAdvice: null,
  ),
  // INFO: I7 has alternative levels
  Level(
    levelID: "I7",
    rainForecast: 4,
    isRaining: false,
    plantingAdvice: adviceElephant,
  ),
];

List<Level> coupleLevels = [
  Level(
    levelID: "C1",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: adviceZebra,
  ),
  Level(
    levelID: "C2",
    rainForecast: null,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "C3",
    rainForecast: 3,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "C4",
    rainForecast: 4,
    isRaining: false,
    plantingAdvice: null,
  ),
  Level(
    levelID: "C5",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: null,
  ),
];

Level placeholderLevel = Level(
  levelID: "placeholder",
  rainForecast: null,
  isRaining: false,
  plantingAdvice: null,
);
