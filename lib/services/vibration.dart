import 'package:vibrate/vibrate.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/store/settings.dart';

class VibrationService {
  static vibrate(BuildContext context) async {
    bool canVibrate = await Vibrate.canVibrate && SettingsModel.of(context).isVibrationEnabled;

    if (canVibrate) {
      Vibrate.vibrate();
    }
  }
}
