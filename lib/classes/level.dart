// level class that contains all necessary data
class Level {
  final String levelID;
  final int? rainForecast;
  final bool isRaining;
  final bool plantingAdvice;

  const Level({
    required this.levelID,
    required this.rainForecast,
    required this.isRaining,
    required this.plantingAdvice,
  });

  Level copyWith({
    String? levelID,
    int? rainForecast,
    bool? isRaining,
    bool? plantingAdvice,
  }) {
    return Level(
      levelID: levelID ?? this.levelID,
      rainForecast: rainForecast ?? this.rainForecast,
      isRaining: isRaining ?? this.isRaining,
      plantingAdvice: plantingAdvice ?? this.plantingAdvice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'levelID': levelID,
      'rainForecast': rainForecast,
      'isRaining': isRaining,
      'plantingAdvice': plantingAdvice,
    };
  }

  factory Level.fromMap(Map<String, dynamic> map) {
    return Level(
      levelID: map['levelID'] as String,
      rainForecast: map['rainForecast'] as int?,
      isRaining: map['isRaining'] as bool,
      plantingAdvice: map['plantingAdvice'] as bool,
    );
  }

  @override
  String toString() {
    return '''Level{
      levelID: $levelID,
      rainForecast: $rainForecast,
      isRaining: $isRaining,
      plantingAdvice: $plantingAdvice}''';
  }
}
