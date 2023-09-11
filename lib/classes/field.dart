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
    yieldLowRain: 6,
    yieldHighRain: 6,
    seedColor: ColorPalette().seedEarlyMaturing,
    animalImage: 'zebra.png');

SeedType normalMaturing = SeedType(
    animalName: 'lion',
    price: 6,
    yieldLowRain: 5,
    yieldHighRain: 10,
    seedColor: ColorPalette().seedNormalMaturing,
    animalImage: 'lion.png');

SeedType normalMaturingHighYield = SeedType(
    animalName: 'elephant',
    price: 10,
    yieldLowRain: 3,
    yieldHighRain: 18,
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
  final int yieldLowRain;
  final int yieldHighRain;
  final Color seedColor;
  final String animalImage;

  SeedType({
    required this.animalName,
    required this.price,
    required this.yieldLowRain,
    required this.yieldHighRain,
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
