import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_sample/main.dart';
import 'package:riverpod_sample/provider.dart';
import 'package:riverpod_sample/view_model.dart';

import 'golden_test.mocks.dart';

@GenerateMocks([ViewModel])
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });
  testGoldens('normal', (tester) async {
    const iphone55 =
        Device(name: 'iPhone55', size: Size(414, 736), devicePixelRatio: 3.0);

    List<Device> devices = [iphone55];

    ViewModel viewModel = ViewModel();

    await tester.pumpWidgetBuilder(ProviderScope(child: MyHomePage(viewModel)));
    await multiScreenGolden(tester, 'myHomePage_0init', devices: devices);

    await tester.tap(find.byIcon(CupertinoIcons.plus));
    await tester.tap(find.byIcon(CupertinoIcons.plus));
    await tester.tap(find.byIcon(CupertinoIcons.minus));
    await multiScreenGolden(tester, 'myHomePage_1tapped', devices: devices);
  });


  testGoldens('viewModelTest', (tester) async {
    const iphone55 =
    Device(name: 'iPhone55', size: Size(414, 736), devicePixelRatio: 3.0);

    List<Device> devices = [iphone55];

    var mock = MockViewModel();
    when(mock.count).thenReturn(123456789.toString());
    when(mock.countUp).thenReturn(223456789.toString());
    when(mock.countDown).thenReturn(323456789.toString());

    await tester.pumpWidgetBuilder(ProviderScope(child: MyHomePage(mock)));
    await multiScreenGolden(tester, 'myHomePage_mock', devices: devices);

    verifyNever(mock.onIncrease());
    verifyNever(mock.onDecrease());
    verifyNever(mock.onReset());

    // provider 書き換え,ちょっと上手くいってない
    final mockTitleProvider = Provider<String>((ref) => 'mockMessage');
    await tester.pumpWidgetBuilder(
        ProviderScope(
          overrides: [
            titleProvider.overrideWithProvider(mockTitleProvider),
            messageProvider.overrideWithValue('override with value')
          ],
          child: MyHomePage(mock),
        )
    );
    await multiScreenGolden(tester, 'myHomePage_override', devices: devices);
  });
}
