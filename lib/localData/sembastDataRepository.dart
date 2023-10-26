import 'package:cis_game/classes/game_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

import '../classes/game_results.dart';

class SembastDataRepository {
  SembastDataRepository({required this.db});
  final Database db;
  final store = StoreRef.main();

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${dir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

  static Future<SembastDataRepository> makeDefault() async {
    return SembastDataRepository(db: await createDatabase('default.db'));
  }

  static const gameResultKey = 'gameResult';

  /// load game result from local memory
  /// json -> map -> GameResults
  Future<GameResults> loadGameResults() async {
    final gameResultJson = await store.record(gameResultKey).get(db) as String?;
    if (gameResultJson != null) {
      return GameResults.fromJson(gameResultJson);
    } else {
      return const GameResults();
    }
  }

  /// save game result to local memory
  /// GameResults -> map -> json
  Future<void> saveGameResults(GameResults gameResults) {
    return store.record(gameResultKey).put(db, gameResults.toJson());
  }

  /// add GameResult to list of results in local memory
  Future<void> addGameResult(GameResult newGameResult) async {
    // load current data
    GameResults currentSavedGameResults = await loadGameResults();
    // get current game result list
    List<GameResult> updatedGameResultList =
        List<GameResult>.from(currentSavedGameResults.gameResultList);
    // add new game result to list

    // TODO: Take out after local memory test
    for (int i = 0; i < 10; i++) {
      updatedGameResultList.add(newGameResult);
    }
    // create new GameResults object
    GameResults updatedGameResults = GameResults(updatedGameResultList);

    // save updated game results in memory
    await saveGameResults(updatedGameResults);

    return;
  }

  /// get the amount of saved game results

  /// reset saved GameResults to empty list
  Future<void> resetMemory() async {
    return await saveGameResults(const GameResults());
  }
}

final localDataRepositoryProvider = Provider<SembastDataRepository>((ref) {
  // * Override this in the main method
  throw UnimplementedError();
});
