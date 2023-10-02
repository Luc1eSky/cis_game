import 'level.dart';

class AlternativeLevels {
  AlternativeLevels({
    required this.linkedLevelId,
    required this.levels,
  });
  final String linkedLevelId;
  final List<AlternativeLevelBundle> levels;
}

class AlternativeLevelBundle {
  AlternativeLevelBundle({
    required this.husbandLevel,
    required this.wifeLevel,
  });

  final Level husbandLevel;
  final Level wifeLevel;
}
