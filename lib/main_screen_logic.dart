import 'package:cis_game/game_data_notifier.dart';
import 'package:cis_game/main.dart';
import 'package:cis_game/seed_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants.dart';
import 'field.dart';
import 'field_widget.dart';

List<Widget> createFieldWidgets(List<Field> listOfFields) {
  List<Widget> fieldWidgetList = [];
  listOfFields.asMap().forEach((index, field) {
    fieldWidgetList.add(const Spacer());
    fieldWidgetList.add(Expanded(
        flex: 3,
        child: field.fieldStatus == FieldStatus.empty
            ? GestureDetector(
                onTap: () {
                  _showCustomDialog(index, listOfFields);
                },
                child: FieldWidget(
                  seedType: field.seedType,
                  fieldStatus: field.fieldStatus,
                ), // Replace with the widget you want to display
              )
            : FieldWidget(
                seedType: field.seedType,
                fieldStatus: field.fieldStatus,
              )));
  });
  fieldWidgetList.add(const Spacer());
  return fieldWidgetList;
}

List<Widget> createForecastWidgets(int currentForecast) {
  List<Widget> forecastWidgets = [];
  for (int i = 0; i < maxNumberForecast; i++) {
    forecastWidgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: FittedBox(
          child: Icon(
            i < currentForecast ? Icons.cloudy_snowing : Icons.cloud,
            color: i < currentForecast ? Colors.blue : Colors.white,
            size: 100,
          ),
        ),
      ),
    );
  }
  return forecastWidgets;
}

void _showCustomDialog(int fieldIndex, List<Field> fieldList) {
  showDialog(
    context: navigatorKey.currentContext!, // Use the converted context here
    builder: (BuildContext context) {
      return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        // ref.read(gameDataNotifierProvider.notifier).setDefaultSeedSelection();
        return AlertDialog(
          title: Text('Select seed type for field ${fieldIndex + 1}'),
          // content
          content: const SeedSelection(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref
                    .read(gameDataNotifierProvider.notifier)
                    .selectSeedTypeAndBuySeed(fieldIndex);
              },
              child: const Text('Buy seeds'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      });
    },
  );
}
