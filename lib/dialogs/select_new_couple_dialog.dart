import 'package:cis_game/classes/enumerator.dart';
import 'package:cis_game/classes/location.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/session.dart';
import '../color_palette.dart';
import '../constants.dart';
import '../data/enumerators.dart';
import '../data/locations.dart';
import 'choose_player_dialog.dart';

class SelectNewCoupleDialog extends ConsumerStatefulWidget {
  const SelectNewCoupleDialog({super.key});

  @override
  ConsumerState<SelectNewCoupleDialog> createState() =>
      _SelectNewCoupleDialogState();
}

class _SelectNewCoupleDialogState extends ConsumerState<SelectNewCoupleDialog> {
  // initialize dropdown variables
  Enumerator? enumeratorDropdownValue;
  Location? locationDropdownValue;
  Session? sessionDropdownValue;
  int? coupleNumberDropdownValue;

  @override
  void initState() {
    // use current enumerator as default value
    Enumerator? currentEnumerator =
        ref.read(gameDataNotifierProvider).currentEnumerator;
    if (currentEnumerator != null) {
      enumeratorDropdownValue = enumerators.firstWhere(
          (enumerator) => enumerator.fullName == currentEnumerator.fullName);
    }

    // // TODO: get current location from last couple?
    // if (ref.read(gameDataNotifierProvider).currentCouple.currentPlayerType != PlayerType.none) {
    //   locationDropdownValue =
    //       ref.read(gameDataNotifierProvider).currentCouple.both.personalID.substring(1, 4);
    //   coupleNumberDropdownValue =
    //       int.parse(ref.read(gameDataNotifierProvider).currentCouple.both.personalID.substring(4));
    // }

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
      body: DialogTemplate(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enumerator:',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 270,
                      height: 50,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 10.0)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text('please choose'),
                            value: enumeratorDropdownValue,
                            items: enumerators.map((Enumerator enumerator) {
                              return DropdownMenuItem(
                                  value: enumerator,
                                  child: Text(enumerator.fullName));
                            }).toList(),
                            onChanged: (value) {
                              setState(
                                () {
                                  enumeratorDropdownValue = value!;
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Location:',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 270,
                  height: 50,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(left: 10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text('select'),
                        value: locationDropdownValue,
                        items: allLocations.map<DropdownMenuItem<Location>>(
                            (Location location) {
                          return DropdownMenuItem(
                              value: location,
                              child: Text(
                                  '${location.acronym} - ${location.name}'));
                        }).toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              locationDropdownValue = value!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Session and Couple ID',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 10),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 50,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              hint: const Text('select'),
                              value: sessionDropdownValue,
                              items: Session.values
                                  .map<DropdownMenuItem<Session>>(
                                      (Session session) {
                                return DropdownMenuItem(
                                    value: session,
                                    child: Text(
                                        '${session.name} - ${session.short}'));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  sessionDropdownValue = value!;
                                });
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 10.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              hint: const Text('select'),
                              value: coupleNumberDropdownValue,
                              items: List.generate(
                                      maxNumberOfCouplesPerLocation,
                                      (index) => index + 1)
                                  .map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem(
                                    value: value, child: Text('$value'));
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
              'C-${locationDropdownValue?.acronym ?? "xxx"}-${sessionDropdownValue?.short ?? "xx"}-'
              '${coupleNumberDropdownValue == null ? "xx" : coupleNumberDropdownValue.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              String? locationAcronym = locationDropdownValue?.acronym;
              String? sessionShort = sessionDropdownValue?.short;
              // check if all fields were selected
              if (locationAcronym == null ||
                  sessionShort == null ||
                  coupleNumberDropdownValue == null ||
                  enumeratorDropdownValue == null) {
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
                  'C$locationAcronym$sessionShort${coupleNumberDropdownValue.toString().padLeft(2, '0')}';

              final notifier = ref.read(gameDataNotifierProvider.notifier);

              // change the current couple to the selected one
              notifier.changeCouple(newCoupleID: newCoupleID);

              // set current location
              notifier.setCurrentLocation(newLocation: locationDropdownValue!);

              // set current session
              notifier.setCurrentSession(newSession: sessionDropdownValue!);

              // set currentEnumerator
              notifier.setCurrentEnumerator(
                  newEnumerator: enumeratorDropdownValue!);

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
