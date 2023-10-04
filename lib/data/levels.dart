import '../classes/level.dart';

List<Level> practiceLevels = const [
  Level(
    levelID: "P1",
    rainForecast: 4,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P2",
    rainForecast: 5,
    isRaining: false,
    plantingAdvice: true,
  ),
  Level(
    levelID: "P3",
    rainForecast: null,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P4",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P5",
    rainForecast: 0,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P6",
    rainForecast: 5,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P7",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P8",
    rainForecast: 0,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P9",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: false,
  ),
  Level(
    levelID: "P10",
    rainForecast: 3,
    isRaining: false,
    plantingAdvice: false,
  ),
];

List<Level> individualLevels = [
  // INFO: I1 has alternative levels
  const Level(
    levelID: "I1",
    rainForecast: 0,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "I2",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "I3",
    rainForecast: 1,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "I4",
    rainForecast: null,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "I5",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "I6",
    rainForecast: 3,
    isRaining: false,
    plantingAdvice: false,
  ),
  // INFO: I7 has alternative levels
  const Level(
    levelID: "I7",
    rainForecast: 4,
    isRaining: false,
    plantingAdvice: true,
  ),
];

List<Level> coupleLevels = [
  const Level(
    levelID: "C1",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: true,
  ),
  const Level(
    levelID: "C2",
    rainForecast: null,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "C3",
    rainForecast: 3,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "C4",
    rainForecast: 4,
    isRaining: false,
    plantingAdvice: false,
  ),
  const Level(
    levelID: "C5",
    rainForecast: 2,
    isRaining: false,
    plantingAdvice: false,
  ),
];

Level placeholderLevel = const Level(
  levelID: "placeholder",
  rainForecast: null,
  isRaining: false,
  plantingAdvice: false,
);
