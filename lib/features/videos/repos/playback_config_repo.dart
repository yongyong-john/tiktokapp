import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _muted = 'muted';
  static const String _autoPlay = 'autoPlay';

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoPlay(bool value) async {
    _preferences.setBool(_autoPlay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoPlay() {
    return _preferences.getBool(_autoPlay) ?? false;
  }
}
