// results class that contains all data that needs to be saved
import 'level.dart';

class Result {
  final Level level;
  final String personalID;
  final double savings;
  final int zebraFields;
  final int lionFields;
  final int elephantFields;
  final int zebraPayout;
  final int lionPayout;
  final int elephantPayout;
  final int amountOfPlantedFields;
  final int totalPayout;

  Result({
    required this.level,
    required this.personalID,
    required this.savings,
    required this.zebraFields,
    required this.lionFields,
    required this.elephantFields,
    required this.zebraPayout,
    required this.lionPayout,
    required this.elephantPayout,
    required this.amountOfPlantedFields,
    required this.totalPayout,
  });

  Result copyWith({
    Level? level,
    String? personalID,
    double? savings,
    int? zebraFields,
    int? lionFields,
    int? elephantFields,
    int? zebraPayout,
    int? lionPayout,
    int? elephantPayout,
    int? amountOfPlantedFields,
    int? totalPayout,
  }) {
    return Result(
      level: level ?? this.level.copyWith(),
      personalID: personalID ?? this.personalID,
      savings: savings ?? this.savings,
      zebraFields: zebraFields ?? this.zebraFields,
      lionFields: lionFields ?? this.lionFields,
      elephantFields: elephantFields ?? this.elephantFields,
      zebraPayout: zebraPayout ?? this.zebraPayout,
      lionPayout: lionPayout ?? this.lionPayout,
      elephantPayout: elephantPayout ?? this.elephantPayout,
      amountOfPlantedFields: amountOfPlantedFields ?? this.amountOfPlantedFields,
      totalPayout: totalPayout ?? this.totalPayout,
    );
  }
}
