import 'package:vibrate/vibrate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VibrationService {
  static vibrate() async {
    // TODO: Refactor access to shared prefs to it can be reused by store/service
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool canVibrate = await Vibrate.canVibrate && prefs.getBool('is_vibration_enabled') ?? true;

    if (canVibrate) {
      Vibrate.vibrate();
    }
  }
}
