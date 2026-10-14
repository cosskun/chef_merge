import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chef_merge/services/sound_service.dart';
import 'package:chef_merge/services/save_service.dart';
import 'package:chef_merge/services/localization_service.dart';
import 'package:chef_merge/state/game_controller.dart';
import 'package:chef_merge/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('xyz.luan/audioplayers.global'), (call) async {
      return 1;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('xyz.luan/audioplayers'), (call) async {
      return 1;
    });
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SaveService.init();
    LocalizationService.init();
    SoundService.init();
    SoundService.musicEnabled = true;
    SoundService.soundEnabled = true;
  });

  group('SoundService & AppLifecycle Arkaplan Müzik Kontrol Testleri', () {
    test('Arkaplana geçildiğinde (paused/hidden/inactive) müzik duraklatılmalıdır', () {
      SoundService.isPlayingBgmForTesting = true;
      expect(SoundService.isPlayingBgm, isTrue);

      // Simüle et: Uygulama arkaplana atıldı (paused)
      SoundService.handleAppLifecycleState(AppLifecycleState.paused);
      expect(SoundService.isPlayingBgm, isFalse, reason: 'Uygulama arkaplana geçince BGM durmalıdır');
      expect(SoundService.wasPlayingBeforeBackground, isTrue);

      // Simüle et: Uygulama tekrar ön plana geldi (resumed)
      SoundService.handleAppLifecycleState(AppLifecycleState.resumed);
      expect(SoundService.isPlayingBgm, isTrue, reason: 'Uygulama ön plana gelince BGM devam etmelidir');
      expect(SoundService.wasPlayingBeforeBackground, isFalse);
    });

    test('Arkaplana geçildiğinde (inactive) müzik duraklatılmalıdır', () {
      SoundService.isPlayingBgmForTesting = true;
      expect(SoundService.isPlayingBgm, isTrue);

      SoundService.handleAppLifecycleState(AppLifecycleState.inactive);
      expect(SoundService.isPlayingBgm, isFalse, reason: 'Uygulama inactive olunca BGM durmalıdır');

      SoundService.handleAppLifecycleState(AppLifecycleState.resumed);
      expect(SoundService.isPlayingBgm, isTrue);
    });

    test('Müzik kapalıysa (musicEnabled = false) arkaplandan dönünce müzik çalmamalıdır', () {
      SoundService.musicEnabled = false;
      SoundService.isPlayingBgmForTesting = false;
      expect(SoundService.isPlayingBgm, isFalse);

      SoundService.handleAppLifecycleState(AppLifecycleState.paused);
      SoundService.handleAppLifecycleState(AppLifecycleState.resumed);

      expect(SoundService.isPlayingBgm, isFalse, reason: 'Kullanıcı müziği kapatmışsa ön plana gelse dahi çalmamalıdır');
    });

    test('Müzik zaten çalmıyorken arkaplana geçilirse, dönüldüğünde müzik başlatılmamalıdır', () {
      SoundService.isPlayingBgmForTesting = false;
      expect(SoundService.isPlayingBgm, isFalse);

      SoundService.handleAppLifecycleState(AppLifecycleState.paused);
      SoundService.handleAppLifecycleState(AppLifecycleState.resumed);

      expect(SoundService.isPlayingBgm, isFalse, reason: 'Önceden çalmıyorsa otomatik açılmamalıdır');
    });

    test('GameController arkaplana geçildiğinde oyunu duraklatmalı ve dönüldüğünde sürdürmelidir', () {
      final controller = GameController.instance;
      controller.resumeGame();
      expect(controller.isPlaying, isTrue);

      controller.handleAppLifecycleState(AppLifecycleState.paused);
      expect(controller.isPlaying, isFalse, reason: 'Arkaplana geçince oyun döngüsü duraklatılmalıdır');

      controller.handleAppLifecycleState(AppLifecycleState.resumed);
      expect(controller.isPlaying, isTrue, reason: 'Ön plana dönünce oyun döngüsü sürdürülmelidir');
    });

    testWidgets('ChefMergeApp widget lifecycle değiştiğinde SoundService ve GameController tetiklenmelidir', (WidgetTester tester) async {
      await tester.pumpWidget(const ChefMergeApp(home: Scaffold(body: Text('Lifecycle Test'))));
      await tester.pump();

      final controller = GameController.instance;
      controller.resumeGame();
      SoundService.isPlayingBgmForTesting = true;

      expect(controller.isPlaying, isTrue);
      expect(SoundService.isPlayingBgm, isTrue);

      // System lifecycle state -> paused
      WidgetsBinding.instance.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump();

      expect(controller.isPlaying, isFalse);
      expect(SoundService.isPlayingBgm, isFalse);

      // System lifecycle state -> resumed
      WidgetsBinding.instance.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      expect(controller.isPlaying, isTrue);
      expect(SoundService.isPlayingBgm, isTrue);

      controller.pauseGame();
    });
  });
}
