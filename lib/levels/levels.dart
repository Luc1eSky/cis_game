import '../classes/level.dart';

List<Level> practiceLevels = [
  Level(
    levelID: "P1",
    rainForecast: 3,
    rainActual: 4,
  ),
  Level(
    levelID: "P2",
    rainForecast: 5,
    rainActual: 5,
  ),
  Level(
    levelID: "P3",
    rainForecast: 2,
    rainActual: 1,
  ),
];

List<Level> individualLevels = [
  Level(
    levelID: "I1",
    rainForecast: 0,
    rainActual: 0,
  ),
  Level(
    levelID: "I2",
    rainForecast: 1,
    rainActual: 1,
  ),
  Level(
    levelID: "I3",
    rainForecast: 2,
    rainActual: 2,
  ),
  Level(
    levelID: "I4",
    rainForecast: null,
    rainActual: 2,
  ),
  // Level(
  //   levelID: "I5",
  //   rainForecast: 3,
  //   rainActual: 3,
  // ),
  // Level(
  //   levelID: "I6",
  //   rainForecast: null,
  //   rainActual: 4,
  // ),
  // Level(
  //   levelID: "I7",
  //   rainForecast: 4,
  //   rainActual: 4,
  // ),
  // Level(
  //   levelID: "I8",
  //   rainForecast: 5,
  //   rainActual: 5,
  // ),
];

List<Level> coupleLevels = [
  Level(
    levelID: "C1",
    rainForecast: 1,
    rainActual: 1,
  ),
  Level(
    levelID: "C2",
    rainForecast: 2,
    rainActual: 2,
  ),
  // Level(
  //   levelID: "C3",
  //   rainForecast: null,
  //   rainActual: 3,
  // ),
  // Level(
  //   levelID: "C4",
  //   rainForecast: 5,
  //   rainActual: 5,
  // ),
];

Level placeholderLevel = Level(
  levelID: "placeholder",
  rainForecast: null,
  rainActual: 0,
);
