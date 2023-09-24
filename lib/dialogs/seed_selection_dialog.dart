import 'package:cis_game/classes/field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../state_management/game_data_notifier.dart';

class SeedSelectionDialog extends ConsumerStatefulWidget {
  final int fieldIndex;
  const SeedSelectionDialog({required this.fieldIndex, super.key});

  @override
  ConsumerState<SeedSelectionDialog> createState() => _SeedSelectionState();
}

class _SeedSelectionState extends ConsumerState<SeedSelectionDialog> {
  SeedType? selectedSeedType = seedTypeList[0];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(gameDataNotifierProvider.notifier).setDefaultSeedSelection();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select seed type for field ${widget.fieldIndex + 1}'),
      // content
      content: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                '',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Seed Type',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'price ',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'yield no rain',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'yield rain',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(
                Radio<SeedType>(
                  value: seedTypeList[0],
                  groupValue: selectedSeedType,
                  onChanged: (value) {
                    ref.read(gameDataNotifierProvider.notifier).updateSelection(value);
                    setState(() {
                      selectedSeedType = value;
                    });
                  },
                ),
              ),
              DataCell(
                SizedBox(
                  width: 50,
                  child: Image.asset('assets/images/zebra.png'),
                ),
              ),
              DataCell(Text('${seedTypeList[0].price} $currency')),
              DataCell(Text('${seedTypeList[0].yieldNoRain} $currency')),
              DataCell(Text('${seedTypeList[0].yieldRain} $currency')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                Radio<SeedType>(
                  value: seedTypeList[1],
                  groupValue: selectedSeedType,
                  onChanged: (value) {
                    ref.read(gameDataNotifierProvider.notifier).updateSelection(value);
                    setState(() {
                      selectedSeedType = value;
                    });
                  },
                ),
              ),
              DataCell(SizedBox(
                width: 50,
                child: Image.asset('assets/images/lion.png'),
              )),
              DataCell(Text('${seedTypeList[1].price} $currency')),
              DataCell(Text('${seedTypeList[1].yieldNoRain} $currency')),
              DataCell(Text('${seedTypeList[1].yieldRain} $currency')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                Radio<SeedType>(
                  value: seedTypeList[2],
                  groupValue: selectedSeedType,
                  onChanged: (value) {
                    ref.read(gameDataNotifierProvider.notifier).updateSelection(value);
                    setState(() {
                      selectedSeedType = value;
                    });
                  },
                ),
              ),
              DataCell(
                SizedBox(
                  width: 50,
                  child: Image.asset('assets/images/elephant.png'),
                ),
              ),
              DataCell(Text('${seedTypeList[2].price} $currency')),
              DataCell(Text('${seedTypeList[2].yieldNoRain} $currency')),
              DataCell(Text('${seedTypeList[2].yieldRain} $currency')),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ref.read(gameDataNotifierProvider.notifier).selectSeedTypeAndBuySeed(widget.fieldIndex);
          },
          child: const Text('Buy seeds'),
        ),
      ],
    );
  }
}
