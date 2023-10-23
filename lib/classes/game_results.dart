import 'dart:convert';

import 'game_result.dart';

class GameResults {
  const GameResults([this.gameResultList = const []]);

  final List<GameResult> gameResultList;

  // convert game results to json
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> listOfMaps = [];
    for (GameResult r in gameResultList) {
      final rMap = r.toMap();
      listOfMaps.add(rMap);
    }
    return {'gameResults': listOfMaps};
  }

  // create game result from json
  factory GameResults.fromJson(String source) => GameResults.fromMap(json.decode(source));

  factory GameResults.fromMap(Map<String, dynamic> map) {
    List<GameResult> listOfGameResults = [];

    // Get list of gameResult maps
    final listOfGameResultMaps = List<Map<String, dynamic>>.from(map['gameResults']);

    // go through list of maps
    for (Map<String, dynamic> gameResultMap in listOfGameResultMaps) {
      // create GameResult object from map
      final gameResult = GameResult.fromMap(gameResultMap);
      // add to list
      listOfGameResults.add(gameResult);
    }
    // return GameResults object
    return GameResults(listOfGameResults);
  }

  @override
  String toString() {
    String formattedString = '';
    for (GameResult r in gameResultList) {
      formattedString += 'saved Result: ${r.levelResultList.toString()} \n';
    }
    return formattedString;
  }

  GameResults copyWith({
    List<GameResult>? gameResultList,
  }) {
    return GameResults(
      gameResultList ?? this.gameResultList.map((e) => e.copyWith()).toList(),
    );
  }
}
