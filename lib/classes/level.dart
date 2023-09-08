// level class that contains all necessary data
class Level {
  final String levelID;
  final int rainForecast;
  final int rainActual;

  Level({
    required this.levelID,
    required this.rainForecast,
    required this.rainActual,
  });

  Level copyWith({
    String? levelID,
    int? rainForecast,
    int? rainActual,
  }) {
    return Level(
      levelID: levelID ?? this.levelID,
      rainForecast: rainForecast ?? this.rainForecast,
      rainActual: rainActual ?? this.rainActual,
    );
  }
}
