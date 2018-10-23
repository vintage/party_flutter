import 'package:audioplayers/audio_cache.dart';


class AudioService {
  static AudioCache sfxPlayer = new AudioCache(prefix: 'sfx/');

  static click() {
    sfxPlayer.play('click.wav', volume: 1.0);
  }

  static invalid() {
    sfxPlayer.play('choice_invalid.wav');
  }

  static valid() {
    sfxPlayer.play('choice_valid.wav');
  }
}
