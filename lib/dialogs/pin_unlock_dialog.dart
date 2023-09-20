import 'dart:math';

import 'package:cis_game/dialogs/select_new_couple_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../color_palette.dart';
import '../constants.dart';
import '../state_management/game_data_notifier.dart';
import 'choose_player_dialog.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight < minimumScreenHeight) {
      return const SizedBox();
    }
    double dialogHeight = min(MediaQuery.of(context).size.height * 0.7, pinUnlockDialogMaxHeight);
    double dialogWidth = dialogHeight / 5.5 * 3;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(dialogWidth * 0.10),
          ),
          child: Padding(
            padding: EdgeInsets.all(dialogWidth * 0.08),
            child: SizedBox(
              height: dialogHeight,
              width: dialogWidth,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      //color: Colors.yellow,
                      child: const FractionallySizedBox(
                        widthFactor: 0.8,
                        heightFactor: 0.8,
                        child: FittedBox(
                          child: Text(
                            'Enumerator unlock',
                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 16,
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      heightFactor: 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(dialogWidth * 0.06),
                        ),
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          heightFactor: 0.7,
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
                  Expanded(
                    flex: 69,
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      heightFactor: 0.9,
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: dialogWidth * 0.07,
                        crossAxisSpacing: dialogWidth * 0.07,
                        children: List.generate(
                          12,
                          (index) {
                            int number = index + 1;

                            // add delete button
                            if (number == 10) {
                              return PinButton(
                                backgroundColor: Colors.red,
                                onTapFunction: () {
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

                            if (number == 11) {
                              number = 0;
                            }

                            return PinButton(
                              backgroundColor: Colors.grey[700]!,
                              onTapFunction: () {
                                print(number);
                                addNumberToPin(number);
                              },
                              buttonText: number.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
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
    return LayoutBuilder(builder: (context, constraints) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(constraints.maxWidth * 0.2),
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
    });
  }
}
