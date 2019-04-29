import 'package:vibration/vibration.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/store/settings.dart';

class VibrationService {
  static vibrate(BuildContext context) async {
    bool canVibrate = await Vibration.hasVibrator() &&
        SettingsModel.of(context).isVibrationEnabled;

    if (canVibrate) {
      Vibration.vibrate();
    }
  }
}
