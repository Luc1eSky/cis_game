import 'package:cis_game/classes/couple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/result.dart';
import '../state_management/game_data_notifier.dart';

class GameSummaryDialog extends ConsumerWidget {
  final PlayerType playerType;
  const GameSummaryDialog({required this.playerType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Result> results = ref.read(gameDataNotifierProvider).savedResults;
    List<DataRow> dataRows = [];

    // for loop based on the amount of seasons played
    int index = 1;
    for (Result result in results) {
      // only add wife and couple seasons
      if (result.playerType == playerType || result.playerType == PlayerType.both) {
        dataRows.add(
          DataRow(
            cells: <DataCell>[
              DataCell(Text(index.toString())),
              DataCell(Text(result.totalPayout.toString())),
              DataCell(Text((result.playerType.name).toString())),
            ],
          ),
        );
        index++;
      }
    }

    return AlertDialog(
      scrollable: true,
      title: const Text("Game Summary"),
      content: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Round',
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
                'Player',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        rows: dataRows,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Close the current dialog
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
