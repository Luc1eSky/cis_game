import 'classes/enumerator.dart';

const double minimumScreenHeight = 250;
const double pinUnlockDialogMaxHeight = 500;
const double forecastDialogMaxHeight = 800;

const String unlockPin = '7532';

const int weatherAnimationTimeInMs = 5000;
const int growingAnimationTimeInMs = 3000;
const int pauseAfterGrowingAnimationInMs = 2000;

const double startingCash = 100;
const double startingSavings = 0;
const int cashTransferStep = 10;
const int numberOfFields = 10;
const int numberOfFieldRows = 2;
const int maxNumberForecast = 5;
const int thresholdLowRain = 3;
const int noForecastRainChance = 4; // 80% chance when no forecast
const String playerIDPlaceholder = 'tbd';
const String currency = 'kwacha';

List<int> coupleNumbers = List.generate(99, (index) => index + 1);

const double topRowHeight = 40;
const double secondRowHeight = 40;

const double gapRatio = 0.20;
const double legendWidthRatio = 1.5;
const int legendEntries = 3;

// helpers
const int fieldsPerRow = numberOfFields ~/ numberOfFieldRows;
const int horizontalGaps = fieldsPerRow + 1;
const double fieldAreaWidthRatio = fieldsPerRow + horizontalGaps * gapRatio;
const double fieldAreaWidthRatioWithLegend = fieldAreaWidthRatio + legendWidthRatio;
const double fieldAreaHeightRatio = numberOfFieldRows + (numberOfFieldRows + 1) * gapRatio;
const double legendHeightRatio = fieldAreaHeightRatio / legendEntries;
const double fieldAreaHeightRatioWithLegend =
    numberOfFieldRows + (numberOfFieldRows + 1) * gapRatio + legendHeightRatio;

List<Enumerator> enumerators = [
  Enumerator(firstName: "John", lastName: "Wick"),
  Enumerator(firstName: "Petite", lastName: "Ecolier"),
  Enumerator(firstName: "Peter", lastName: "Griffin"),
];
