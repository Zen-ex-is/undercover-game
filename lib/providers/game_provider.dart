import 'package:flutter/foundation.dart';
import 'dart:math';
import '../models/player.dart';
import '../models/word_pair.dart';
import '../models/game_config.dart';

enum GameState {
  setup,
  playing,
  voting,
  finished,
}

class GameProvider extends ChangeNotifier {
  final List<Player> _players = [];
  GameState _gameState = GameState.setup;
  WordPair? _currentWordPair;
  int _currentPlayerIndex = 0;
  int _roundNumber = 1;
  String? _winner;
  
  // Game setup parameters
  int _numPlayers = 6;
  int _numSpies = 1;
  bool _includeMrWhite = true;
  List<String> _playerNames = [];
  GameConfig _gameConfig = GameConfig();
  
  // Store secret card data for "Real Choice" card selection
  final List<Map<String, dynamic>> _secretCards = [];

  // Getters
  List<Player> get players => _players;
  GameState get gameState => _gameState;
  WordPair? get currentWordPair => _currentWordPair;
  int get currentPlayerIndex => _currentPlayerIndex;
  int get roundNumber => _roundNumber;
  String? get winner => _winner;
  int get numPlayers => _numPlayers;
  int get numSpies => _numSpies;
  bool get includeMrWhiteSetup => _includeMrWhite;
  List<String> get playerNames => _playerNames;
  GameConfig get gameConfig => _gameConfig;
  
  int get totalPlayers => _players.length;
  int get alivePlayers => _players.where((p) => !p.isEliminated).length;
  int get civilianCount => _players.where((p) => p.role == PlayerRole.civilian && !p.isEliminated).length;
  int get spyCount => _players.where((p) => p.role == PlayerRole.spy && !p.isEliminated).length;
  bool get hasMrWhite => _players.any((p) => p.role == PlayerRole.mrWhite && !p.isEliminated);

  // Set game configuration (called from setup screen)
  void setGameConfiguration(GameConfig config) {
    _gameConfig = config;
    _numPlayers = config.numPlayers;
    _numSpies = config.numSpies;
    _includeMrWhite = config.includeMrWhite;
    notifyListeners();
  }

  // Set game parameters (called from setup screen)
  void setGameParameters(int numPlayers, int numSpies, bool includeMrWhite) {
    _numPlayers = numPlayers;
    _numSpies = numSpies;
    _includeMrWhite = includeMrWhite;
    notifyListeners();
  }

  // Set player names (called from player names screen)
  void setPlayerNames(List<String> names) {
    _playerNames = names;
    notifyListeners();
  }

  // Setup game with number of players
  void setupGame(int numPlayers, int numSpies, bool includeMrWhite) {
    _players.clear();
    _secretCards.clear();
    
    // Get word pair based on configuration
    _currentWordPair = _getWordPairFromConfig();
    
    // Create list of roles
    List<PlayerRole> roles = [];
    
    // Add Mr. White if included
    if (includeMrWhite) {
      roles.add(PlayerRole.mrWhite);
    }
    
    // Add spies
    for (int i = 0; i < numSpies; i++) {
      roles.add(PlayerRole.spy);
    }
    
    // Fill remaining with civilians
    while (roles.length < numPlayers) {
      roles.add(PlayerRole.civilian);
    }
    
    // Shuffle roles to ensure random distribution behind cards
    roles.shuffle(Random());
    
    // Populate secret cards
    for (var role in roles) {
      String? word;
      if (role == PlayerRole.civilian) {
        word = _currentWordPair!.civilianWord;
      } else if (role == PlayerRole.spy) {
        word = _currentWordPair!.spyWord;
      } else {
        word = null; // Mr. White gets no word
      }
      
      _secretCards.add({
        'role': role,
        'word': word,
      });
    }
    
    // Create players with PLACEHOLDER roles initially
    // Roles will be assigned when they pick a card
    for (int i = 0; i < numPlayers; i++) {
      // Use provided player names or fallback to default
      String playerName = i < _playerNames.length 
          ? _playerNames[i] 
          : 'Player ${i + 1}';
      
      _players.add(Player(
        id: i + 1,
        name: playerName,
        role: PlayerRole.civilian, // Placeholder
        word: null, // Placeholder
      ));
    }

    _gameState = GameState.setup;
    _currentPlayerIndex = 0;
    _roundNumber = 1;
    _winner = null;
    notifyListeners();
  }

  // Assign role to player based on the card they picked
  void assignRoleToPlayer(int playerIndex, int cardIndex) {
    if (playerIndex < _players.length && cardIndex < _secretCards.length) {
      final cardData = _secretCards[cardIndex];
      _players[playerIndex] = _players[playerIndex].copyWith(
        role: cardData['role'],
        word: cardData['word'],
      );
      notifyListeners();
    }
  }

  // Finalize setup and start the game
  void startGame() {
    // Ensure Mr. White does not go first
    if (_includeMrWhite && _players.isNotEmpty) {
      // If the first player (index 0) is Mr. White, change the starting player
      if (_players[0].role == PlayerRole.mrWhite) {
        // Find a non-Mr. White player to start
        List<int> validStartingIndices = [];
        for (int i = 0; i < _players.length; i++) {
          if (_players[i].role != PlayerRole.mrWhite) {
            validStartingIndices.add(i);
          }
        }

        if (validStartingIndices.isNotEmpty) {
          // Pick a random valid starting player
          _currentPlayerIndex = validStartingIndices[Random().nextInt(validStartingIndices.length)];
        }
      } else {
        _currentPlayerIndex = 0;
      }
    } else {
      _currentPlayerIndex = 0;
    }

    _gameState = GameState.playing;
    notifyListeners();
  }

