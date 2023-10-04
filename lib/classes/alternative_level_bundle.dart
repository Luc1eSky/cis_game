import 'level.dart';

class AlternativeLevels {
  const AlternativeLevels({
    required this.linkedLevelId,
    required this.levels,
  });

  final String linkedLevelId;
  final List<AlternativeLevelBundle> levels;
}

class AlternativeLevelBundle {
  const AlternativeLevelBundle({
    required this.husbandLevel,
    required this.wifeLevel,
  });

  final Level husbandLevel;
  final Level wifeLevel;
}
