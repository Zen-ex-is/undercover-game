enum PlayerRole {
  civilian,
  spy,
  mrWhite,
}

class Player {
  final int id;
  final String name;
  final PlayerRole role;
  final String? word;
  bool isEliminated;
  bool hasRevealed;

  Player({
    required this.id,
    required this.name,
    required this.role,
    this.word,
    this.isEliminated = false,
    this.hasRevealed = false,
  });

  String get roleDisplay {
    switch (role) {
      case PlayerRole.civilian:
        return 'Civilian';
      case PlayerRole.spy:
        return 'Spy';
      case PlayerRole.mrWhite:
        return 'Mr. White';
    }
  }

  Player copyWith({
    int? id,
    String? name,
    PlayerRole? role,
    String? word,
    bool? isEliminated,
    bool? hasRevealed,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      word: word ?? this.word,
      isEliminated: isEliminated ?? this.isEliminated,
      hasRevealed: hasRevealed ?? this.hasRevealed,
    );
  }
}
