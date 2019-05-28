import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/repository/settings.dart';

import 'package:zgadula/services/notifications.dart';
import 'package:zgadula/store/store.dart';

class SettingsModel extends StoreModel {
  SettingsRepository repository;

  static const String androidId = 'com.puppybox.zgadula';
  static const String appleId = '1181083547';
  static const String privacyPolicyUrl =
      'https://github.com/vintage/party_flutter/blob/master/PRIVACY_POLICY.md';

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isAudioEnabled;
  bool get isAudioEnabled => _isAudioEnabled;

  bool _isRotationControlEnabled;
  bool get isRotationControlEnabled => _isRotationControlEnabled;

  bool _isCameraEnabled;
  bool get isCameraEnabled => _isCameraEnabled;

  bool _isSpeechEnabled;
  bool get isSpeechEnabled => _isSpeechEnabled;

  int _roundTime;
  int get roundTime => _roundTime;

  String _version;
  String get version => _version;

  int _gamesPlayed;
  int get gamesPlayed => _gamesPlayed;

  int _gamesFinished;
  int get gamesFinished => _gamesFinished;

  bool _isNotificationsEnabled;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  SettingsModel(this.repository);

  @override
  initialize() async {
    _isLoading = true;
    notifyListeners();

    _isAudioEnabled = repository.isAudioEnabled();
    _isRotationControlEnabled = repository.isRotationControlEnabled();
    _isCameraEnabled = repository.isCameraEnabled();
    _isSpeechEnabled = repository.isSpeechEnabled();
    _roundTime = repository.getRoundTime();
    _version = await repository.getAppVersion();
    _gamesPlayed = repository.getGamesPlayed();
    _gamesFinished = repository.getGamesFinished();
    _isNotificationsEnabled = repository.isNotificationsEnabled();
    _isLoading = false;
    notifyListeners();
  }

  toggleAudio() async {
    _isAudioEnabled = repository.toggleAudio();
    notifyListeners();
  }

  toggleRotationControl() async {
    _isRotationControlEnabled = repository.toggleRotationControl();
    notifyListeners();
  }

  toggleCamera() async {
    _isCameraEnabled = repository.toggleCamera();
    notifyListeners();
  }

  toggleSpeech() async {
    _isSpeechEnabled = repository.toggleSpeech();
    notifyListeners();
  }

  changeRoundTime(int roundTime) async {
    _roundTime = repository.setRoundTime(roundTime);
    notifyListeners();
  }

  increaseGamesPlayed() async {
    _gamesPlayed = repository.increaseGamesPlayed();
    notifyListeners();
  }

  increaseGamesFinished() async {
    _gamesFinished = repository.increaseGamesFinished();
    notifyListeners();
  }

  enableNotifications() {
    NotificationsService.register();
    _isNotificationsEnabled = true;
    repository.enableNotifications();
    notifyListeners();
  }

  static SettingsModel of(BuildContext context) =>
      ScopedModel.of<SettingsModel>(context);
}
