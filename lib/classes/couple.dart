import 'package:cis_game/data/levels.dart';

import 'level.dart';

class Couple {
  // playing together
  Person both;
  // wive playing solo
  Person wife;
  // husband playing solo
  Person husband;

  // tracks who is currently playing
  PlayerType currentPlayerType;

  Couple({
    required this.both,
    required this.wife,
    required this.husband,
    this.currentPlayerType = PlayerType.none,
  });

  copyWith({
    Person? both,
    Person? wife,
    Person? husband,
    PlayerType? currentPlayerType,
  }) {
    return Couple(
      both: both ?? this.both.copyWith(),
      wife: wife ?? this.wife.copyWith(),
      husband: husband ?? this.husband.copyWith(),
      currentPlayerType: currentPlayerType ?? this.currentPlayerType,
    );
  }

  // returns the person currently playing
  Person? get currentPlayer {
    if (currentPlayerType == PlayerType.wife) {
      return wife;
    }
    if (currentPlayerType == PlayerType.husband) {
      return husband;
    }
    if (currentPlayerType == PlayerType.both) {
      return both;
    }
    return null;
  }

  bool get coupleCanPlay {
    return wife.hasPlayed && husband.hasPlayed && !both.hasPlayed;
  }

  bool get everyoneHasPlayed {
    return wife.hasPlayed && husband.hasPlayed && both.hasPlayed;
  }

  bool get nooneHasPlayed {
    return !wife.hasPlayed && !husband.hasPlayed && !both.hasPlayed;
  }
}

enum PlayerType {
  none,
  wife,
  husband,
  both,
}

// class to store personal ID and if the person has played
class Person {
  final String personalID;
  final bool hasPlayed;
  final List<Level> levels;
  final PlayerType playerType;

  Person({
    required this.personalID,
    required this.hasPlayed,
    required this.levels,
    required this.playerType,
  });

  copyWith({
    String? personalID,
    bool? hasPlayed,
    List<Level>? levels,
    PlayerType? playerType,
  }) {
    return Person(
      personalID: personalID ?? this.personalID,
      hasPlayed: hasPlayed ?? this.hasPlayed,
      levels: levels ?? copyLevels(this.levels),
      playerType: playerType ?? this.playerType,
    );
  }

  // returns personalID, but in a more readable format
  String get formattedID {
    String firstLetter = personalID.substring(0, 1);
    String location = personalID.substring(1, 4);
    String session = personalID.substring(4, 6);
    String number = personalID.substring(personalID.length - 2);

    return '$firstLetter-$location-$session-$number';
  }
}

List<Level> copyLevels(List<Level> listToCopy) {
  List<Level> copiedLevels = [];
  for (Level level in listToCopy) {
    copiedLevels.add(level);
  }
  return copiedLevels;
}

Couple practiceCouple = Couple(
  currentPlayerType: PlayerType.both,
  both: Person(
    personalID: 'Practice Mode !!!',
    hasPlayed: false,
    levels: practiceLevels,
    playerType: PlayerType.both,
  ),
  wife: Person(
    personalID: 'test',
    hasPlayed: false,
    levels: [],
    playerType: PlayerType.wife,
  ),
  husband: Person(
    personalID: 'test',
    hasPlayed: false,
    levels: [],
    playerType: PlayerType.husband,
  ),
);
