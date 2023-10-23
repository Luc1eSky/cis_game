import 'package:cis_game/classes/game_results.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    int resultsCount = widget.gameResults.gameResultList.length;
    return DialogTemplate(
      title: const Text('Locally Saved Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('there are $resultsCount files to upload...'),
          const SizedBox(height: 10),
          Text('Error: $errorMessage'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            // STEP 1: CHECK IF CONNECTION AVAILABLE

            // STEP 2: FOR EACH GAME RESULT

            // UPLOAD EACH RESULT TO A NEW DOCUMENT
            // DELETE RESULT FROM LOCAL LIST

            // STEP 3: UPDATE MEMORY

            //Navigator.of(context).pop();
            try {
              final db = FirebaseFirestore.instance;
              final docRef = await db.collection("connection").add({
                'connection': true,
                'timeStamp': DateTime.now(),
              });
              //print(docRef.id);
              setState(() {
                errorMessage = 'success';
              });
            } catch (e) {
              //print(e);
              setState(() {
                errorMessage = e.toString();
              });
            }

            // Map<String, dynamic> gameResultMap = gameResults.gameResultList[0].toFirebaseMap();
            //
            // final docRef = await db.collection("test").add(gameResultMap);
          },
          child: const Text('Upload'),
        )
      ],
    );
  }
}
