// results class that contains all data that needs to be saved
import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/classes/enumerator.dart';
import 'package:cis_game/classes/location.dart';
import 'package:cis_game/classes/plantingAdvice.dart';
import 'package:cis_game/classes/session.dart';

import '../data/seedtypes.dart';
import 'level.dart';

class LevelResult {
  const LevelResult({
    this.enumerator,
    this.playerID,
    this.location,
    this.session,
    this.playerNumber,
    this.playerType,
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
  final Enumerator? enumerator;
  final String? playerID;
  final Location? location;
  final Session? session;
  final int? playerNumber;

  // type of player needed to show results later
  final PlayerType? playerType;

  // time stamps
  final DateTime startedOn;
  final DateTime endedOn;

  // level data and advice
  final Level level;
  final PlantingAdvice plantingAdviceHighRisk;
  final PlantingAdvice plantingAdviceLowRisk;

  // starting conditions
  final double startingCash;

  @override
  String toString() {
    return '''\nLevelResult{
    enumerator : ${enumerator?.fullName},
    playerID: $playerID,     
    location: ${location?.name},
    session: ${session?.name},
    playerNumber: $playerNumber,
    playerType: ${playerType?.name},
    startedOn: $startedOn,
    endedOn: $endedOn,
    level: $level,
    plantingAdviceHighRisk: $plantingAdviceHighRisk,
    plantingAdviceLowRisk: $plantingAdviceLowRisk,
    startingCash: $startingCash,
    startingSavings: $startingSavings,
    zebraFields: $zebraFields,
    lionFields: $lionFields, 
    elephantFields: $elephantFields,
    earningsZebras: $earningsZebras,
    earningsLions: $earningsLions,
    earningsElephants: $earningsElephants}\n''';
  }

  final double startingSavings;

  // planting decisions
  final int zebraFields;
  final int lionFields;
  final int elephantFields;

  // earnings from plants (calculated in game data)
  final double earningsZebras;
  final double earningsLions;
  final double earningsElephants;

  LevelResult copyWith({
    Enumerator? enumerator,
    String? playerID,
    Location? location,
    Session? session,
    int? playerNumber,
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
    return LevelResult(
      enumerator: enumerator ?? this.enumerator?.copyWith(),
      playerID: playerID ?? this.playerID,
      location: location ?? this.location?.copyWith(),
      session: session ?? this.session,
      playerNumber: playerNumber ?? this.playerNumber,
      playerType: playerType ?? this.playerType,
      startedOn: startedOn ?? this.startedOn.copyWith(),
      endedOn: endedOn ?? this.endedOn.copyWith(),
      level: level ?? this.level.copyWith(),
      plantingAdviceHighRisk:
          plantingAdviceHighRisk ?? this.plantingAdviceHighRisk,
      plantingAdviceLowRisk:
          plantingAdviceLowRisk ?? this.plantingAdviceLowRisk,
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
  int get timePlayedInSeconds => endedOn.difference(startedOn).inSeconds;

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
  double get earningsTotal =>
      earningsZebras + earningsLions + earningsElephants;

  // calculate total money at end (cash + savings)
  double get totalMoneyAtEnd => storedInSavings + earningsTotal;

  Map<String, dynamic> toMap() {
    return {
      'enumerator': enumerator?.toMap(),
      'playerID': playerID,
      'location': location?.toMap(),
      'session': session?.name,
      'playerNumber': playerNumber,
      'playerType': playerType?.name,
      'startedOn': startedOn.millisecondsSinceEpoch,
      'endedOn': endedOn.millisecondsSinceEpoch,
      'level': level.toMap(),
      'plantingAdviceHighRisk': plantingAdviceHighRisk.name,
      'plantingAdviceLowRisk': plantingAdviceLowRisk.name,
      'startingCash': startingCash,
      'startingSavings': startingSavings,
      'zebraFields': zebraFields,
      'lionFields': lionFields,
      'elephantFields': elephantFields,
      'earningsZebras': earningsZebras,
      'earningsLions': earningsLions,
      'earningsElephants': earningsElephants,
    };
  }

  Map<String, dynamic> toFirebaseMap() {
    return {
      'enumerator': enumerator?.fullName,
      'playerID': playerID,
      'location': location?.name,
      'session': session?.name,
      'playerNumber': playerNumber,
      'playerType': playerType?.name,
      'startedOn': startedOn,
      'endedOn': endedOn,
      'level': level.toMap(),
      'plantingAdviceHighRisk': plantingAdviceHighRisk.name,
      'plantingAdviceLowRisk': plantingAdviceLowRisk.name,
      'startingCash': startingCash,
      'startingSavings': startingSavings,
      'zebraFields': zebraFields,
      'lionFields': lionFields,
      'elephantFields': elephantFields,
      'earningsZebras': earningsZebras,
      'earningsLions': earningsLions,
      'earningsElephants': earningsElephants,
      'timePlayedInSeconds': timePlayedInSeconds,
      'fieldsTotal': fieldsTotal,
      'costsZebras': costsZebras,
      'costsLions': costsLions,
      'costsElephants': costsElephants,
      'costsTotal': costsTotal,
      'storedInSavings': storedInSavings,
      'earningsTotal': earningsTotal,
      'totalMoneyAtEnd': totalMoneyAtEnd,
    };
  }

  factory LevelResult.fromMap(Map<String, dynamic> map) {
    return LevelResult(
      enumerator: Enumerator.fromMap(map['enumerator']),
      playerID: map['playerID'] as String,
      location: Location.fromMap(map['location']),
      session: Session.values.byName(map['session']),
      playerNumber: map['playerNumber'] as int,
      playerType: PlayerType.values.byName(map['playerType']),
      startedOn: DateTime.fromMillisecondsSinceEpoch(map['startedOn']),
      endedOn: DateTime.fromMillisecondsSinceEpoch(map['endedOn']),
      level: Level.fromMap(map['level']),
      plantingAdviceHighRisk:
          PlantingAdvice.values.byName(map['plantingAdviceHighRisk']),
      plantingAdviceLowRisk:
          PlantingAdvice.values.byName(map['plantingAdviceLowRisk']),
      startingCash: map['startingCash'] as double,
      startingSavings: map['startingSavings'] as double,
      zebraFields: map['zebraFields'] as int,
      lionFields: map['lionFields'] as int,
      elephantFields: map['elephantFields'] as int,
      earningsZebras: map['earningsZebras'] as double,
      earningsLions: map['earningsLions'] as double,
      earningsElephants: map['earningsElephants'] as double,
    );
  }
}
