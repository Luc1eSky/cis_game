import 'dart:math';

import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/classes/enumerator.dart';
import 'package:cis_game/classes/session.dart';
import 'package:cis_game/data/alternative_levels.dart';
import 'package:cis_game/data/seedtypes.dart';
import 'package:cis_game/dialogs/dialog_template.dart';
import 'package:cis_game/main.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/alternative_level_bundle.dart';
import '../classes/field.dart';
import '../classes/level.dart';
import '../classes/level_result.dart';
import '../classes/location.dart';
import '../classes/plantingAdvice.dart';
import '../classes/seed_type.dart';
import '../constants.dart';
import '../data/levels.dart';
import 'game_data.dart';

final gameDataNotifierProvider =
    StateNotifierProvider<GameDataNotifier, GameData>(
        (ref) => GameDataNotifier());

class GameDataNotifier extends StateNotifier<GameData> {
  GameDataNotifier()
      : super(
          GameData(
            startingTime: DateTime.now(),
            cash: startingCash,
            savings: startingSavings,
            // generates initial list of fields that are empty
            currentFieldList: List.generate(
              numberOfFields,
              (index) =>
                  Field(fieldStatus: FieldStatus.empty, seedType: seedTypeNone),
            ),
            savedResults: [],
            levelIndex: 0,
            currentLevel: practiceLevels[0],
            // initialize first couple with practice level information
            currentCouple: practiceCouple,
            currentLocation: dummyLocation,
            currentSession: Session.morning,
            currentSeedType: null,
            season: 1,
            newSeasonHasStarted: true,
            allFieldsAreSeeded: false,
            currentEnumerator: null,
            isInPracticeMode: true, // start in practice mode
            buttonsAreActive: true,
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

  void growFields() {
    List<Field> growFieldList = [];
    for (int index = 0; index < state.currentFieldList.length; index++) {
      if (state.currentFieldList[index].fieldStatus != FieldStatus.empty) {
        growFieldList.add(state.currentFieldList[index]
            .copyWith(fieldStatus: FieldStatus.grown));
      } else {
        growFieldList.add(state.currentFieldList[index].copyWith());
      }
    }
    state = state.copyWith(currentFieldList: growFieldList);
  }

  void harvestFields() {
    List<Field> harvestFieldList = [];
    for (int index = 0; index < state.currentFieldList.length; index++) {
      if (state.currentFieldList[index].fieldStatus != FieldStatus.empty) {
        harvestFieldList.add(state.currentFieldList[index]
            .copyWith(fieldStatus: FieldStatus.harvested));
      } else {
        harvestFieldList.add(state.currentFieldList[index].copyWith());
      }
    }
    state = state.copyWith(currentFieldList: harvestFieldList);
  }

  void selectSeedTypeAndBuySeed(int fieldIndex) {
    SeedType? selectedSeedType = state.currentSeedType;
    if (selectedSeedType == null) {
      return;
    }
    //print(selectedSeedType.animalName);
    List<Field> updatedFieldList = [];
    double priceToPay = selectedSeedType.price -
        (state.currentFieldList[fieldIndex].seedType.price);
    // Check if user has enough cash to buy the selected seed
    if (state.cash >= priceToPay) {
      // go through the list of fields
      for (int index = 0; index < state.currentFieldList.length; index++) {
        // update list with new field for the field clicked and seedType
        // selected
        if (index == fieldIndex) {
          // case where the field gets unplanted
          if (selectedSeedType == seedTypeNone) {
            updatedFieldList.add(
              Field(seedType: seedTypeNone, fieldStatus: FieldStatus.empty),
            );
          } else {
            // buy seed for specific field
            updatedFieldList.add(
              Field(
                  seedType: selectedSeedType, fieldStatus: FieldStatus.seeded),
            );
          }
          // adjust cash based on seed price
          state = state.copyWith(cash: state.cash - priceToPay);
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
          return DialogTemplate(
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

  /// check if there are any fields that are currently seeded (with any seedType)
  int countSeededFields() {
    List<Field> foundFields = state.currentFieldList
        .where((field) => field.fieldStatus == FieldStatus.seeded)
        .toList();
    return foundFields.length;
  }

  /// unplant all fields and set money back to starting cash
  void unplantAllFields() {
    List<Field> updatedFieldList = state.currentFieldList
        .map(
          (Field field) => field.copyWith(
            seedType: seedTypeNone,
            fieldStatus: FieldStatus.empty,
          ),
        )
        .toList();
    state = state.copyWith(
      cash: startingCash,
      savings: startingSavings,
      currentFieldList: updatedFieldList,
    );
  }

  /// select all empty fields with a selected SeedType
  int selectAllEmptyFields(SeedType selectedSeedType) {
    List<Field> updatedFieldList = [];
    int emptyFieldsCount = 0;
    for (int index = 0; index < state.currentFieldList.length; index++) {
      if (state.currentFieldList[index].fieldStatus == FieldStatus.empty) {
        emptyFieldsCount++;
        updatedFieldList.add(Field(
            seedType: selectedSeedType, fieldStatus: FieldStatus.selected));
      } else {
        updatedFieldList.add(state.currentFieldList[index].copyWith());
      }
    }
    state = state.copyWith(currentFieldList: updatedFieldList);
    return emptyFieldsCount;
  }

  /// unselect all selected fields
  void unselectAllSelectedFields() {
    List<Field> updatedFieldList = [];

    for (int index = 0; index < state.currentFieldList.length; index++) {
      if (state.currentFieldList[index].fieldStatus == FieldStatus.selected) {
        updatedFieldList
            .add(Field(seedType: seedTypeNone, fieldStatus: FieldStatus.empty));
      } else {
        updatedFieldList.add(state.currentFieldList[index].copyWith());
      }
    }
    state = state.copyWith(currentFieldList: updatedFieldList);
  }

  /// calculate needed cash to plant all empty fields with selected SeedType
  double calculatePriceForSelectedFields(SeedType selectedSeedType) {
    int emptyFieldCounter = 0;
    // go through the list of fields
    for (int index = 0; index < state.currentFieldList.length; index++) {
      if (state.currentFieldList[index].fieldStatus == FieldStatus.selected) {
        emptyFieldCounter++;
      }
    }
    // calculate price to pay for all selected fields
    return emptyFieldCounter * selectedSeedType.price;
  }

  /// check if enough money to plant all selected fields
  bool enoughCashForSelectedFields(SeedType selectedSeedType) {
    bool enoughCash =
        (state.cash - calculatePriceForSelectedFields(selectedSeedType)) >= 0;
    return enoughCash;
  }

  /// planting all empty fields with a selected SeedType
  void plantAllSelectedFields(SeedType selectedSeedType) {
    List<Field> updatedFieldList = [];
    double priceToPay = calculatePriceForSelectedFields(selectedSeedType);
    for (int index = 0; index < state.currentFieldList.length; index++) {
      // update list with new field for the field clicked
      // and seedType selected
      if (state.currentFieldList[index].fieldStatus == FieldStatus.selected) {
        // add new field with see type and status seeded
        updatedFieldList.add(
            Field(seedType: selectedSeedType, fieldStatus: FieldStatus.seeded));
      } else {
        // copy existing field
        updatedFieldList.add(state.currentFieldList[index].copyWith());
      }
    }
    // update game data with updated field list and cash
    state = state.copyWith(
        currentFieldList: updatedFieldList, cash: state.cash - priceToPay);
  }

  void unplantSeed() {
    state = state.copyWith(cash: state.cash + state.currentSeedType!.price);
  }

  void startNewSeason() {
    state = state.copyWith(
      startingTime: DateTime.now(),
      cash: startingCash,
      savings: startingSavings,
      // generates initial list of fields that are empty
      currentFieldList: List.generate(
        numberOfFields,
        (index) =>
            Field(fieldStatus: FieldStatus.empty, seedType: seedTypeNone),
      ),
      // increase level by one
      levelIndex: state.levelIndex + 1,
      currentLevel:
          state.currentCouple.currentPlayer!.levels[state.levelIndex + 1],
      currentSeedType: null,
      season: state.season + 1,
      newSeasonHasStarted: true,
      allFieldsAreSeeded: false,
      isInPracticeMode: state.isInPracticeMode,
      buttonsAreActive: true,
    );
  }

  void startNewGame({required newSeasonHasStarted}) {
    state = state.copyWith(
      startingTime: DateTime.now(),
      cash: startingCash,
      savings: startingSavings,
      // generates initial list of fields that are empty
      currentFieldList: List.generate(
        numberOfFields,
        (index) =>
            Field(fieldStatus: FieldStatus.empty, seedType: seedTypeNone),
      ),
      savedResults: [],
      levelIndex: 0,
      currentLevel: practiceLevels[0],
      // initialize first couple with dummy information
      currentCouple: practiceCouple,
      currentSeedType: null,
      season: state.isInPracticeMode ? 1 : 0,
      newSeasonHasStarted: newSeasonHasStarted,
      allFieldsAreSeeded: false,
      isInPracticeMode: state.isInPracticeMode,
      buttonsAreActive: true,
    );
  }

  void startNewGameAsNewPlayer() {
    state = state.copyWith(
      startingTime: DateTime.now(),
      cash: startingCash,
      savings: startingSavings,
      // generates initial list of fields that are empty
      currentFieldList: List.generate(
        numberOfFields,
        (index) =>
            Field(fieldStatus: FieldStatus.empty, seedType: seedTypeNone),
      ),
      levelIndex: 0,
      currentLevel: state.currentCouple.currentPlayer!.levels[0],
      currentSeedType: null,
      season: 1,
      newSeasonHasStarted: true,
      allFieldsAreSeeded: false,
      isInPracticeMode: state.isInPracticeMode,
      // copied values: savedFieldLists, currentCouple
      buttonsAreActive: true,
    );
  }

  void setSeasonToCurrent() {
    state = state.copyWith(newSeasonHasStarted: false);
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

  List<Level> createLevelListWithAlternatives({
    required String coupleID,
    required List<Level> originalLevelList,
    required PlayerType playerType,
  }) {
    List<Level> levelListWithAlternatives = [];

    // get ID number from couple ID
    int idNumber = int.parse(coupleID.substring(coupleID.length - 2));

    // for each level
    for (Level level in originalLevelList) {
      // get alternative levels for level ID (or null)
      AlternativeLevels? altLevels = allAlternativeLevels.firstWhereOrNull(
          (altLevels) => altLevels.linkedLevelId == level.levelID);
      // if alternatives do not exists
      if (altLevels == null) {
        // copy original level
        levelListWithAlternatives.add(level.copyWith());
      }
      // if alternatives exist
      else {
        // get length of alternative levels
        int altLevelsLength = altLevels.levels.length;

        // and find alternative level
        int? groupNumber;
        Level? alternativeLevel;
        for (int i = 1; i <= altLevelsLength; i++) {
          if ((idNumber - i) % altLevelsLength == 0) {
            groupNumber = i;
            if (playerType == PlayerType.wife) {
              AlternativeLevelBundle altLevelBundle =
                  altLevels.levels[groupNumber - 1];
              alternativeLevel = altLevelBundle.wifeLevel.copyWith();
            }
            if (playerType == PlayerType.husband) {
              AlternativeLevelBundle altLevelBundle =
                  altLevels.levels[groupNumber - 1];
              alternativeLevel = altLevelBundle.husbandLevel.copyWith();
            }
            break;
          }
        }

        // check if alternative level is null
        if (alternativeLevel == null) {
          debugPrint('ERROR - COULD NOT FIND ALTERNATIVE LEVEL FOR');
          debugPrint('LEVEL ID: ${level.levelID}');
          debugPrint('CALCULATED GROUP NUMBER: $groupNumber');
          debugPrint('PLAYER TYPE: ${playerType.name}');
          // copy original level
          levelListWithAlternatives.add(level.copyWith());
        }
        // add alternative level
        else {
          levelListWithAlternatives.add(alternativeLevel);
        }
      }
    }

    return levelListWithAlternatives;
  }

  void changeCouple({required String newCoupleID}) {
    // creating individual IDs from couple ID
    String newWifeID = 'W${newCoupleID.substring(1)}';
    String newHusbandID = 'H${newCoupleID.substring(1)}';

    // copy individual level list
    List<Level> copiedWifeLevels = [];
    for (Level level in individualLevels) {
      copiedWifeLevels.add(level.copyWith());
    }
    // shuffle list randomly
    copiedWifeLevels.shuffle();

    // replace levels with alternatives based on
    // levelID, PlayerType, and coupleID
    List<Level> wifeLevelsWithAlternatives = createLevelListWithAlternatives(
      coupleID: newCoupleID,
      originalLevelList: copiedWifeLevels,
      playerType: PlayerType.wife,
    );

    // copy individual level list
    List<Level> copiedHusbandLevels = [];
    for (Level level in individualLevels) {
      copiedHusbandLevels.add(level.copyWith());
    }
    // shuffle list randomly
    copiedHusbandLevels.shuffle();

    // replace levels with alternatives based on
    // levelID, PlayerType, and coupleID
    List<Level> husbandLevelsWithAlternatives = createLevelListWithAlternatives(
      coupleID: newCoupleID,
      originalLevelList: copiedHusbandLevels,
      playerType: PlayerType.husband,
    );

    // take 4 levels for each participant
    // List<Level> wifeLevels =
    //     copiedIndividualLevels.sublist(0, copiedIndividualLevels.length ~/ 2);
    // List<Level> husbandLevels =
    //     copiedIndividualLevels.sublist(copiedIndividualLevels.length ~/ 2);

    // print('husband:');
    // for (Level level in husbandLevelsWithAlternatives) {
    //   print(level.levelID);
    //   print(level.rainForecast);
    //   print(level.plantingAdvice);
    //   print('---');
    // }
    // print('wife:');
    // for (Level level in wifeLevelsWithAlternatives) {
    //   print(level.levelID);
    //   print(level.rainForecast);
    //   print(level.plantingAdvice);
    //   print('---');
    // }

    // copy couple level list
    List<Level> copiedCoupleLevels = [];
    for (Level level in coupleLevels) {
      copiedCoupleLevels.add(level.copyWith());
    }
    // shuffle list randomly
    copiedCoupleLevels.shuffle();

    // print('couple:');
    // for (Level level in copiedCoupleLevels) {
    //   print(level.levelID);
    //   print(level.rainForecast);
    //   print('---');
    // }

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
        levels: wifeLevelsWithAlternatives,
        playerType: PlayerType.wife,
      ),
      husband: Person(
        personalID: newHusbandID,
        hasPlayed: false,
        levels: husbandLevelsWithAlternatives,
        playerType: PlayerType.husband,
      ),
    );

    state = state.copyWith(currentCouple: newCouple);
  }

  // change the current player and start first level
  void changePlayer({required PlayerType newPlayerType}) {
    state = state.copyWith(
      currentCouple:
          state.currentCouple.copyWith(currentPlayerType: newPlayerType),
    );
    startNewGameAsNewPlayer();
  }

  void checkIfLastLevelWasPlayed() {
    // otherwise check if it was the last level of the current player
    if (state.levelIndex + 1 ==
        state.currentCouple.currentPlayer!.levels.length) {
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
      state = state.copyWith(
          currentCouple:
              state.currentCouple.copyWith(wife: currentPlayerHasPlayed));
    }
    if (currentPlayer.playerType == PlayerType.husband) {
      state = state.copyWith(
          currentCouple:
              state.currentCouple.copyWith(husband: currentPlayerHasPlayed));
    }
    if (currentPlayer.playerType == PlayerType.both) {
      state = state.copyWith(
          currentCouple:
              state.currentCouple.copyWith(both: currentPlayerHasPlayed));
    }
  }

  void saveResult() {
    // create new result object from current data
    LevelResult newResult = LevelResult(
      enumerator: state.currentEnumerator,
      playerID: state.currentCouple.currentPlayer?.personalID,
      location: state.currentLocation,
      session: state.currentSession,
      playerNumber: state.currentCouple.currentPlayer?.number,
      playerType: state.currentCouple.currentPlayerType,
      level: state.currentLevel,
      season: state.season,
      startedOn: state.startingTime,
      endedOn: DateTime.now(),
      plantingAdviceHighRisk: getAdviceRiskHigh(),
      plantingAdviceLowRisk: getAdviceRiskLow(),
      startingCash: startingCash,
      startingSavings: startingSavings,
      zebraFields: state.zebras[0],
      lionFields: state.lions[0],
      elephantFields: state.elephants[0],
      earningsZebras: state.zebras[1].toDouble(),
      earningsLions: state.lions[1].toDouble(),
      earningsElephants: state.elephants[1].toDouble(),
    );
    // get a copy of results list
    List<LevelResult> currentResults = copySavedResults(state.savedResults);
    // add new result to it
    currentResults.add(newResult);
    // update state
    state = state.copyWith(savedResults: currentResults);
  }

  void printPlayerResults() {
    List<LevelResult> allResults = state.savedResults;

    int lastEntries = state.currentCouple.currentPlayerType == PlayerType.both
        ? coupleLevels.length
        : individualLevels.length;

    List<LevelResult> currentPlayerResults =
        allResults.sublist(allResults.length - lastEntries);

    for (LevelResult result in currentPlayerResults) {
      print('----------');
      print('----------');
      print('ENUMERATOR: ${state.currentEnumerator?.fullName}');
      print('-----');
      print('PLAYER ID: ${state.currentCouple.currentPlayer?.formattedID}');
      print('PLAYER TYPE: ${result.playerType?.name}');
      print('LOCATION: ${state.currentLocation.name}');
      print('SESSION: ${state.currentSession.name}');
      print('PLAYER NUMBER: ${state.currentCouple.currentPlayer?.number}');
      print('-----');
      print('SEASON: ${state.season}');
      print('STARTING TIME: ${result.startedOn}');
      print('END TIME: ${result.endedOn}');
      print('TIME PLAYED: ${result.timePlayedInSeconds} seconds');
      print('-----');
      print('LEVEL ID: ${result.level.levelID}');
      print('FORECAST: ${result.level.rainForecast}');
      print('RAINING: ${result.level.isRaining}');
      print('ADVICE: ${result.level.plantingAdvice}');
      print('ADV. LOW RISK: ${result.plantingAdviceLowRisk.name}');
      print('ADV. HIGH RISK: ${result.plantingAdviceHighRisk.name}');
      print('-----');
      print('STARTING CASH: ${result.startingCash}');
      print('STARTING SAVINGS: ${result.startingSavings}');
      print('MONEY SPENT: ${result.costsTotal}');
      print('MONEY EARNED: ${result.earningsTotal}');
      print('STORED IN SAVINGS: ${result.storedInSavings}');
      print('TOTAL MONEY AT END: ${result.totalMoneyAtEnd}');
      print('-----');
      print('ZEBRA FIELDS: ${result.zebraFields}');
      print('LION FIELDS: ${result.lionFields}');
      print('ELEPHANT FIELDS: ${result.elephantFields}');
      print('ALL FIELDS: ${result.fieldsTotal}');
      print('-----');
      print('ZEBRAS COSTS: ${result.costsZebras}');
      print('LIONS COSTS: ${result.costsLions}');
      print('ELEPHANTS COSTS: ${result.costsElephants}');
      print('-----');
      print('ZEBRAS EARNINGS: ${result.earningsZebras}');
      print('LIONS EARNINGS: ${result.earningsLions}');
      print('ELEPHANTS EARNINGS: ${result.earningsElephants}');
      print('----------');
      print('----------');
    }
  }

  void randomizeWeatherEvent() {
    int? rainForecast = state.currentLevel.rainForecast;

    rainForecast ??= noForecastRainChance;
    int intValue = (Random().nextInt(maxNumberForecast) + 1); // 1-5
    print('The forecast: $rainForecast');
    print('The random number: $intValue');
    if (intValue <= rainForecast) {
      print('It rains');
      state = state.copyWith(
          currentLevel: state.currentLevel.copyWith(isRaining: true));
    } else {
      print('It does not rain');
    }
  }

  PlantingAdvice getAdviceRiskHigh() {
    int? currentForecast = state.currentLevel.rainForecast;
    switch (currentForecast) {
      case 0:
        return PlantingAdvice.dontPlant;
      case 1:
        return PlantingAdvice.plantZebra;
      case 2:
        return PlantingAdvice.plantZebra;
      case 4:
        return PlantingAdvice.plantElephant;
      case 5:
        return PlantingAdvice.plantElephant;
      default:
        return PlantingAdvice.noAdvice;
    }
  }

  PlantingAdvice getAdviceRiskLow() {
    int? currentForecast = state.currentLevel.rainForecast;
    switch (currentForecast) {
      case 0:
        return PlantingAdvice.dontPlant;
      case 1:
        return PlantingAdvice.dontPlant;
      case 2:
        return PlantingAdvice.plantZebra;
      case 4:
        return PlantingAdvice.plantLion;
      case 5:
        return PlantingAdvice.plantElephant;
      default:
        return PlantingAdvice.noAdvice;
    }
  }

  String? getAnimalRiskHigh() {
    PlantingAdvice adviceHighRisk = getAdviceRiskHigh();
    switch (adviceHighRisk) {
      case PlantingAdvice.dontPlant:
        return 'no_planting.png';
      case PlantingAdvice.plantZebra:
        return 'zebra.png';
      case PlantingAdvice.plantLion:
        return 'zebra.png';
      case PlantingAdvice.plantElephant:
        return 'elephant.png';
      default:
        return null;
    }
  }

  String? getAnimalRiskLow() {
    PlantingAdvice adviceLowRisk = getAdviceRiskLow();
    switch (adviceLowRisk) {
      case PlantingAdvice.dontPlant:
        return 'no_planting.png';
      case PlantingAdvice.plantZebra:
        return 'zebra.png';
      case PlantingAdvice.plantLion:
        return 'zebra.png';
      case PlantingAdvice.plantElephant:
        return 'elephant.png';
      default:
        return null;
    }
  }

  Future<void> showGrowingAnimation() async {
    growFields();
    await Future.delayed(
        const Duration(milliseconds: growingAnimationTimeInMs));
  }

  Future<void> showWeatherAnimation() async {
    state = state.copyWith(showingWeatherAnimation: true);
    await Future.delayed(
        const Duration(milliseconds: weatherAnimationTimeInMs));
    state = state.copyWith(showingWeatherAnimation: false);
  }

  void setCurrentEnumerator({required Enumerator newEnumerator}) {
    state = state.copyWith(currentEnumerator: newEnumerator);
  }

  void setCurrentLocation({required Location newLocation}) {
    state = state.copyWith(currentLocation: newLocation);
  }

  void setCurrentSession({required Session newSession}) {
    state = state.copyWith(currentSession: newSession);
  }

  void setDieRollResult({required int result}) {
    state = state.copyWith(dieRollResult: result);
  }

  void changeGameMode() {
    state = state.copyWith(isInPracticeMode: !state.isInPracticeMode);
  }

  void disableButtons() {
    state = state.copyWith(buttonsAreActive: false);
  }
}
