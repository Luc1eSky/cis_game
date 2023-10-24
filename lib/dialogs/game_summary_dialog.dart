import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/data/levels.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/level_result.dart';
import '../state_management/game_data_notifier.dart';

class GameSummaryDialog extends ConsumerWidget {
  final PlayerType playerType;
  const GameSummaryDialog({required this.playerType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<LevelResult> results = ref.read(gameDataNotifierProvider).savedResults;

    int? dieRollResult = ref.read(gameDataNotifierProvider).dieRollResult;

    // start index at 1 for individuals or 8 for couples
    int index = playerType == PlayerType.both ? individualLevels.length + 1 : 1;
    List<DataRow> dataRows = [];

    // for loop based on the amount of seasons played
    for (LevelResult result in results) {
      // only add wife and couple seasons
      if (result.playerType == playerType) {
        dataRows.add(
          DataRow(
            selected: index == dieRollResult,
            cells: <DataCell>[
              DataCell(Text(index.toString())),
              DataCell(Text(result.totalMoneyAtEnd.toString())),
              DataCell(Text((result.playerType?.name).toString())),
            ],
          ),
        );
        index++;
      }
    }

    return DialogTemplate(
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
