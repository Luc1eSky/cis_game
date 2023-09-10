const double startingCash = 100;
const double startingSavings = 0;
const int cashTransferStep = 10;
const int numberOfFields = 10;
const int numberOfFieldRows = 2;
const int maxNumberForecast = 5;
const int thresholdLowRain = 3;
const String playerIDPlaceholder = 'tbd';
const String currency = 'kwacha';

const double topRowHeight = 40;

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
