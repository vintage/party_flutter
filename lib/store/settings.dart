import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';

class SettingsModel extends Model {
  String _isAudioEnabledKey = 'is_audio_enabled';
  String _isRotationControlEnabledKey = 'is_rotation_control_enabled';
  String _isVibrationEnabledKey = 'is_vibration_enabled';
  String _languageKey = 'language';

  bool _isAudioEnabled = true;
  bool get isAudioEnabled => _isAudioEnabled;

  bool _isRotationControlEnabled = false;
  bool get isRotationControlEnabled => _isRotationControlEnabled;

  bool _isVibrationEnabled = true;
  bool get isVibrationEnabled => _isVibrationEnabled;

  String _language;
  String get language => _language;

  Future initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isAudioEnabled = prefs.getBool(_isAudioEnabledKey) ?? true;
    _isRotationControlEnabled = prefs.getBool(_isRotationControlEnabledKey) ?? false;
    _isVibrationEnabled = prefs.getBool(_isVibrationEnabledKey) ?? true;
    _language = prefs.getString(_languageKey) ?? null;
    notifyListeners();
  }

  Future toggleAudio() async {
    _isAudioEnabled = !_isAudioEnabled;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isAudioEnabledKey, _isAudioEnabled);
  }

  Future toggleRotationControl() async {
    _isRotationControlEnabled = !_isRotationControlEnabled;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isRotationControlEnabledKey, _isRotationControlEnabled);
  }

  Future toggleVibration() async {
    _isVibrationEnabled = !_isVibrationEnabled;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isVibrationEnabledKey, _isVibrationEnabled);
  }

  Future changeLanguage(String language) async {
    _language = language;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_languageKey, _language);
  }

  static SettingsModel of(BuildContext context) =>
      ScopedModel.of<SettingsModel>(context);
}
