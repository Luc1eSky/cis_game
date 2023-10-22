import 'package:cis_game/classes/game_results.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadDialog extends ConsumerWidget {
  const UploadDialog({
    required this.gameResults,
    super.key,
  });
  final GameResults gameResults;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int resultsCount = gameResults.gameResultList.length;
    return DialogTemplate(
      title: const Text('Locally Saved Data'),
      content: Text('there are $resultsCount files to upload...'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Upload'),
        )
      ],
    );
  }
}
