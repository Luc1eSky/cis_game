import 'package:cis_game/classes/seed_type.dart';

class Field {
  // default value when no seed type is null
  final SeedType seedType;
  final FieldStatus fieldStatus;

  const Field({
    required this.seedType,
    required this.fieldStatus,
  });

  Field copyWith({
    SeedType? seedType,
    FieldStatus? fieldStatus,
  }) {
    return Field(
      seedType: seedType ?? this.seedType.copyWith(),
      fieldStatus: fieldStatus ?? this.fieldStatus,
    );
  }
}

enum FieldStatus {
  empty,
  selected,
  seeded,
  grown,
  harvested,
}
