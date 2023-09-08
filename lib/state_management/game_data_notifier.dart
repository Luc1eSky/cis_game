import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/field.dart';
import '../constants.dart';
import '../levels/levels.dart';
import 'game_data.dart';

const int cashTransferStep = 10;

final gameDataNotifierProvider =
    StateNotifierProvider<GameDataNotifier, GameData>((ref) => GameDataNotifier());

class GameDataNotifier extends StateNotifier<GameData> {
  GameDataNotifier()
      : super(
          GameData(
            cash: 100,
            savings: 0,
            // generates initial list of fields that are empty
            fieldList: List.generate(
              numberOfFields,
              (index) => Field(fieldStatus: FieldStatus.empty),
            ),
            levelIndex: 0,
            currentLevel: randomizedLevels[0],
            currentCouple: Couple(
              coupleID: 'test',
              wifeID: 'test',
              husbandID: 'test',
            ), // TODO: OVERWRITE
            // WITH SELECTION
            currentSeedType: null,
            season: 1,
            isNewSeason: true,
            allFieldsAreSeeded: false,
          ),
        );

  // move money from cash to savings
  void cashToSavings({bool transferAll = false}) {
    double newCash;
    double newSavings;

    // transfer everything at once
    if (transferAll || state.cash - cashTransferStep <= 0) {
      newCash = 0;
      newSavings = state.savings + state.cash;
    }
    // transfer in steps
    else {
      newCash = state.cash - cashTransferStep;
      newSavings = state.savings + cashTransferStep;
    }

    // update state with cash and savings
    state = state.copyWith(
      cash: newCash,
      savings: newSavings,
    );
  }

  // move money from savings to cash
  void savingsToCash() {
    double newCash;
    double newSavings;

    // transfer cash in steps
    if (state.savings - cashTransferStep >= 0) {
      newCash = state.cash + cashTransferStep;
      newSavings = state.savings - cashTransferStep;
    }
    // if less money than step, transfer all
    else {
      newCash = state.cash + state.savings;
      newSavings = 0;
    }

    // update state with cash and savings
    state = state.copyWith(
      cash: newCash,
      savings: newSavings,
    );
  }

  // update the currently selected seed type (from selection dialog)
  void updateSelection(SeedType? newSeedType) {
    state = state.copyWith(currentSeedType: newSeedType);
  }

  // set the default seed type to be early maturity
  void setDefaultSeedSelection() {
    state = state.copyWith(currentSeedType: seedTypeList[0]);
  }

  void harvestFields() {
    List<Field> harvestFieldList = [];
    for (int index = 0; index < state.fieldList.length; index++) {
      if (state.fieldList[index].fieldStatus != FieldStatus.empty) {
        harvestFieldList.add(state.fieldList[index].copyWith(fieldStatus: FieldStatus.harvested));
      } else {
        harvestFieldList.add(state.fieldList[index].copyWith());
      }
    }
    state = state.copyWith(fieldList: harvestFieldList);
  }

  void selectSeedTypeAndBuySeed(int fieldIndex) {
    List<Field> updatedFieldList = [];

    // Check if user has enough cash to buy the seed
    if (state.cash >= state.currentSeedType!.price) {
      // go through the list of fields
      for (int index = 0; index < state.fieldList.length; index++) {
        // update list with new field for the field clicked and seedType
        // selected
        if (index == fieldIndex) {
          updatedFieldList
              .add(Field(seedType: state.currentSeedType, fieldStatus: FieldStatus.seeded));
          // adjust cash based on seed price
          state = state.copyWith(cash: state.cash - state.currentSeedType!.price);
        } else {
          // if the fields are not selected just copy them over from the old
          // list
          updatedFieldList.add(state.fieldList[index].copyWith());
        }
      }
      // change the state by creating a new game data object with the new
      // list of fields
      state = state.copyWith(fieldList: updatedFieldList);

      // check if all fields have been seeded
      _checkIfAllFieldsSeeded();
    } else {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          // show alert dialog if the user does not have enough cash left to
          // buy seed
          return AlertDialog(
            title: const Text('Not Enough Cash'),
            content: const Text('You do not have enough cash to buy this seed'
                '.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void startNewSeason() {
    state = GameData(
      cash: 100,
      savings: 0,
      // generates initial list of fields that are empty
      fieldList: List.generate(
        numberOfFields,
        (index) => Field(fieldStatus: FieldStatus.empty),
      ),
      levelIndex: state.levelIndex + 1,
      currentLevel: randomizedLevels[state.levelIndex + 1],
      currentCouple: state.currentCouple.copyWith(),
      currentSeedType: null,
      season: state.season + 1,
      isNewSeason: true,
      allFieldsAreSeeded: false,
    );
  }

  void setSeasonToCurrent() {
    state = state.copyWith(isNewSeason: false);
  }

  void _checkIfAllFieldsSeeded() {
    bool allFieldsPlanted = true;
    for (Field field in state.fieldList) {
      if (field.fieldStatus == FieldStatus.empty) {
        allFieldsPlanted = false;
        break;
      }
    }
    state = state.copyWith(allFieldsAreSeeded: allFieldsPlanted);
  }

  void changeCouple({required Couple newCouple}) {
    state = state.copyWith(currentCouple: newCouple);
  }

  void changePlayer({required CurrentPlayer newPlayer}) {
    Couple currentCouple = state.currentCouple;
    state = state.copyWith(currentCouple: currentCouple.copyWith(currentPlayer: newPlayer));
  }
}
