// contains full name of location and 3 letter abbreviation
class Location {
  final String name;
  final String acronym;

  const Location({
    required this.name,
    required this.acronym,
  });

  Location copyWith({
    String? name,
    String? acronym,
  }) {
    return Location(
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'acronym': acronym,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String,
      acronym: map['acronym'] as String,
    );
  }
}

const Location dummyLocation = Location(name: '', acronym: '');
