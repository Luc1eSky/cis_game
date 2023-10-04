import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/main_screen/widgets/interaction_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/seed_type.dart';
import '../constants.dart';
import '../data/seedtypes.dart';
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
    return DialogTemplate(
      title: Text('Field ${widget.fieldIndex + 1}'),
      // content
      content: DataTable(
        columns: <DataColumn>[
          const DataColumn(
            label: Expanded(
              child: Text(
                '',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: SizedBox(
                width: 35,
                child: Image.asset('assets/images/harvest_icon.png'),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: SizedBox(
                width: 50,
                child: Image.asset('assets/images/K100_note.jpeg'),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
                child: Icon(
              Icons.cloud,
              color: Colors.grey[400],
              size: 50,
            )),
          ),
          const DataColumn(
            label: Expanded(
                child: Icon(
              Icons.cloudy_snowing,
              color: Colors.blue,
              size: 50,
            )),
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
                  child: Image.asset('assets/images/elephant.png'),
                ),
              ),
              DataCell(Text('${seedTypeList[2].price} $currency')),
              DataCell(Text('${seedTypeList[2].yieldNoRain} $currency')),
              DataCell(Text('${seedTypeList[2].yieldRain} $currency')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                Radio<SeedType>(
                  value: seedTypeList[3],
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
                  height: 40,
                  child: Image.asset('assets/images/K100_note.jpeg'),
                ),
              ),
              const DataCell(Text('')),
              const DataCell(Text('')),
              const DataCell(Text('')),
            ],
          ),
        ],
      ),
      actions: const [
        InteractionButton(
            color: Colors.red, icon: Icon(Icons.close), returnBoolean: false),
        InteractionButton(
            color: Colors.green, icon: Icon(Icons.check), returnBoolean: true)
      ],
    );
  }
}
