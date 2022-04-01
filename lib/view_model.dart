import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/logic/login.dart';
import 'package:riverpod_sample/logic/sound_logic.dart';
import 'package:riverpod_sample/provider.dart';

class ViewModel {
  final Logic _logic = Logic();
  final SoundLogic _soundLogic = SoundLogic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
    _soundLogic.load();
  }

  get count => _ref.watch(countDataProvider.state).state.count.toString();

  get countUp => _ref.watch(countDataProvider.state).state.countUp.toString();

  get countDown =>
      _ref.watch(countDataProvider.state).state.countDown.toString();

  void onIncrease() {
    _logic.increase();
    _ref.watch(countDataProvider.state).state = _logic.countData;
    _soundLogic.playUpSound();
  }

  void onDecrease() {
    _logic.decrease();
    _ref.watch(countDataProvider.state).state = _logic.countData;
    _soundLogic.playDownSound();
  }

  void onReset() {
    _logic.reset();
    _ref.watch(countDataProvider.state).state = _logic.countData;
    _soundLogic.playResetSound();
  }
}
