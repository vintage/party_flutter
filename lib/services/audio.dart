import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/widgets.dart';
import 'package:zgadula/store/settings.dart';

class AudioService {
  static AudioCache sfxPlayer = AudioCache(prefix: 'sfx/');

  static _playSfx(BuildContext context, String name) async {
    bool canAudio = SettingsModel.of(context).isAudioEnabled;
    if (canAudio) {
      await sfxPlayer.play(name);
    }
  }

  static invalid(context) {
    _playSfx(context, 'choice_invalid.wav');
  }

  static valid(context) {
    _playSfx(context, 'choice_valid.wav');
  }
}
