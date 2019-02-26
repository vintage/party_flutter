import 'dart:async' show Future;
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

import 'package:zgadula/store/store.dart';

class SettingsModel extends StoreModel {
  String _isAudioEnabledKey = 'is_audio_enabled';
  String _isRotationControlEnabledKey = 'is_rotation_control_enabled';
  String _isVibrationEnabledKey = 'is_vibration_enabled';
  String _roundTimeKey = 'round_time';

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

  @override
  Future initialize() async {
    _isLoading = true;
    notifyListeners();

    var persist = await persistStore;
    _isAudioEnabled = persist.getBool(_isAudioEnabledKey) ?? true;
    _isRotationControlEnabled = persist.getBool(_isRotationControlEnabledKey) ?? false;
    _isVibrationEnabled = persist.getBool(_isVibrationEnabledKey) ?? true;
    _roundTime = persist.getInt(_roundTimeKey) ?? 60;
    _isLoading = false;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;

    notifyListeners();
  }

  Future toggleAudio() async {
    _isAudioEnabled = !_isAudioEnabled;
    notifyListeners();

    await persistStore..setBool(_isAudioEnabledKey, _isAudioEnabled);
  }

  Future toggleRotationControl() async {
    _isRotationControlEnabled = !_isRotationControlEnabled;
    notifyListeners();

    await persistStore..setBool(_isRotationControlEnabledKey, _isRotationControlEnabled);
  }

  Future toggleVibration() async {
    _isVibrationEnabled = !_isVibrationEnabled;
    notifyListeners();

    await persistStore..setBool(_isVibrationEnabledKey, _isVibrationEnabled);
  }

  Future changeRoundTime(int roundTime) async {
    _roundTime = roundTime;
    notifyListeners();

    await persistStore..setInt(_roundTimeKey, _roundTime);
  }

  static SettingsModel of(BuildContext context) =>
      ScopedModel.of<SettingsModel>(context);
}
