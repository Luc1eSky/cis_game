import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/dialogs/husband_or_wife_dialog.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectNewCoupleDialog extends ConsumerStatefulWidget {
  const SelectNewCoupleDialog({super.key});

  @override
  ConsumerState<SelectNewCoupleDialog> createState() => _SelectNewCoupleDialogState();
}

class _SelectNewCoupleDialogState extends ConsumerState<SelectNewCoupleDialog> {
  String dropdownValue = allLocations.first;
  final textController = TextEditingController();

  @override
  void initState() {
    String currentLocation =
        ref.read(gameDataNotifierProvider).currentCouple.coupleID.substring(1, 4);
    if (ref.read(gameDataNotifierProvider).currentCouple.currentPlayer != CurrentPlayer.none) {
      dropdownValue = currentLocation;
    }
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentLocation =
        ref.read(gameDataNotifierProvider).currentCouple.coupleID.substring(1, 4);
    return AlertDialog(
      title: const Text('Select New Couple'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            //mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'C',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DropdownMenu(
                initialSelection: ref.read(gameDataNotifierProvider).currentCouple.currentPlayer ==
                        CurrentPlayer.none
                    ? dropdownValue
                    : currentLocation,
                onSelected: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries: allLocations.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: textController,
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: '001-999',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          //Text('C$dropdownValue${textController.text.padLeft(3, '0')}'),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            String text = textController.text;
            if (text == "") {
              // TODO: SHOW WARNING
              print('no number');
              return;
            }
            if (int.parse(text) == 0) {
              // TODO: SHOW WARNING
              print('0 not allowed!');
              return;
            }
            String newCoupleID = 'C$dropdownValue${text.padLeft(3, '0')}';
            String newWifeID = 'W${newCoupleID.substring(1)}';
            String newHusbandID = 'H${newCoupleID.substring(1)}';

            // TODO: SELECT HUSBAND OR WIFE OF COUPLE GROUP
            print('selected: $newCoupleID');
            Navigator.of(context).pop();
            ref.read(gameDataNotifierProvider.notifier).changeCouple(
                  newCouple: Couple(
                    coupleID: newCoupleID,
                    wifeID: newWifeID,
                    husbandID: newHusbandID,
                  ),
                );
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return HusbandOrWifeDialog(coupleID: newCoupleID);
                });
          },
          child: const Text('Select'),
        ),
      ],
    );
  }
}

class LocationDropDown extends StatefulWidget {
  final String? currentLocation;
  const LocationDropDown({this.currentLocation, super.key});

  @override
  State<LocationDropDown> createState() => _LocationDropDownState();
}

class _LocationDropDownState extends State<LocationDropDown> {
  String dropdownValue = allLocations.first;

  @override
  void initState() {
    String? currentLocation = widget.currentLocation;
    if (currentLocation != null) {
      dropdownValue = currentLocation;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: widget.currentLocation ?? dropdownValue,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: allLocations.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
