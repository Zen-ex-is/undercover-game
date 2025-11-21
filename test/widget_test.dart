import 'package:flutter_test/flutter_test.dart';
import 'package:undercover_game/models/player.dart';
import 'package:undercover_game/models/word_pair.dart';
import 'package:undercover_game/providers/game_provider.dart';

void main() {
  group('Player Model Tests', () {
    test('Player should be created with correct properties', () {
      final player = Player(
        id: 1,
        name: 'Test Player',
        role: PlayerRole.civilian,
        word: 'Coffee',
      );

      expect(player.id, 1);
      expect(player.name, 'Test Player');
      expect(player.role, PlayerRole.civilian);
      expect(player.word, 'Coffee');
      expect(player.isEliminated, false);
      expect(player.hasRevealed, false);
    });

    test('Player copyWith should work correctly', () {
      final player = Player(
        id: 1,
        name: 'Test Player',
        role: PlayerRole.civilian,
        word: 'Coffee',
      );

      final updated = player.copyWith(isEliminated: true);

      expect(updated.id, player.id);
      expect(updated.name, player.name);
      expect(updated.isEliminated, true);
      expect(player.isEliminated, false); // Original unchanged
    });

    test('Role display should return correct strings', () {
      final civilian = Player(id: 1, name: 'P1', role: PlayerRole.civilian);
      final spy = Player(id: 2, name: 'P2', role: PlayerRole.spy);
      final mrWhite = Player(id: 3, name: 'P3', role: PlayerRole.mrWhite);

      expect(civilian.roleDisplay, 'Civilian');
      expect(spy.roleDisplay, 'Spy');
      expect(mrWhite.roleDisplay, 'Mr. White');
    });
  });

  group('WordPair Tests', () {
    test('WordPair should be created correctly', () {
      final wordPair = WordPair(
        civilianWord: 'Coffee',
        spyWord: 'Tea',
        category: 'Beverages',
      );

      expect(wordPair.civilianWord, 'Coffee');
      expect(wordPair.spyWord, 'Tea');
      expect(wordPair.category, 'Beverages');
    });

    test('Word database should contain word pairs', () {
      expect(WordDatabase.wordPairs.isNotEmpty, true);
      expect(WordDatabase.wordPairs.length, greaterThan(30));
    });

    test('getRandomWordPair should return a valid pair', () {
      final wordPair = WordDatabase.getRandomWordPair();

      expect(wordPair.civilianWord.isNotEmpty, true);
      expect(wordPair.spyWord.isNotEmpty, true);
      expect(wordPair.category.isNotEmpty, true);
    });
  });

  group('GameProvider Tests', () {
    test('GameProvider should initialize with correct defaults', () {
      final provider = GameProvider();

      expect(provider.players, isEmpty);
      expect(provider.gameState, GameState.setup);
      expect(provider.currentWordPair, isNull);
      expect(provider.roundNumber, 1);
      expect(provider.winner, isNull);
    });

    test('setupGame should create correct number of players', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, false);

      expect(provider.players.length, 6);
      expect(provider.gameState, GameState.playing);
      expect(provider.currentWordPair, isNotNull);
    });

    test('setupGame should assign roles correctly without Mr. White', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, false);

      final civilians = provider.players.where((p) => p.role == PlayerRole.civilian).length;
      final spies = provider.players.where((p) => p.role == PlayerRole.spy).length;
      final mrWhites = provider.players.where((p) => p.role == PlayerRole.mrWhite).length;

      expect(civilians, 5);
      expect(spies, 1);
      expect(mrWhites, 0);
    });

    test('setupGame should assign roles correctly with Mr. White', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, true);

      final civilians = provider.players.where((p) => p.role == PlayerRole.civilian).length;
      final spies = provider.players.where((p) => p.role == PlayerRole.spy).length;
      final mrWhites = provider.players.where((p) => p.role == PlayerRole.mrWhite).length;

      expect(civilians, 4);
      expect(spies, 1);
      expect(mrWhites, 1);
    });

    test('Civilians should get civilian word', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, false);

      final civilian = provider.players.firstWhere((p) => p.role == PlayerRole.civilian);
      expect(civilian.word, provider.currentWordPair!.civilianWord);
    });

    test('Spies should get spy word', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, false);

      final spy = provider.players.firstWhere((p) => p.role == PlayerRole.spy);
      expect(spy.word, provider.currentWordPair!.spyWord);
    });

    test('Mr. White should get no word', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, true);

      final mrWhite = provider.players.firstWhere((p) => p.role == PlayerRole.mrWhite);
      expect(mrWhite.word, isNull);
    });

    test('eliminatePlayer should mark player as eliminated', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, false);

      final playerId = provider.players.first.id;
      provider.eliminatePlayer(playerId);

      final player = provider.players.firstWhere((p) => p.id == playerId);
      expect(player.isEliminated, true);
    });

    test('revealWord should mark player as revealed', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, false);

      final playerId = provider.players.first.id;
      provider.revealWord(playerId);

      final player = provider.players.firstWhere((p) => p.id == playerId);
      expect(player.hasRevealed, true);
    });

    test('resetGame should return to setup state', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, false);
      provider.resetGame();

      expect(provider.players, isEmpty);
      expect(provider.gameState, GameState.setup);
      expect(provider.currentWordPair, isNull);
      expect(provider.roundNumber, 1);
    });

    test('Mr. White correct guess should win', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, true);

      final civilianWord = provider.currentWordPair!.civilianWord;
      provider.mrWhiteGuess(civilianWord);

      expect(provider.gameState, GameState.finished);
      expect(provider.winner, contains('Mr. White wins'));
    });

    test('Mr. White incorrect guess should lose', () {
      final provider = GameProvider();
      provider.setupGame(6, 1, true);

      provider.mrWhiteGuess('WrongWord');

      expect(provider.gameState, GameState.finished);
      expect(provider.winner, contains('Civilians and Spies win'));
    });
  });
}
