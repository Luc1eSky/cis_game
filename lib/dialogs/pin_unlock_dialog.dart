import 'dart:math';

import 'package:cis_game/color_palette.dart';
import 'package:cis_game/dialogs/choose_player_dialog.dart';
import 'package:cis_game/dialogs/select_new_couple_dialog.dart';
import 'package:cis_game/state_management/game_data_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';

class PinUnlockDialog extends StatefulWidget {
  const PinUnlockDialog({super.key});

  @override
  State<PinUnlockDialog> createState() => _PinUnlockDialogState();
}

class _PinUnlockDialogState extends State<PinUnlockDialog> {
  String pinCode = '';

  void addNumberToPin(int number) {
    if (pinCode.length < 4) {
      pinCode += number.toString();
      setState(() {});
    }
  }

  void deleteLastNumber() {
    if (pinCode.isNotEmpty) {
      pinCode = pinCode.substring(0, pinCode.length - 1);
      setState(() {});
    }
  }

  String formatPinCode(String rawPin) {
    rawPin = rawPin.padRight(4, '_');
    String formattedString = '';
    rawPin.split('').forEach((ch) {
      formattedString += '$ch ';
    });
    formattedString = formattedString.substring(0, formattedString.length - 1);
    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          height: min(MediaQuery.of(context).size.height * 0.7, maximumDialogHeight),
          child: AlertDialog(
            backgroundColor: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            title: const Center(
              child: Text(
                'Enumerator Unlock',
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: Center(
              child: AspectRatio(
                aspectRatio: 3 / 5,
                child: Column(
                  children: [
                    Expanded(
                      flex: 18,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          heightFactor: 0.75,
                          child: Container(
                            color: Colors.grey[700],
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.8,
                              child: FittedBox(
                                child: Text(
                                  formatPinCode(pinCode),
                                  style: const TextStyle(
                                    fontSize: 100,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 82,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 17,
                          crossAxisSpacing: 17,
                        ),
                        itemCount: 12,
                        itemBuilder: (BuildContext context, int index) {
                          int number = index + 1;
                          if (number == 11) {
                            number = 0;
                          }

                          // add delete button
                          if (number == 10) {
                            return PinButton(
                              backgroundColor: Colors.red,
                              onTapFunction: () {
                                print('delete');
                                deleteLastNumber();
                              },
                              buttonIconData: Icons.backspace_outlined,
                            );
                          }

                          // add submit button
                          if (number == 12) {
                            return Consumer(builder: (context, ref, child) {
                              return PinButton(
                                backgroundColor: Colors.green,
                                onTapFunction: () {
                                  if (pinCode == unlockPin) {
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          if (ref
                                              .read(gameDataNotifierProvider)
                                              .currentCouple
                                              .nooneHasPlayed) {
                                            return const SelectNewCoupleDialog();
                                          } else {
                                            return const ChoosePlayerDialog();
                                          }
                                        });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: ColorPalette().snackBar,
                                        content: const Center(
                                          child: Text('Code incorrect'),
                                        ),
                                      ),
                                    );
                                  }
                                  print('submit');
                                },
                                buttonIconData: Icons.check,
                              );
                            });
                          }

                          // add number entry button
                          return PinButton(
                            backgroundColor: Colors.grey[700]!,
                            onTapFunction: () {
                              print(number);
                              addNumberToPin(number);
                              // TODO: ADD NUMBER TO STRING
                            },
                            buttonText: number.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PinButton extends StatelessWidget {
  final Color backgroundColor;
  final VoidCallback onTapFunction;
  final String? buttonText;
  final IconData? buttonIconData;

  const PinButton({
    required this.backgroundColor,
    required this.onTapFunction,
    this.buttonText,
    this.buttonIconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),
      ),
      onPressed: onTapFunction,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: FittedBox(
            child: buttonText != null
                ? Text(
                    buttonText!,
                    style: const TextStyle(fontSize: 100),
                  )
                : buttonIconData != null
                    ? Icon(
                        buttonIconData,
                        size: 100,
                      )
                    : Container(),
          ),
        ),
      ),
    );
  }
}
