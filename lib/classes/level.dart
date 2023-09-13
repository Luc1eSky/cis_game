// level class that contains all necessary data
class Level {
  final String levelID;
  final int? rainForecast;
  final bool isRaining;
  final String? plantingAdvice;

  Level({
    required this.levelID,
    required this.rainForecast,
    required this.isRaining,
    required this.plantingAdvice,
  });

  Level copyWith({
    String? levelID,
    int? rainForecast,
    bool? isRaining,
    String? plantingAdvice,
  }) {
    return Level(
      levelID: levelID ?? this.levelID,
      rainForecast: rainForecast ?? this.rainForecast,
      isRaining: isRaining ?? this.isRaining,
      plantingAdvice: plantingAdvice ?? this.plantingAdvice,
    );
  }
}
