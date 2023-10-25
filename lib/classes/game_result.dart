import 'package:cis_game/classes/level_result.dart';

/// saving a list of all results per couple (2 x individuals + couple)
class GameResult {
  const GameResult([this.levelResultList = const []]);
  //List<LevelResult> results = [];

  // 19 LevelResults = 1 GameResult
  final List<LevelResult> levelResultList;

  // convert game result to map
  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> listOfMaps =
        levelResultList.map((levelResult) => levelResult.toMap()).toList();

    return {'gameResult': listOfMaps};
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
    final listOfMaps = List<Map<String, dynamic>>.from(map['gameResult']);

    final listOfLevelResults =
        listOfMaps.map((levelResultMap) => LevelResult.fromMap(levelResultMap)).toList();
    return GameResult(listOfLevelResults);
  }

  @override
  String toString() {
    return levelResultList.toString();
  }

  GameResult copyWith({
    List<LevelResult>? levelResultList,
  }) {
    return GameResult(
      levelResultList ?? this.levelResultList.map((e) => e.copyWith()).toList(),
    );
  }
}
