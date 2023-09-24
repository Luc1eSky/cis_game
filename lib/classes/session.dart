enum Session {
  morning,
  afternoon,
}

extension ShortForm on Session {
  String get short => this == Session.morning ? 'AM' : 'PM';
}
