import 'package:audioplayers/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioService {
  static AudioCache sfxPlayer = new AudioCache(prefix: 'sfx/');

  static _playSfx(String name) async {
    // TODO: Refactor access to shared prefs to it can be reused by store/service
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool canAudio = prefs.getBool('is_audio_enabled') ?? true;
    if (canAudio) {
      sfxPlayer.play(name);
    }
  }

  static click() {
    _playSfx('click.wav');
  }

  static invalid() {
    _playSfx('choice_invalid.wav');
  }

  static valid() {
    _playSfx('choice_valid.wav');
  }
}
