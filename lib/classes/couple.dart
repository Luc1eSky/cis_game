class Couple {
  // playing together
  String coupleID;
  bool coupleHasPlayed;

  // wive playing solo
  String wifeID;
  bool wiveHasPlayed;

  // husband playing solo
  String husbandID;
  bool husbandHasPlayed;

  // tracks who is currently playing
  CurrentPlayer currentPlayer;

  Couple({
    required this.coupleID,
    this.coupleHasPlayed = false,
    required this.wifeID,
    this.wiveHasPlayed = false,
    required this.husbandID,
    this.husbandHasPlayed = false,
    this.currentPlayer = CurrentPlayer.none,
  });

  copyWith({
    String? coupleID,
    bool? coupleHasPlayed,
    String? wifeID,
    bool? wiveHasPlayed,
    String? husbandID,
    bool? husbandHasPlayed,
    CurrentPlayer? currentPlayer,
  }) {
    return Couple(
      coupleID: coupleID ?? this.coupleID,
      coupleHasPlayed: coupleHasPlayed ?? this.coupleHasPlayed,
      wifeID: wifeID ?? this.wifeID,
      wiveHasPlayed: wiveHasPlayed ?? this.wiveHasPlayed,
      husbandID: husbandID ?? this.husbandID,
      husbandHasPlayed: husbandHasPlayed ?? this.husbandHasPlayed,
      currentPlayer: currentPlayer ?? this.currentPlayer,
    );
  }

  String? get currentPlayerID {
    if (currentPlayer == CurrentPlayer.wife) {
      return wifeID;
    }
    if (currentPlayer == CurrentPlayer.husband) {
      return husbandID;
    }
    if (currentPlayer == CurrentPlayer.couple) {
      return coupleID;
    }
    return null;
  }
}

enum CurrentPlayer {
  none,
  wife,
  husband,
  couple,
}

List<Couple> allCouples = [
  Couple(
    coupleID: 'CBBB001',
    wifeID: 'WLOC001',
    husbandID: 'HLOC001',
  ),
  Couple(
    coupleID: 'CAAA002',
    wifeID: 'WLOC002',
    husbandID: 'HLOC002',
  ),
  Couple(
    coupleID: 'CAAA003',
    wifeID: 'WLOC003',
    husbandID: 'HLOC003',
  ),
];

List<String> allLocations = [
  'AAA',
  'BBB',
  'CCC',
];
