import 'package:flutter/painting.dart';

import '../color_palette.dart';

class Field {
  // default value when no seed type is null
  final SeedType? seedType;
  final FieldStatus fieldStatus;

  Field({
    this.seedType,
    required this.fieldStatus,
  });

  Field copyWith({
    SeedType? seedType,
    FieldStatus? fieldStatus,
  }) {
    return Field(
      seedType: seedType ?? this.seedType,
      fieldStatus: fieldStatus ?? this.fieldStatus,
    );
  }
}

SeedType earlyMaturing = SeedType(
    animalName: 'zebra',
    price: 4,
    yieldNoRain: 3,
    yieldRain: 9,
    seedColor: ColorPalette().seedEarlyMaturing,
    animalImage: 'zebra.png');

SeedType normalMaturing = SeedType(
    animalName: 'lion',
    price: 6,
    yieldNoRain: 3,
    yieldRain: 13,
    seedColor: ColorPalette().seedNormalMaturing,
    animalImage: 'lion.png');

SeedType normalMaturingHighYield = SeedType(
    animalName: 'elephant',
    price: 10,
    yieldNoRain: 2,
    yieldRain: 20,
    seedColor: ColorPalette().seedNormalMaturingHighYield,
    animalImage: 'elephant.png');

List<SeedType> seedTypeList = [
  earlyMaturing,
  normalMaturing,
  normalMaturingHighYield
];

class SeedType {
  final String animalName;
  final int price;
  final int yieldNoRain;
  final int yieldRain;
  final Color seedColor;
  final String animalImage;

  SeedType({
    required this.animalName,
    required this.price,
    required this.yieldNoRain,
    required this.yieldRain,
    required this.seedColor,
    required this.animalImage,
  });
}

// enum SeedTypeOld {
//   none,
//   earlyMaturing,
//   normalMaturing,
//   normalMaturingHighYield,
// }

enum FieldStatus {
  empty,
  seeded,
  grown,
  harvested,
}
