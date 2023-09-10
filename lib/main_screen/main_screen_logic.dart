import 'package:cis_game/dialogs/seed_selection_dialog.dart';
import 'package:cis_game/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/field.dart';
import 'widgets/field_widget.dart';

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

void _showCustomDialog(int fieldIndex, List<Field> fieldList) {
  showDialog(
    context: navigatorKey.currentContext!, // Use the converted context here
    builder: (BuildContext context) {
      return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
        // ref.read(gameDataNotifierProvider.notifier).setDefaultSeedSelection();
        return SeedSelectionDialog(fieldIndex: fieldIndex);
      });
    },
  );
}
