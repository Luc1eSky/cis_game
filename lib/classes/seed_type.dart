import 'package:flutter/material.dart';

class SeedType {
  final String animalName;
  final double price;
  final int yieldNoRain;
  final int yieldRain;
  final Color seedColor;
  final String animalImage;
  final String rainImage;

  const SeedType(
      {required this.animalName,
      required this.price,
      required this.yieldNoRain,
      required this.yieldRain,
      required this.seedColor,
      required this.animalImage,
      required this.rainImage});

  SeedType copyWith({
    String? animalName,
    double? price,
    int? yieldNoRain,
    int? yieldRain,
    Color? seedColor,
    String? animalImage,
    String? rainImage,
  }) {
    return SeedType(
      animalName: animalName ?? this.animalName,
      price: price ?? this.price,
      yieldNoRain: yieldNoRain ?? this.yieldNoRain,
      yieldRain: yieldRain ?? this.yieldRain,
      seedColor: seedColor ?? this.seedColor,
      animalImage: animalImage ?? this.animalImage,
      rainImage: rainImage ?? this.rainImage,
    );
  }
}
