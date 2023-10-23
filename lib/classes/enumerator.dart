class Enumerator {
  final String firstName;
  final String lastName;
  final String? id;

  String get fullName {
    return '$firstName $lastName';
  }

  const Enumerator({
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

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'id': id,
    };
  }

  factory Enumerator.fromMap(Map<String, dynamic> map) {
    return Enumerator(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      id: map['id'] as String?,
    );
  }
}
