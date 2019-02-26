import 'dart:core';

import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String storageAudioEnabledKey = 'is_audio_enabled';
  static const String storageRotationControlEnabledKey =
      'is_rotation_control_enabled';
  static const String storageVibrationEnabledKey = 'is_vibration_enabled';
  static const String storageRoundTimeKey = 'round_time';

  final SharedPreferences storage;

  SettingsRepository({@required this.storage});

  bool isAudioEnabled() {
    return storage.getBool(storageAudioEnabledKey) ?? true;
  }

  bool toggleAudio() {
    var value = !isAudioEnabled();
    storage.setBool(storageAudioEnabledKey, value);

    return value;
  }

  bool isRotationControlEnabled() {
    return storage.getBool(storageRotationControlEnabledKey) ?? false;
  }

  bool toggleRotationControl() {
    var value = !isRotationControlEnabled();
    storage.setBool(storageRotationControlEnabledKey, value);

    return value;
  }

  bool isVibrationEnabled() {
    return storage.getBool(storageVibrationEnabledKey) ?? true;
  }

  bool toggleVibration() {
    var value = !isVibrationEnabled();
    storage.setBool(storageVibrationEnabledKey, value);

    return value;
  }

  int getRoundTime() {
    return storage.getInt(storageRoundTimeKey) ?? 60;
  }

  int setRoundTime(int roundTime) {
    storage.setInt(storageRoundTimeKey, roundTime);

    return roundTime;
  }

  Future<String> getAppVersion() async {
    return (await PackageInfo.fromPlatform()).version;
  }
}
