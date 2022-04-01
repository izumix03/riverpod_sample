import 'package:audioplayers/audioplayers.dart';

class SoundLogic {
  static const soundDataUp = 'sounds/assets_sounds_Onmtp-Flash07-1.mp3';
  static const soundDataDown = 'sounds/assets_sounds_Onmtp-Flash08-1.mp3';
  static const soundDataReset = 'sounds/assets_sounds_Onmtp-Flash09-1.mp3';

  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  void load() {
    _cache.loadAll([soundDataUp, soundDataDown, soundDataReset]);
  }

  void playUpSound() {
    _cache.play(soundDataUp);
  }

  void playDownSound() {
    _cache.play(soundDataDown);
  }

  void playResetSound() {
    _cache.play(soundDataReset);
  }
}
