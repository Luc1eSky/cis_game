import 'package:cis_game/field.dart';
import 'package:cis_game/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants.dart';

class SeedSelection extends ConsumerStatefulWidget {
  const SeedSelection({super.key});

  @override
  ConsumerState<SeedSelection> createState() => _SeedSelectionState();
}

class _SeedSelectionState extends ConsumerState<SeedSelection> {
  SeedType? selectedSeedType = seedTypeList[0];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(gameDataNotifierProvider.notifier).setDefaultSeedSelection();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
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
              'yield low rain',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'yield high rain',
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
                  ref
                      .read(gameDataNotifierProvider.notifier)
                      .updateSelection(value);
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
            DataCell(Text('${seedTypeList[0].yieldLowRain} $currency')),
            DataCell(Text('${seedTypeList[0].yieldHighRain} $currency')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Radio<SeedType>(
                value: seedTypeList[1],
                groupValue: selectedSeedType,
                onChanged: (value) {
                  ref
                      .read(gameDataNotifierProvider.notifier)
                      .updateSelection(value);
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
            DataCell(Text('${seedTypeList[1].yieldLowRain} $currency')),
            DataCell(Text('${seedTypeList[1].yieldHighRain} $currency')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(
              Radio<SeedType>(
                value: seedTypeList[2],
                groupValue: selectedSeedType,
                onChanged: (value) {
                  ref
                      .read(gameDataNotifierProvider.notifier)
                      .updateSelection(value);
                  setState(() {
                    selectedSeedType = value;
                  });
                },
              ),
            ),
            DataCell(SizedBox(
              width: 50,
              child: Image.asset('assets/images/elephant.png'),
            )),
            DataCell(Text('${seedTypeList[2].price} $currency')),
            DataCell(Text('${seedTypeList[2].yieldLowRain} $currency')),
            DataCell(Text('${seedTypeList[2].yieldHighRain} $currency')),
          ],
        ),
      ],
    );
  }
}
