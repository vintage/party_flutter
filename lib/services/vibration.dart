import 'package:vibration/vibration.dart';

class VibrationService {
  static vibrate() async {
    bool canVibrate = await Vibration.hasVibrator();

    if (canVibrate) {
      Vibration.vibrate();
    }
  }
}
