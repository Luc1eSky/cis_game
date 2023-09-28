import 'package:flutter/material.dart';

import '../classes/seed_type.dart';
import '../color_palette.dart';

SeedType seedTypeZebra = SeedType(
    animalName: 'zebra',
    price: 4,
    yieldNoRain: 3,
    yieldRain: 9,
    seedColor: ColorPalette().seedEarlyMaturing,
    animalImage: 'zebra.png',
    rainImage: 'drop.png');

SeedType seedTypeLion = SeedType(
    animalName: 'lion',
    price: 6,
    yieldNoRain: 3,
    yieldRain: 13,
    seedColor: ColorPalette().seedNormalMaturing,
    animalImage: 'lion.png',
    rainImage: 'drops.png');

SeedType seedTypeElephant = SeedType(
    animalName: 'elephant',
    price: 10,
    yieldNoRain: 2,
    yieldRain: 20,
    seedColor: ColorPalette().seedNormalMaturingHighYield,
    animalImage: 'elephant.png',
    rainImage: 'dropsandplus.png');

SeedType seedTypeNone = SeedType(
  animalName: '',
  price: 0,
  yieldNoRain: 0,
  yieldRain: 0,
  seedColor: Colors.transparent,
  animalImage: '',
  rainImage: '',
);

List<SeedType> seedTypeList = [
  seedTypeZebra,
  seedTypeLion,
  seedTypeElephant,
  seedTypeNone,
];
