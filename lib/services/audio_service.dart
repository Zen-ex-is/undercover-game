import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _effectPlayer = AudioPlayer();
  final AudioPlayer _musicPlayer = AudioPlayer();
  
  bool _soundEnabled = true;
  bool _musicEnabled = false;

  bool get soundEnabled => _soundEnabled;
  bool get musicEnabled => _musicEnabled;

  void toggleSound() {
    _soundEnabled = !_soundEnabled;
  }

  void toggleMusic() {
    _musicEnabled = !_musicEnabled;
    if (!_musicEnabled) {
      stopBackgroundMusic();
    }
  }

  // Play sound effects using asset source (for now we'll use placeholder)
  Future<void> playWordReveal() async {
    if (_soundEnabled) {
      // Placeholder - will play system sound for now
      await _effectPlayer.play(AssetSource('sounds/reveal.mp3'), mode: PlayerMode.lowLatency);
    }
  }

  Future<void> playElimination() async {
    if (_soundEnabled) {
      await _effectPlayer.play(AssetSource('sounds/eliminate.mp3'), mode: PlayerMode.lowLatency);
    }
  }

  Future<void> playVictory() async {
    if (_soundEnabled) {
      await _effectPlayer.play(AssetSource('sounds/victory.mp3'), mode: PlayerMode.lowLatency);
    }
  }

  Future<void> playButtonClick() async {
    if (_soundEnabled) {
      await _effectPlayer.play(AssetSource('sounds/click.mp3'), mode: PlayerMode.lowLatency);
    }
  }

  Future<void> playBackgroundMusic() async {
    if (_musicEnabled) {
      await _musicPlayer.setReleaseMode(ReleaseMode.loop);
      await _musicPlayer.play(AssetSource('sounds/background.mp3'));
    }
  }

  Future<void> stopBackgroundMusic() async {
    await _musicPlayer.stop();
  }

  void dispose() {
    _effectPlayer.dispose();
    _musicPlayer.dispose();
  }
}