  // Move to next player turn
  void nextTurn() {
    // Find next alive player after current index
    int nextIndex = -1;
    for (int i = _currentPlayerIndex + 1; i < _players.length; i++) {
      if (!_players[i].isEliminated) {
        nextIndex = i;
        break;
      }
    }

    if (nextIndex != -1) {
      _currentPlayerIndex = nextIndex;
    } else {
      // No more players to speak this round, move to voting
      _gameState = GameState.voting;
    }
    notifyListeners();
  }

  // Reveal word for a player
  void revealWord(int playerId) {
    int index = _players.indexWhere((p) => p.id == playerId);
    if (index != -1) {
      _players[index] = _players[index].copyWith(hasRevealed: true);
      notifyListeners();
    }
  }

  // Eliminate a player
  void eliminatePlayer(int playerId) {
    int index = _players.indexWhere((p) => p.id == playerId);
    if (index != -1) {
      bool isMrWhite = _players[index].role == PlayerRole.mrWhite;
      _players[index] = _players[index].copyWith(isEliminated: true);
      
      // If Mr. White is eliminated, we don't check for game end yet.
      // We wait for Mr. White to make their guess.
      if (isMrWhite) {
        notifyListeners();
        return;
      }

      checkGameEnd();
      
      // If the game is continuing, start the next round with a randomized order
      // This ensures that the speaking order changes every round
      if (_gameState != GameState.finished) {
        _startNextRound();
      }
      
      notifyListeners();
    }
  }

  void _startNextRound() {
    _roundNumber++;
    _players.shuffle();
    // Reset to first alive player for the new round
    _currentPlayerIndex = _players.indexWhere((p) => !p.isEliminated);
    _gameState = GameState.playing;
  }

  // Check if game has ended
  void checkGameEnd() {
    // Note: When Mr. White is eliminated, we don't end the game here
    // Instead, the UI will trigger the guess dialog, and the game ends after the guess
    
    // If all spies are eliminated and Mr. White is also gone
    if (spyCount == 0 && !hasMrWhite) {
      _winner = 'Civilians win! All threats eliminated!';
      _gameState = GameState.finished;
      return;
    }
    
    // If all civilians are eliminated
    if (civilianCount == 0) {
      if (hasMrWhite && spyCount > 0) {
        _winner = 'Spies win! All civilians eliminated!';
      } else if (hasMrWhite) {
        _winner = 'Mr. White wins! All civilians eliminated!';
      } else {
        _winner = 'Spies win! All civilians eliminated!';
      }
      _gameState = GameState.finished;
      return;
    }
    
    // If only 2 players remain
    if (alivePlayers == 2) {
      List<Player> alive = _players.where((p) => !p.isEliminated).toList();
      if (alive.length == 2) {
        if (alive.any((p) => p.role == PlayerRole.mrWhite)) {
          _winner = 'Mr. White wins! Only 2 players remain!';
        } else if (alive.any((p) => p.role == PlayerRole.spy)) {
          _winner = 'Spies win! Only 2 players remain!';
        }
        _gameState = GameState.finished;
      }
    }
  }

  bool get includeMrWhite => _players.any((p) => p.role == PlayerRole.mrWhite);

  // Start voting phase
  void startVoting() {
    _gameState = GameState.voting;
    notifyListeners();
  }

  // End voting and return to playing
  void endVoting() {
    _gameState = GameState.playing;
    _roundNumber++;
    notifyListeners();
  }

  // Reset game
  void resetGame() {
    _players.clear();
    _gameState = GameState.setup;
    _currentWordPair = null;
    _currentPlayerIndex = 0;
    _roundNumber = 1;
    _winner = null;
    notifyListeners();
  }

  // Get word pair based on game configuration
  WordPair _getWordPairFromConfig() {
    if (_gameConfig.randomizeCategories || 
        _gameConfig.selectedCategories.contains(WordCategory.all)) {
      // Use all word pairs
      return WordDatabase.getRandomWordPair();
    } else {
      // Filter by selected categories
      return WordDatabase.getRandomWordPairByCategories(
        _gameConfig.selectedCategories,
      );
    }
  }

  // Mr. White guesses the civilian word
  // Current Implementation: Mr. White must guess the CIVILIAN word only
  // Future Enhancement (v1.5.0): Add Expert Mode where Mr. White can guess EITHER word
  bool mrWhiteGuess(String guess) {
    if (_currentWordPair != null) {
      String civilianWord = _currentWordPair!.civilianWord.toLowerCase();
      String guessLower = guess.toLowerCase().trim();
      
      // Standard Mode: Only civilian word is correct
      if (guessLower == civilianWord) {
        _winner = 'Mr. White wins! Correct guess: ${_currentWordPair!.civilianWord}';
        _gameState = GameState.finished;
        notifyListeners();
        return true;
      } else {
        // Mr. White guessed wrong.
        // Check if the game should end (e.g. if Civilians have won now that Mr. White failed)
        checkGameEnd();
        
        // If game continues, start next round
        if (_gameState != GameState.finished) {
          _startNextRound();
        }

        notifyListeners();
        return false;
      }
      
      // TODO v1.5.0: Add Expert Mode logic
      // In Expert Mode, also check against spyWord:
      // String spyWord = _currentWordPair!.spyWord.toLowerCase();
      // if (guessLower == civilianWord || guessLower == spyWord) { ... }
    }
    return false;
  }
}
