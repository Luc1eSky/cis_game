// contains full name of location and 3 letter abbreviation
class Location {
  final String name;
  final String acronym;

  Location({
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
}
