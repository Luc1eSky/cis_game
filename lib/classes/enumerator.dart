class Enumerator {
  final String firstName;
  final String lastName;
  final String? id;

  String get fullName {
    return '$firstName $lastName';
  }

  Enumerator({
    required this.firstName,
    required this.lastName,
    this.id,
  });

  Enumerator copyWith({
    String? firstName,
    String? lastName,
    String? id,
  }) {
    return Enumerator(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      id: id ?? this.id,
    );
  }
}
