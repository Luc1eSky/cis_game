import 'package:cis_game/dialogs/select_new_couple_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/result.dart';
import '../constants.dart';
import '../state_management/game_data_notifier.dart';

class GameSummaryDialog extends ConsumerStatefulWidget {
  const GameSummaryDialog({super.key});

  @override
  ConsumerState<GameSummaryDialog> createState() => _GameSummaryDialog();
}

class _GameSummaryDialog extends ConsumerState<GameSummaryDialog> {
  @override
  Widget build(BuildContext context) {
    Result result = ref.read(gameDataNotifierProvider).savedResults.last;
    List<DataRow> dataRows = [];

    // for loop based on the amount of seasons played
    for (int index = 0; index < ref.read(gameDataNotifierProvider).season; index++) {
      dataRows.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text((index + 1).toString())),
            DataCell(Text(
                ref.read(gameDataNotifierProvider).savedResults[index].totalPayout.toString())),
            DataCell(Text(
                (ref.read(gameDataNotifierProvider).savedResults[index].totalPayout - startingCash)
                    .toString())),
          ],
        ),
      );
    }
    return AlertDialog(
      title: const Text("Game Summary"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Season',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Payoff',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Profit',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
            rows: dataRows,
          ),
          ElevatedButton(
            onPressed: () {
              // Close the current dialog
              Navigator.of(context).pop();
              ref.read(gameDataNotifierProvider.notifier).startNewGame();
              // open the dialog to choose a new player
              showDialog(
                  context: context,
                  builder: (context) {
                    // Start new Game
                    return const SelectNewCoupleDialog();
                  });
            },
            child: const Text('Start Next Game'),
          )
        ],
      ),
    );
  }
}
