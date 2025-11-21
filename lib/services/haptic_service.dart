import 'package:vibration/vibration.dart';

class HapticService {
  static final HapticService _instance = HapticService._internal();
  factory HapticService() => _instance;
  HapticService._internal();

  bool _enabled = true;
  bool? _hasVibrator;

  bool get enabled => _enabled;

  Future<void> init() async {
    _hasVibrator = await Vibration.hasVibrator();
  }

  void toggle() {
    _enabled = !_enabled;
  }

  Future<void> light() async {
    if (_enabled && _hasVibrator == true) {
      await Vibration.vibrate(duration: 10);
    }
  }

  Future<void> medium() async {
    if (_enabled && _hasVibrator == true) {
      await Vibration.vibrate(duration: 30);
    }
  }

  Future<void> heavy() async {
    if (_enabled && _hasVibrator == true) {
      await Vibration.vibrate(duration: 50);
    }
  }

  Future<void> success() async {
    if (_enabled && _hasVibrator == true) {
      await Vibration.vibrate(duration: 20);
      await Future.delayed(const Duration(milliseconds: 50));
      await Vibration.vibrate(duration: 20);
    }
  }

  Future<void> error() async {
    if (_enabled && _hasVibrator == true) {
      await Vibration.vibrate(duration: 100);
    }
  }
}
