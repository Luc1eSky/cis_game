import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/field.dart';
import '../classes/level.dart';
import '../classes/result.dart';
import '../constants.dart';
import '../levels/levels.dart';
import 'game_data.dart';

final gameDataNotifierProvider =
    StateNotifierProvider<GameDataNotifier, GameData>((ref) => GameDataNotifier());

class GameDataNotifier extends StateNotifier<GameData> {
  GameDataNotifier()
      : super(
          GameData(
            cash: startingCash,
            savings: startingSavings,
            // generates initial list of fields that are empty
            currentFieldList: List.generate(
              numberOfFields,
              (index) => Field(fieldStatus: FieldStatus.empty),
            ),
            savedResults: [],
            levelIndex: 0,
            currentLevel: placeholderLevel,
            // initialize first couple with dummy information
            currentCouple: Couple(
              both: Person(
                personalID: 'test',
                hasPlayed: false,
                levels: [],
                playerType: PlayerType.both,
              ),
              wife: Person(
                personalID: 'test',
                hasPlayed: false,
                levels: [],
                playerType: PlayerType.wife,
              ),
              husband: Person(
                personalID: 'test',
                hasPlayed: false,
                levels: [],
                playerType: PlayerType.husband,
              ),
            ), // TODO: OVERWRITE
            // WITH SELECTION
            currentSeedType: null,
            season: 0,
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
    for (int index = 0; index < state.currentFieldList.length; index++) {
      if (state.currentFieldList[index].fieldStatus != FieldStatus.empty) {
        harvestFieldList
            .add(state.currentFieldList[index].copyWith(fieldStatus: FieldStatus.harvested));
      } else {
        harvestFieldList.add(state.currentFieldList[index].copyWith());
      }
    }
    state = state.copyWith(currentFieldList: harvestFieldList);
  }

  void selectSeedTypeAndBuySeed(int fieldIndex) {
    List<Field> updatedFieldList = [];

    // Check if user has enough cash to buy the seed
    if (state.cash >= state.currentSeedType!.price) {
      // go through the list of fields
      for (int index = 0; index < state.currentFieldList.length; index++) {
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
          updatedFieldList.add(state.currentFieldList[index].copyWith());
        }
      }
      // change the state by creating a new game data object with the new
      // list of fields
      state = state.copyWith(currentFieldList: updatedFieldList);

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
    state = state.copyWith(
      cash: startingCash,
      savings: startingSavings,
      // generates initial list of fields that are empty
      currentFieldList: List.generate(
        numberOfFields,
        (index) => Field(fieldStatus: FieldStatus.empty),
      ),
      levelIndex: state.levelIndex + 1,
      currentLevel: state.currentCouple.currentPlayer!.levels[state.levelIndex + 1],
      currentSeedType: null,
      season: state.season + 1,
      isNewSeason: true,
      allFieldsAreSeeded: false,
      // copied values: savedFieldLists, currentCouple
    );
  }

  void startNewGame() {
    state = state.copyWith(
      cash: startingCash,
      savings: startingSavings,
      // generates initial list of fields that are empty
      currentFieldList: List.generate(
        numberOfFields,
        (index) => Field(fieldStatus: FieldStatus.empty),
      ),
      savedResults: [],
      levelIndex: 0,
      currentLevel: placeholderLevel,
      // initialize first couple with dummy information
      currentCouple: Couple(
        both: Person(
          personalID: 'test',
          hasPlayed: false,
          levels: [],
          playerType: PlayerType.both,
        ),
        wife: Person(
          personalID: 'test',
          hasPlayed: false,
          levels: [],
          playerType: PlayerType.wife,
        ),
        husband: Person(
          personalID: 'test',
          hasPlayed: false,
          levels: [],
          playerType: PlayerType.husband,
        ),
      ),
      currentSeedType: null,
      season: 0,
      isNewSeason: true,
      allFieldsAreSeeded: false,
    );
  }

  void startNewSeasonAsNewPlayer() {
    state = state.copyWith(
      cash: startingCash,
      savings: startingSavings,
      // generates initial list of fields that are empty
      currentFieldList: List.generate(
        numberOfFields,
        (index) => Field(fieldStatus: FieldStatus.empty),
      ),
      levelIndex: 0,
      currentLevel: state.currentCouple.currentPlayer!.levels[0],
      currentSeedType: null,
      season: state.season + 1,
      isNewSeason: true,
      allFieldsAreSeeded: false,
      // copied values: savedFieldLists, currentCouple
    );
  }

  void setSeasonToCurrent() {
    state = state.copyWith(isNewSeason: false);
  }

  void _checkIfAllFieldsSeeded() {
    bool allFieldsPlanted = true;
    for (Field field in state.currentFieldList) {
      if (field.fieldStatus == FieldStatus.empty) {
        allFieldsPlanted = false;
        break;
      }
    }
    state = state.copyWith(allFieldsAreSeeded: allFieldsPlanted);
  }

  void changeCouple({required String newCoupleID}) {
    // creating individual IDs from couple ID
    String newWifeID = 'W${newCoupleID.substring(1)}';
    String newHusbandID = 'H${newCoupleID.substring(1)}';

    // copy individual level list
    List<Level> copiedIndividualLevels = [];
    for (Level level in individualLevels) {
      copiedIndividualLevels.add(level.copyWith());
    }
    // shuffle list randomly
    copiedIndividualLevels.shuffle();

    // take 4 levels for each participant
    List<Level> wifeLevels = copiedIndividualLevels.sublist(0, copiedIndividualLevels.length ~/ 2);
    List<Level> husbandLevels = copiedIndividualLevels.sublist(copiedIndividualLevels.length ~/ 2);

    print('husband:');
    for (Level level in husbandLevels) {
      print(level.levelID);
      print(level.rainForecast);
      print('---');
    }
    print('wife:');
    for (Level level in wifeLevels) {
      print(level.levelID);
      print(level.rainForecast);
      print('---');
    }

    // copy couple level list
    List<Level> copiedCoupleLevels = [];
    for (Level level in coupleLevels) {
      copiedCoupleLevels.add(level.copyWith());
    }
    // shuffle list randomly
    copiedCoupleLevels.shuffle();

    Couple newCouple = Couple(
      both: Person(
        personalID: newCoupleID,
        hasPlayed: false,
        levels: copiedCoupleLevels,
        playerType: PlayerType.both,
      ),
      wife: Person(
        personalID: newWifeID,
        hasPlayed: false,
        levels: wifeLevels,
        playerType: PlayerType.wife,
      ),
      husband: Person(
        personalID: newHusbandID,
        hasPlayed: false,
        levels: husbandLevels,
        playerType: PlayerType.husband,
      ),
    );

    state = state.copyWith(currentCouple: newCouple);
  }

  // change the current player and start first level
  void changePlayer({required PlayerType newPlayerType}) {
    state = state.copyWith(
      currentCouple: state.currentCouple.copyWith(currentPlayerType: newPlayerType),
    );
    startNewSeasonAsNewPlayer();
  }

  void checkIfLastLevelWasPlayed() {
    if (state.levelIndex + 1 == state.currentCouple.currentPlayer!.levels.length) {
      _setCurrentPlayerToHasPlayed();
    }
  }

  void _setCurrentPlayerToHasPlayed() {
    // read player type and get person object of current player
    Person? currentPlayer = state.currentCouple.currentPlayer;

    // exit if there is no player
    if (currentPlayer == null) {
      return;
    }

    // get a copy of the person with hasPlayed being true
    Person currentPlayerHasPlayed = currentPlayer.copyWith(hasPlayed: true);

    // copy couple with the updated person
    if (currentPlayer.playerType == PlayerType.wife) {
      state =
          state.copyWith(currentCouple: state.currentCouple.copyWith(wife: currentPlayerHasPlayed));
    }
    if (currentPlayer.playerType == PlayerType.husband) {
      state = state.copyWith(
          currentCouple: state.currentCouple.copyWith(husband: currentPlayerHasPlayed));
    }
    if (currentPlayer.playerType == PlayerType.both) {
      state =
          state.copyWith(currentCouple: state.currentCouple.copyWith(both: currentPlayerHasPlayed));
    }
  }

  void saveResult() {
    // create new result object from current data
    Result newResult = Result(
      level: state.currentLevel,
      personalID: state.currentCouple.currentPlayer!.personalID,
      savings: state.savings,
      zebraFields: state.zebras[0],
      lionFields: state.lions[0],
      elephantFields: state.elephants[0],
      zebraPayout: state.zebras[1],
      lionPayout: state.lions[1],
      elephantPayout: state.elephants[1],
      amountOfPlantedFields: state.total[0],
      totalPayout: state.total[1],
    );
    // get a copy of results list
    List<Result> currentResults = copySavedResults(state.savedResults);
    // add new result to it
    currentResults.add(newResult);
    // update state
    state = state.copyWith(savedResults: currentResults);
  }
}
