import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/classes/enumerator.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../color_palette.dart';
import '../constants.dart';
import 'choose_player_dialog.dart';

class SelectNewCoupleDialog extends ConsumerStatefulWidget {
  const SelectNewCoupleDialog({super.key});

  @override
  ConsumerState<SelectNewCoupleDialog> createState() => _SelectNewCoupleDialogState();
}

class _SelectNewCoupleDialogState extends ConsumerState<SelectNewCoupleDialog> {
  // initialize dropdown variables
  String? locationDropdownValue;
  int? coupleNumberDropdownValue;
  String? enumeratorDropdownValue;

  @override
  void initState() {
    // get current location from coupleID of game data if there is a current player
    if (ref.read(gameDataNotifierProvider).currentCouple.currentPlayerType != PlayerType.none) {
      locationDropdownValue =
          ref.read(gameDataNotifierProvider).currentCouple.both.personalID.substring(1, 4);
      coupleNumberDropdownValue =
          int.parse(ref.read(gameDataNotifierProvider).currentCouple.both.personalID.substring(4));
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Enumerator',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 255,
                      height: 50,
                      child: InputDecorator(
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              hint: const Text('please choose'),
                              value: enumeratorDropdownValue,
                              items: enumerators.map<DropdownMenuItem<String>>((Enumerator value) {
                                String fullName = '${value.firstName} ${value.lastName}';

                                return DropdownMenuItem(value: fullName, child: Text(fullName));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  enumeratorDropdownValue = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Select New Couple',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 10),
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
                              hint: const Text('select'),
                              value: locationDropdownValue,
                              items: allLocations.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem(value: value, child: Text(value));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  locationDropdownValue = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: InputDecorator(
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              hint: const Text('select'),
                              value: coupleNumberDropdownValue,
                              items: coupleNumbers.map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem(value: value, child: Text('$value'));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  coupleNumberDropdownValue = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'C-${locationDropdownValue ?? "xxx"}-${coupleNumberDropdownValue == null ? "xx" : coupleNumberDropdownValue.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              // check if all fields were selected
              if (locationDropdownValue == null ||
                  coupleNumberDropdownValue == null ||
                  enumeratorDropdownValue == null) {
                print("SOMETHING IS NULL");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: ColorPalette().snackBar,
                    content: const Center(
                      child: Text('Please select all fields.'),
                    ),
                  ),
                );
                return;
              }

              // create coupleID from selected values
              String newCoupleID =
                  'C$locationDropdownValue${coupleNumberDropdownValue.toString().padLeft(2, '0')}';

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
      ),
    );
  }
}
