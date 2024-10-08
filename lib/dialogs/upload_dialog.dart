import 'package:cis_game/classes/game_results.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/game_result.dart';
import '../localData/sembastDataRepository.dart';

class UploadDialog extends ConsumerStatefulWidget {
  const UploadDialog({
    required this.gameResults,
    super.key,
  });
  final GameResults gameResults;

  @override
  ConsumerState<UploadDialog> createState() => _UploadDialogState();
}

class _UploadDialogState extends ConsumerState<UploadDialog> {
  String status = '';

  @override
  Widget build(BuildContext context) {
    int resultsCount = widget.gameResults.gameResultList.length;

    return DialogTemplate(
      title: Text('Files to upload: $resultsCount'),
      content: SizedBox(
          height: 50,
          width: 200,
          child: status == 'loading'
              ? const Center(child: CircularProgressIndicator())
              : status == 'success'
                  ? const Text('Success.')
                  : status == 'error'
                      ? const Text(
                          'Could not connect to database. Check connection.')
                      : const Text(
                          'Info: Make sure you have internet connection.')),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        if (status != 'success' && resultsCount > 0 && status != 'error')
          ElevatedButton(
            onPressed: status == 'loading'
                ? null
                : () async {
                    setState(() {
                      status = 'loading';
                    });

                    // get a copy of the game results list
                    List<GameResult> copiedGameResultList =
                        widget.gameResults.copyWith().gameResultList;

                    // TODO: ADD TRY CATCH? can this fail?
                    final db = FirebaseFirestore.instance;

                    // go through all saved gameResults (played games by wife, husband, and couple)
                    // each should be 7+7+5=19 levels
                    for (GameResult gameResult
                        in widget.gameResults.gameResultList) {
                      // create one large map
                      Map<String, dynamic> gameResultMap =
                          gameResult.toMap(); // toFirebaseMap();
                      try {
                        //await Future.delayed(const Duration(seconds: 3)); // test delay
                        // upload one game result as one document to firestore
                        await db.runTransaction((transaction) async {
                          transaction.set(
                            FirebaseFirestore.instance.collection('data').doc(),
                            gameResultMap,
                          );
                        });
                        // remove uploaded result from list
                        copiedGameResultList.removeAt(0);
                      } catch (e) {
                        setState(() {
                          status = 'error';
                        });
                        // save remaining game results in local memory
                        ref
                            .read(localDataRepositoryProvider)
                            .saveGameResults(GameResults(copiedGameResultList));
                        return;
                      }
                    }

                    // reset local memory after everything was uploaded successfully
                    ref.read(localDataRepositoryProvider).resetMemory();

                    setState(() {
                      status = 'success';
                    });

                    // int i = 0;
                    // for (GameResult gameResult in widget.gameResults.gameResultList) {
                    //   try {
                    //     Map<String, dynamic> gameResultMap = gameResult.toFirebaseMap();
                    //     //await Future.delayed(const Duration(seconds: 2));
                    //     if (i > 0) {
                    //       throw TimeoutException('Timed Out');
                    //     } else {
                    //       i++;
                    //     }
                    //
                    //     await db
                    //         .collection("new")
                    //         .add(gameResultMap)
                    //         .timeout(const Duration(seconds: 7), onTimeout: () {
                    //       throw TimeoutException('Timed Out');
                    //     });
                    //     // remove uploaded result from list
                    //     copiedGameResultList.removeAt(0);
                    //   } catch (e) {
                    //     setState(() {
                    //       status = 'error';
                    //     });
                    //
                    //     ref
                    //         .read(localDataRepositoryProvider)
                    //         .saveGameResults(GameResults(copiedGameResultList));
                    //     return;
                    //   }
                    // }
                  },
            child: const Text('Upload'),
          ),
      ],
    );
  }
}
