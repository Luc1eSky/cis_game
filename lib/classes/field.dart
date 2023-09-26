import 'package:flutter/material.dart';

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
      seedType: seedType ?? this.seedType?.copyWith(),
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

SeedType noneForUnplant = SeedType(
    animalName: '',
    price: 0,
    yieldNoRain: 0,
    yieldRain: 0,
    seedColor: Colors.transparent,
    animalImage: '');

List<SeedType> seedTypeList = [
  earlyMaturing,
  normalMaturing,
  normalMaturingHighYield,
  noneForUnplant,
];

class SeedType {
  final String animalName;
  final double price;
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

  SeedType copyWith({
    String? animalName,
    double? price,
    int? yieldNoRain,
    int? yieldRain,
    Color? seedColor,
    String? animalImage,
  }) {
    return SeedType(
      animalName: animalName ?? this.animalName,
      price: price ?? this.price,
      yieldNoRain: yieldNoRain ?? this.yieldNoRain,
      yieldRain: yieldRain ?? this.yieldRain,
      seedColor: seedColor ?? this.seedColor,
      animalImage: animalImage ?? this.animalImage,
    );
  }
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
