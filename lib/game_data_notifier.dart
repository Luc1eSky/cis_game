import 'package:cis_game/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants.dart';
import 'field.dart';
import 'game_data.dart';

const int cashTransferStep = 10;

final gameDataNotifierProvider =
    StateNotifierProvider<GameDataNotifier, GameData>(
        (ref) => GameDataNotifier());

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
            currentForecast: 3,
            currentSeedType: null,
            season: 1,
            isNewSeason: true,
          ),
        );

  void cashToSavings() {
    if (state.cash - cashTransferStep >= 0) {
      state = state.copyWith(
        cash: state.cash - cashTransferStep,
        savings: state.savings + cashTransferStep,
      );
    }
  }

  void savingsToCash() {
    if (state.savings - cashTransferStep >= 0) {
      state = state.copyWith(
        cash: state.cash + cashTransferStep,
        savings: state.savings - cashTransferStep,
      );
    }
  }

  void updateSelection(SeedType? newSeedType) {
    state = state.copyWith(currentSeedType: newSeedType);
  }

  void setDefaultSeedSelection() {
    // set the default seed type to be early maturity
    state = state.copyWith(currentSeedType: seedTypeList[0]);
  }

  void harvestFields() {
    List<Field> harvestFieldList = [];
    for (int index = 0; index < state.fieldList.length; index++) {
      if (state.fieldList[index].fieldStatus != FieldStatus.empty) {
        harvestFieldList.add(state.fieldList[index]
            .copyWith(fieldStatus: FieldStatus.harvested));
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
          updatedFieldList.add(Field(
              seedType: state.currentSeedType,
              fieldStatus: FieldStatus.seeded));
          // adjust cash based on seed price
          state =
              state.copyWith(cash: state.cash - state.currentSeedType!.price);
        } else {
          // if the fields are not selected just copy them over from the old
          // list
          updatedFieldList.add(state.fieldList[index].copyWith());
        }
      }
      // change the state by creating a new game data object with the new
      // list of fields
      state = state.copyWith(fieldList: updatedFieldList);
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
      // Todo: need to be randomized
      currentForecast: 3,
      currentSeedType: null,
      // Todo: Does not update to 2???
      season: state.season + 1,
      isNewSeason: true,
    );
  }

  void setSeasonToCurrent() {
    state = state.copyWith(isNewSeason: false);
  }

  int calculateFieldsAndProfitPerType() {
    int fieldsZebra = 0;
    for (int index = 0; index < state.fieldList.length; index++) {
      if (state.fieldList[index].seedType!.animalName == 'zebra') {
        fieldsZebra++;
      }
    }
    return (fieldsZebra);
  }
}
