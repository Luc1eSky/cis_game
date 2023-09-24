// results class that contains all data that needs to be saved
import 'package:cis_game/classes/couple.dart';

import 'level.dart';

class Result {
  final Level level;
  final String personalID;
  final PlayerType playerType;
  final int zebraFields;
  final int lionFields;
  final int elephantFields;
  final int zebraPayout;
  final int lionPayout;
  final int elephantPayout;
  final int amountOfPlantedFields;
  final double startingCash;
  final double savings;
  final double moneySpent;
  final double moneyEarned;

  Result({
    required this.level,
    required this.personalID,
    required this.playerType,
    required this.zebraFields,
    required this.lionFields,
    required this.elephantFields,
    required this.zebraPayout,
    required this.lionPayout,
    required this.elephantPayout,
    required this.amountOfPlantedFields,
    required this.startingCash,
    required this.savings,
    required this.moneySpent,
    required this.moneyEarned,
  });

  Result copyWith({
    Level? level,
    String? personalID,
    PlayerType? playerType,
    int? zebraFields,
    int? lionFields,
    int? elephantFields,
    int? zebraPayout,
    int? lionPayout,
    int? elephantPayout,
    int? amountOfPlantedFields,
    double? startingCash,
    double? savings,
    double? moneySpent,
    double? moneyEarned,
  }) {
    return Result(
      level: level ?? this.level.copyWith(),
      personalID: personalID ?? this.personalID,
      playerType: playerType ?? this.playerType,
      zebraFields: zebraFields ?? this.zebraFields,
      lionFields: lionFields ?? this.lionFields,
      elephantFields: elephantFields ?? this.elephantFields,
      zebraPayout: zebraPayout ?? this.zebraPayout,
      lionPayout: lionPayout ?? this.lionPayout,
      elephantPayout: elephantPayout ?? this.elephantPayout,
      amountOfPlantedFields: amountOfPlantedFields ?? this.amountOfPlantedFields,
      startingCash: startingCash ?? this.startingCash,
      savings: savings ?? this.savings,
      moneySpent: moneySpent ?? this.moneySpent,
      moneyEarned: moneyEarned ?? this.moneyEarned,
    );
  }

  double get moneyAtEndOfSeason {
    return savings + moneyEarned;
  }
}
