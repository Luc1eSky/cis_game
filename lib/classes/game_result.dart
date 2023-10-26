import 'package:cis_game/classes/level_result.dart';

/// saving a list of all results per couple (2 x individuals + couple)
class GameResult {
  const GameResult([this.levelResultList = const [], this.dieRollResult = 0]);
  //List<LevelResult> results = [];

  // 19 LevelResults = 1 GameResult
  final List<LevelResult> levelResultList;
  final int dieRollResult;

  // convert game result to map
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> listOfMaps =
        levelResultList.map((levelResult) => levelResult.toMap()).toList();

    return {
      'gameResult': {
        'levelResultList': listOfMaps,
        'dieRollResult': dieRollResult,
      }
    };
  }

  // // convert game result to firebase map (with timestamps, etc.)
  // Map<String, dynamic> toFirebaseMap() {
  //   List<Map<String, dynamic>> listOfMaps =
  //       levelResultList.map((levelResult) => levelResult.toFirebaseMap()).toList();
  //
  //   return {'gameResult': listOfMaps};
  // }

  // create game result from map
  factory GameResult.fromMap(Map<String, dynamic> map) {
    final gameResultMap = Map<String, dynamic>.from(map['gameResult']);

    final listOfMaps =
        List<Map<String, dynamic>>.from(gameResultMap['levelResultList']);

    final listOfLevelResults = listOfMaps
        .map((levelResultMap) => LevelResult.fromMap(levelResultMap))
        .toList();

    final dieRollResult = gameResultMap['dieRollResult'] as int;

    return GameResult(listOfLevelResults, dieRollResult);
  }

  @override
  String toString() {
    return '''GameResult: {
    levelResultList: ${levelResultList.toString()},
    dieRoll: $dieRollResult,
    }''';
  }

  GameResult copyWith({
    List<LevelResult>? levelResultList,
    int? dieRollResult,
  }) {
    return GameResult(
      levelResultList ?? this.levelResultList.map((e) => e.copyWith()).toList(),
      dieRollResult ?? this.dieRollResult,
    );
  }
}
