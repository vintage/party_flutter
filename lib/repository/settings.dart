import 'dart:core';

import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const String storageAudioEnabledKey = 'is_audio_enabled';
  static const String storageRotationControlEnabledKey =
      'is_rotation_control_enabled';
  static const String storageCameraEnabledKey = 'is_camera_enabled';
  static const String storageSpeechEnabledKey = 'is_speech_enabled';
  static const String storageRoundTimeKey = 'round_time';
  static const String storageGamesPlayedKey = 'games_played';
  static const String storageGamesFinishedKey = 'games_finished';
  static const String storageNotificationsEnabledKey =
      'is_notifications_enabled';

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

  bool isCameraEnabled() {
    return storage.getBool(storageCameraEnabledKey) ?? false;
  }

  bool toggleCamera() {
    var value = !isCameraEnabled();
    storage.setBool(storageCameraEnabledKey, value);

    return value;
  }

  bool isSpeechEnabled() {
    return storage.getBool(storageSpeechEnabledKey) ?? false;
  }

  bool toggleSpeech() {
    var value = !isSpeechEnabled();
    storage.setBool(storageSpeechEnabledKey, value);

    return value;
  }

  int getRoundTime() {
    return storage.getInt(storageRoundTimeKey) ?? 60;
  }

  int setRoundTime(int roundTime) {
    storage.setInt(storageRoundTimeKey, roundTime);

    return roundTime;
  }

  int getGamesPlayed() {
    return storage.getInt(storageGamesPlayedKey) ?? 0;
  }

  int increaseGamesPlayed() {
    var gamesPlayed = getGamesPlayed() + 1;
    storage.setInt(storageGamesPlayedKey, gamesPlayed);

    return gamesPlayed;
  }

  int getGamesFinished() {
    return storage.getInt(storageGamesFinishedKey) ?? 0;
  }

  int increaseGamesFinished() {
    var gamesFinished = getGamesFinished() + 1;
    storage.setInt(storageGamesFinishedKey, gamesFinished);

    return gamesFinished;
  }

  bool isNotificationsEnabled() {
    return storage.getBool(storageNotificationsEnabledKey) ?? false;
  }

  void enableNotifications() {
    storage.setBool(storageNotificationsEnabledKey, true);
  }

  Future<String> getAppVersion() async {
    return (await PackageInfo.fromPlatform()).version;
  }
}
