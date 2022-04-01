
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_sample/logic/login.dart';

void main() {
  Logic target = Logic();

  setUp(() async{
    target = Logic();
  });

  group('init', () {
    test('init', () async{
      expect(target.countData.count, 0);
      expect(target.countData.countUp, 0);
      expect(target.countData.countDown, 0);
    });
  });

  test('increase', () async{
    target.increase();
    expect(target.countData.count, 1);
    expect(target.countData.countUp, 1);
    expect(target.countData.countDown, 0);
  });

  test('decrease', () async{
    target.decrease();
    expect(target.countData.count, -1);
    expect(target.countData.countUp, 0);
    expect(target.countData.countDown, 1);
  });

  test('reset', () async{
    target.decrease();
    expect(target.countData.count, -1);
    expect(target.countData.countUp, 0);
    expect(target.countData.countDown, 1);
    target.increase();
    expect(target.countData.count, 0);
    expect(target.countData.countUp, 1);
    expect(target.countData.countDown, 1);
    target.increase();
    expect(target.countData.count, 1);
    expect(target.countData.countUp, 2);
    expect(target.countData.countDown, 1);

    target.reset();
    expect(target.countData.count, 0);
    expect(target.countData.countUp, 0);
    expect(target.countData.countDown, 0);
  });
}