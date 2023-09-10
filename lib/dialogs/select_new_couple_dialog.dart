import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'choose_player_dialog.dart';

class SelectNewCoupleDialog extends ConsumerStatefulWidget {
  const SelectNewCoupleDialog({super.key});

  @override
  ConsumerState<SelectNewCoupleDialog> createState() => _SelectNewCoupleDialogState();
}

class _SelectNewCoupleDialogState extends ConsumerState<SelectNewCoupleDialog> {
  // initialize text field controller and dropdown variable
  String dropdownValue = allLocations.first;
  final textController = TextEditingController();

  @override
  void initState() {
    // set initial value of text field
    textController.text = '001';
    // update state after text field value changes
    textController.addListener(() {
      setState(() {});
    });
    // get current location from coupleID of game data if there is a current player
    if (ref.read(gameDataNotifierProvider).currentCouple.currentPlayerType != PlayerType.none) {
      dropdownValue =
          ref.read(gameDataNotifierProvider).currentCouple.both.personalID.substring(1, 4);
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
              SizedBox(
                width: 100,
                height: 50,
                child: InputDecorator(
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: dropdownValue,
                        items: allLocations.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            dropdownValue = value!;
                          });
                        }),
                  ),
                ),
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
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'C-$dropdownValue-${textController.text.padLeft(3, '0')}',
            style: const TextStyle(fontSize: 20),
          ),
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
            // create coupleID from selected values
            String newCoupleID = 'C$dropdownValue${text.padLeft(3, '0')}';

            // change the current couple to the selected one
            ref.read(gameDataNotifierProvider.notifier).changeCouple(newCoupleID: newCoupleID);

            Navigator.of(context).pop();

            // open the next dialog to select the player
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const ChoosePlayerDialog();
                });
          },
          child: const Text('Select'),
        ),
      ],
    );
  }
}
