import 'package:cis_game/dialogs/pin_unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dialogs/upload_dialog.dart';
import '../../localData/sembastDataRepository.dart';
import '../../state_management/game_data_notifier.dart';

class TopRowMainPage extends ConsumerWidget {
  const TopRowMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          child: IconButton(
            iconSize: 100,
            onPressed: ref.watch(gameDataNotifierProvider).buttonsAreActive
                ? () {
                    // unlock via pin before showing settings
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return const PinUnlockDialog(showSettings: true);
                        });
                  }
                : null,
            icon: const Icon(Icons.settings),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const SizedBox(width: 10),
                FittedBox(
                  child: Text(
                    ref.watch(gameDataNotifierProvider).isInPracticeMode
                        ? 'Practice Mode'
                        : 'Participant: ${ref.watch(gameDataNotifierProvider).currentCouple.currentPlayer?.formattedID ?? ""}',
                    style: const TextStyle(fontSize: 100),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            alignment: Alignment.centerRight,
            child: Text(
              'Season: ${ref.watch(gameDataNotifierProvider).season}',
              style: const TextStyle(fontSize: 100),
            ),
          ),
        ),
        const SizedBox(width: 10),
        FittedBox(
          child: IconButton(
            iconSize: 150,
            onPressed: ref.watch(gameDataNotifierProvider).buttonsAreActive
                ? () async {
                    // 1. Load data from memory
                    final loadedResults =
                        await ref.read(localDataRepositoryProvider).loadGameResults();

                    if (context.mounted) {
                      // unlock via pin before showing upload
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return UploadDialog(gameResults: loadedResults);
                          });
                    }
                  }
                : null,
            icon: const Icon(
              Icons.file_upload_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
