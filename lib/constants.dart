// TODO: REMOVE LEVEL ID AFTER TESTING IN SECOND ROW BAR
const String appVersion = '1.0.0';

const double practiceModeSlowDownFactor = 2.0;

// pin for enumerators to unlock the next steps
const String unlockPin = '7532';

// minimum screen height that is needed to play at all (otherwise black screen)
const double minimumScreenHeight = 250;

// fixed height of two top rows
const double topRowHeight = 30;
const double secondRowHeight = 50;

// limit dialog sizes so they don't become too huge
const double pinUnlockDialogMaxHeight = 500;
const double forecastDialogMaxHeight = 800;

// animation timing
const int weatherAnimationTimeInMs = 5000;
const int growingAnimationTimeInMs = 3000;
const int pauseAfterGrowingAnimationInMs = 1000;
const int pauseAfterHarvestShownOnFieldInMs = 2000;

// starting values for cash and savings
const double startingCash = 100;
const double startingSavings = 0;

// transfer step when moving cash between cash and savings
const int cashTransferStep = 100;

// field parameters
const int numberOfFields = 10;
const int numberOfFieldRows = 2;
int fieldsPerRow = (numberOfFields / numberOfFieldRows).round();
double fieldAreaAspectRatio = fieldsPerRow / numberOfFieldRows;

// legend parameters
const double legendAspectRatio = 0.5;

// forecast parameters
const int maxNumberForecast = 5; // 5 = 100% rain chance max
const int noForecastRainChance = 4; // 4 = 80% chance when no forecast

// currency string
const String currency = 'kwacha';

// max number of couples per location (for dropdown selection)
const int maxNumberOfCouplesPerLocation = 12;
const int maxNumberOnDie = 12;

// Advice for planting
const String adviceZebra = 'Advice: Plant Zebra';
const String adviceLion = 'Advice: Plant Lion';
const String adviceElephant = 'Advice: Plant Elephant';
