import 'dart:convert';
import 'dart:html';

import 'package:cis_game/classes/couple.dart';
import 'package:cis_game/data/levels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'classes/game_result.dart';

Future<void> createExcel() async {
  // Create a new Excel Document.
  final Workbook workbook = Workbook();
  // Accessing worksheet via index.
  final Worksheet sheet = workbook.worksheets[0];

  // Set the header values for columns in excel
  // Participant Characteristics
  sheet.getRangeByIndex(1, 1).setText('Enumerator');
  sheet.getRangeByIndex(1, 2).setText('PlayerID');
  sheet.getRangeByIndex(1, 3).setText('PlayerType');
  sheet.getRangeByIndex(1, 4).setText('Location');
  sheet.getRangeByIndex(1, 5).setText('Session');
  sheet.getRangeByIndex(1, 6).setText('PlayerNumber');

  // Level Time related info
  sheet.getRangeByIndex(1, 7).setText('Season');
  sheet.getRangeByIndex(1, 8).setText('Round');
  sheet.getRangeByIndex(1, 9).setText('StartedOn');
  sheet.getRangeByIndex(1, 10).setText('EndedOn');
  sheet.getRangeByIndex(1, 11).setText('DurationInSeconds');

  // Level Information
  sheet.getRangeByIndex(1, 12).setText('LevelID');
  sheet.getRangeByIndex(1, 13).setText('RainForecast');
  sheet.getRangeByIndex(1, 14).setText('isRaining');
  sheet.getRangeByIndex(1, 15).setText('PlantingAdvice');
  sheet.getRangeByIndex(1, 16).setText('PlantingAdviceLowRisk');
  sheet.getRangeByIndex(1, 17).setText('PlantingAdviceHighRisk');
  sheet.getRangeByIndex(1, 18).setText('StartingCash');
  sheet.getRangeByIndex(1, 19).setText('StartingSavings');

  // Planting Results
  sheet.getRangeByIndex(1, 20).setText('ZebraFields');
  sheet.getRangeByIndex(1, 21).setText('LionFields');
  sheet.getRangeByIndex(1, 22).setText('ElephantFields');
  sheet.getRangeByIndex(1, 23).setText('EarningsZebras');
  sheet.getRangeByIndex(1, 24).setText('EarningsLions');
  sheet.getRangeByIndex(1, 25).setText('EarningsElephants');
  sheet.getRangeByIndex(1, 26).setText('TotalFields');
  sheet.getRangeByIndex(1, 27).setText('CostsZebraFields');
  sheet.getRangeByIndex(1, 28).setText('CostsLionFields');
  sheet.getRangeByIndex(1, 29).setText('CostsElephantFields');
  sheet.getRangeByIndex(1, 30).setText('TotalCostsForFields');

  // Results accumulated at the end of level
  sheet.getRangeByIndex(1, 31).setText('StoredInSavings');
  sheet.getRangeByIndex(1, 32).setText('EarningsTotal');
  sheet.getRangeByIndex(1, 33).setText('TotalCashAtTheEnd');

  sheet.getRangeByIndex(1, 34).setText('DieRollResult');
  sheet.getRangeByIndex(1, 35).setText('DieRollIndex');
  sheet.getRangeByIndex(1, 36).setText('SelectedForPayout');

  // connect to Firestore db
  FirebaseFirestore db = FirebaseFirestore.instance;
  // get snapshot of collection
  CollectionReference testCollectionRef = db.collection('data');

  QuerySnapshot testQuerySnapshot = await testCollectionRef.get();

  int row = 2;
  // go through all documents of QuerySnapshot
  for (QueryDocumentSnapshot testDocSnap in testQuerySnapshot.docs) {
    // firestore returns a LinkedHashMap object which needs to be
    // converted to Map<String, dynamic> via json encoding and decoding
    final validMap =
        json.decode(json.encode(testDocSnap.data())) as Map<String, dynamic>;

    // convert to GameResult
    GameResult downloadedGameResult = GameResult.fromMap(validMap);

    downloadedGameResult.levelResultList.asMap().forEach((index, levelResult) {
      //   print(index);
      // });

      // go through all LevelResults in document
      // for (LevelResult levelResult in downloadedGameResults.levelResultList) {
      // set participant information
      sheet.getRangeByIndex(row, 1).setText(levelResult.enumerator?.fullName);
      sheet.getRangeByIndex(row, 2).setText(levelResult.playerID);
      sheet.getRangeByIndex(row, 3).setText(levelResult.playerType?.name);
      sheet.getRangeByIndex(row, 4).setText(levelResult.location?.name);
      sheet.getRangeByIndex(row, 5).setText(levelResult.session?.name);
      sheet
          .getRangeByIndex(row, 6)
          .setNumber(levelResult.playerNumber?.toDouble());

      // set time related level information
      sheet.getRangeByIndex(row, 7).setNumber(levelResult.season.toDouble());
      sheet.getRangeByIndex(row, 8).setNumber((index + 1).toDouble());
      sheet.getRangeByIndex(row, 9).setDateTime(levelResult.startedOn);
      sheet.getRangeByIndex(row, 10).setDateTime(levelResult.endedOn);
      sheet
          .getRangeByIndex(row, 11)
          .setNumber(levelResult.timePlayedInSeconds.toDouble());

      // set level information
      sheet.getRangeByIndex(row, 12).setText(levelResult.level.levelID);
      sheet
          .getRangeByIndex(row, 13)
          .setText(levelResult.level.rainForecast?.toString() ?? 'none');
      sheet
          .getRangeByIndex(row, 14)
          .setText(levelResult.level.isRaining.toString());
      sheet
          .getRangeByIndex(row, 15)
          .setText(levelResult.level.plantingAdvice.toString());
      sheet.getRangeByIndex(row, 16).setText(
          levelResult.level.plantingAdvice == true
              ? levelResult.plantingAdviceLowRisk.name
              : 'none');
      sheet.getRangeByIndex(row, 17).setText(
          levelResult.level.plantingAdvice == true
              ? levelResult.plantingAdviceHighRisk.name
              : 'none');
      sheet.getRangeByIndex(row, 18).setNumber(levelResult.startingCash);
      sheet.getRangeByIndex(row, 19).setNumber(levelResult.startingSavings);

      // set planting results per seed type
      sheet
          .getRangeByIndex(row, 20)
          .setNumber(levelResult.zebraFields.toDouble());
      sheet
          .getRangeByIndex(row, 21)
          .setNumber(levelResult.lionFields.toDouble());
      sheet
          .getRangeByIndex(row, 22)
          .setNumber(levelResult.elephantFields.toDouble());
      sheet.getRangeByIndex(row, 23).setNumber(levelResult.earningsZebras);
      sheet.getRangeByIndex(row, 24).setNumber(levelResult.earningsLions);
      sheet.getRangeByIndex(row, 25).setNumber(levelResult.earningsElephants);
      sheet
          .getRangeByIndex(row, 26)
          .setNumber(levelResult.fieldsTotal.toDouble());
      sheet.getRangeByIndex(row, 27).setNumber(levelResult.costsZebras);
      sheet.getRangeByIndex(row, 28).setNumber(levelResult.costsLions);
      sheet.getRangeByIndex(row, 29).setNumber(levelResult.costsElephants);
      sheet.getRangeByIndex(row, 30).setNumber(levelResult.costsTotal);

      // get results accumulated at the end of level
      sheet.getRangeByIndex(row, 31).setNumber(levelResult.storedInSavings);
      sheet.getRangeByIndex(row, 32).setNumber(levelResult.earningsTotal);
      sheet.getRangeByIndex(row, 33).setNumber(levelResult.totalMoneyAtEnd);

      sheet
          .getRangeByIndex(row, 34)
          .setNumber(downloadedGameResult.dieRollResult.toDouble());

      int dieRollIndex = levelResult.playerType != PlayerType.both
          ? levelResult.season
          : levelResult.season + individualLevels.length;
      sheet.getRangeByIndex(row, 35).setNumber(dieRollIndex.toDouble());

      bool isSelectedPayoutRow =
          downloadedGameResult.dieRollResult == dieRollIndex;

      sheet.getRangeByIndex(row, 36).setText(isSelectedPayoutRow.toString());

      row++;
    });
  }

  // Save and dispose the document.
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  // Download the output file in web.
  AnchorElement(
      href:
          "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", "output.xlsx")
    ..click();
}
