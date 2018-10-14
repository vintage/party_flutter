import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/widgets.dart';

class SettingsModel extends Model {
  String _isSoundEnabledKey = 'is_sound_enabled';
  String _isRotationControlEnabledKey = 'is_rotation_control_enabled';

  bool _isSoundEnabled = true;
  bool get isSoundEnabled => _isSoundEnabled;

  bool _isRotationControlEnabled = false;
  bool get isRotationControlEnabled => _isRotationControlEnabled;

  Future initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSoundEnabled = prefs.getBool(_isSoundEnabledKey) ?? true;
    _isRotationControlEnabled = prefs.getBool(_isRotationControlEnabledKey) ?? false;
    notifyListeners();
  }

  Future toggleSound() async {
    _isSoundEnabled = !_isSoundEnabled;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isSoundEnabledKey, _isSoundEnabled);
  }

  Future toggleRotationControl() async {
    _isRotationControlEnabled = !_isRotationControlEnabled;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isRotationControlEnabledKey, _isRotationControlEnabled);
  }

  static SettingsModel of(BuildContext context) =>
      ScopedModel.of<SettingsModel>(context);
}
