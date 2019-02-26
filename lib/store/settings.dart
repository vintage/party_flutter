import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/repository/settings.dart';

import 'package:zgadula/store/store.dart';

class SettingsModel extends StoreModel {
  SettingsRepository repository;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isAudioEnabled = true;
  bool get isAudioEnabled => _isAudioEnabled;

  bool _isRotationControlEnabled = false;
  bool get isRotationControlEnabled => _isRotationControlEnabled;

  bool _isVibrationEnabled = true;
  bool get isVibrationEnabled => _isVibrationEnabled;

  int _roundTime;
  int get roundTime => _roundTime;

  String _version;
  String get version => _version;

  SettingsModel(this.repository);

  @override
  initialize() async {
    _isLoading = true;
    notifyListeners();

    _isAudioEnabled = repository.isAudioEnabled();
    _isRotationControlEnabled = repository.isRotationControlEnabled();
    _isVibrationEnabled = repository.isVibrationEnabled();
    _roundTime = repository.getRoundTime();
    _version = await repository.getAppVersion();
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

  changeRoundTime(int roundTime) async {
    _roundTime = repository.setRoundTime(roundTime);
    notifyListeners();
  }

  static SettingsModel of(BuildContext context) =>
      ScopedModel.of<SettingsModel>(context);
}
