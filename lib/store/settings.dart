import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/repository/settings.dart';

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

  bool _isVibrationEnabled;
  bool get isVibrationEnabled => _isVibrationEnabled;

  bool _isCameraEnabled;
  bool get isCameraEnabled => _isCameraEnabled;

  int _roundTime;
  int get roundTime => _roundTime;

  String _version;
  String get version => _version;

  int _gamesPlayed;
  int get gamesPlayed => _gamesPlayed;

  SettingsModel(this.repository);

  @override
  initialize() async {
    _isLoading = true;
    notifyListeners();

    _isAudioEnabled = repository.isAudioEnabled();
    _isRotationControlEnabled = repository.isRotationControlEnabled();
    _isVibrationEnabled = repository.isVibrationEnabled();
    _isCameraEnabled = repository.isCameraEnabled();
    _roundTime = repository.getRoundTime();
    _version = await repository.getAppVersion();
    _gamesPlayed = repository.getGamesPlayed();
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

  toggleVibration() async {
    _isVibrationEnabled = repository.toggleVibration();
    notifyListeners();
  }

  toggleCamera() async {
    _isCameraEnabled = repository.toggleCamera();
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

  static SettingsModel of(BuildContext context) =>
      ScopedModel.of<SettingsModel>(context);
}
