// results class that contains all data that needs to be saved
import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/classes/plantingAdvice.dart';

import '../data/seedtypes.dart';
import 'level.dart';

class Result {
  const Result({
    required this.playerID,
    required this.playerType,
    required this.startedOn,
    required this.endedOn,
    required this.level,
    required this.plantingAdviceHighRisk,
    required this.plantingAdviceLowRisk,
    required this.startingCash,
    required this.startingSavings,
    required this.zebraFields,
    required this.lionFields,
    required this.elephantFields,
    required this.earningsZebras,
    required this.earningsLions,
    required this.earningsElephants,
  });

  // get enumerator, couple, location, session from game data

  // player ID and type of player needed to show results later
  final String? playerID;
  final PlayerType playerType;

  // time stamps
  final DateTime startedOn;
  final DateTime endedOn;

  // level data and advice
  final Level level;
  final PlantingAdvice plantingAdviceHighRisk;
  final PlantingAdvice plantingAdviceLowRisk;

  // starting conditions
  final double startingCash;
  final double startingSavings;

  // planting decisions
  final int zebraFields;
  final int lionFields;
  final int elephantFields;

  // earnings from plants (calculated in game data)
  final double earningsZebras;
  final double earningsLions;
  final double earningsElephants;

  Result copyWith({
    String? playerID,
    PlayerType? playerType,
    DateTime? startedOn,
    DateTime? endedOn,
    Level? level,
    PlantingAdvice? plantingAdviceHighRisk,
    PlantingAdvice? plantingAdviceLowRisk,
    double? startingCash,
    double? startingSavings,
    int? zebraFields,
    int? lionFields,
    int? elephantFields,
    double? earningsZebras,
    double? earningsLions,
    double? earningsElephants,
  }) {
    return Result(
      playerID: playerID ?? this.playerID,
      playerType: playerType ?? this.playerType,
      startedOn: startedOn ?? this.startedOn.copyWith(),
      endedOn: endedOn ?? this.endedOn.copyWith(),
      level: level ?? this.level.copyWith(),
      plantingAdviceHighRisk: plantingAdviceHighRisk ?? this.plantingAdviceHighRisk,
      plantingAdviceLowRisk: plantingAdviceLowRisk ?? this.plantingAdviceLowRisk,
      startingCash: startingCash ?? this.startingCash,
      startingSavings: startingSavings ?? this.startingSavings,
      zebraFields: zebraFields ?? this.zebraFields,
      lionFields: lionFields ?? this.lionFields,
      elephantFields: elephantFields ?? this.elephantFields,
      earningsZebras: earningsZebras ?? this.earningsZebras,
      earningsLions: earningsLions ?? this.earningsLions,
      earningsElephants: earningsElephants ?? this.earningsElephants,
    );
  }

  // calculate time played for this level
  Duration get timePlayed => endedOn.difference(startedOn);

  // calculate total amount of fields
  int get fieldsTotal => zebraFields + lionFields + elephantFields;

  // calculate costs for zebras
  double get costsZebras => zebraFields * seedTypeZebra.price;

  // calculate costs for lions
  double get costsLions => lionFields * seedTypeLion.price;

  // calculate costs for elephants
  double get costsElephants => elephantFields * seedTypeElephant.price;

  // calculate total costs
  double get costsTotal => costsZebras + costsLions + costsElephants;

  // calculate how much was stored in savings
  double get storedInSavings => startingSavings + startingCash - costsTotal;

  // calculate total earnings
  double get earningsTotal => earningsZebras + earningsLions + earningsElephants;

  // calculate total money at end (cash + savings)
  double get totalMoneyAtEnd => storedInSavings + earningsTotal;
}
