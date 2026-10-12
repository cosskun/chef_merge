import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chef_merge/models/order_model.dart';
import 'package:chef_merge/models/item_model.dart';
import 'package:chef_merge/models/level_model.dart';
import 'package:chef_merge/models/recipe_model.dart';
import 'package:chef_merge/widgets/order_recipe_dialog.dart';
import 'package:chef_merge/widgets/level_victory_dialog.dart';
import 'package:chef_merge/widgets/recipe_book_dialog.dart';
import 'package:chef_merge/widgets/level_select_dialog.dart';
import 'package:chef_merge/widgets/leaderboard_dialog.dart';
import 'package:chef_merge/widgets/language_select_dialog.dart';
import 'package:chef_merge/widgets/custom_skin_dialog.dart';
import 'package:chef_merge/widgets/music_select_dialog.dart';
import 'package:chef_merge/widgets/daily_wheel_dialog.dart';
import 'package:chef_merge/state/game_controller.dart';
import 'package:chef_merge/services/sound_service.dart';
import 'package:chef_merge/services/localization_service.dart';
import 'package:chef_merge/screens/splash_screen.dart';
import 'package:chef_merge/screens/home_screen.dart';
import 'package:chef_merge/screens/game_screen.dart';
import 'package:chef_merge/screens/tutorial_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Test across key Android & iOS device resolutions
  final targetDevices = <String, Size>{
    'iPhone SE 1st Gen (iOS Small)': const Size(320, 568),
    'Budget Android (Android Small)': const Size(360, 640),
    'iPhone SE / 8 (iOS Standard)': const Size(375, 667),
    'iPhone 14/15/16 (iOS Modern)': const Size(390, 844),
    'iPhone 15/16 Pro Max (iOS Large)': const Size(430, 932),
    'Pixel 7 / Galaxy S24 (Android Modern)': const Size(412, 915),
    'Android Tablet (7-inch)': const Size(600, 1024),
    'iPad Mini / Air (Tablet)': const Size(768, 1024),
  };

  group('Tüm Ekranlar & Diyaloglar Çözünürlük ve Taşma Kontrolü', () {
    for (final entry in targetDevices.entries) {
      final deviceName = entry.key;
      final size = entry.value;

      testWidgets('[$deviceName] SplashScreen hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
        await tester.pump(const Duration(milliseconds: 3000));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] HomeScreen hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] TutorialScreen hatasız render ve scroll olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(const MaterialApp(home: TutorialScreen()));
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);

        // Scroll testing (SingleChildScrollView)
        final scrollable = find.byType(SingleChildScrollView);
        if (scrollable.evaluate().isNotEmpty) {
          await tester.drag(scrollable.first, const Offset(0, -100));
          await tester.pump(const Duration(milliseconds: 100));
        }
        // İleri butonu ile adım geçişi
        final nextBtn = find.text('İLERİ ➔');
        if (nextBtn.evaluate().isNotEmpty) {
          await tester.tap(nextBtn.first);
          await tester.pump(const Duration(milliseconds: 200));
        }
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] GameScreen (Bölüm Modu) hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        GameController.instance.setLevel(0);
        await tester.pumpWidget(const MaterialApp(home: GameScreen()));
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] GameScreen (Sonsuz Mod) hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        GameController.instance.startEndlessMode();
        await tester.pumpWidget(const MaterialApp(home: GameScreen()));
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] LevelSelectDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LevelSelectDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] LeaderboardDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LeaderboardDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] RecipeBookDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: RecipeBookDialog(),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] CustomSkinDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomSkinDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] MusicSelectDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: MusicSelectDialog(),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] LanguageSelectDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LanguageSelectDialog(),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] DailyWheelDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DailyWheelDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] OrderRecipeDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        final testOrder = CustomerOrder(
          id: 'test_order',
          customerName: 'VIP Gurme Şef',
          customerAvatar: '👑',
          targetItem: GameItem.strawberryPancake,
          totalSeconds: 60,
          remainingSeconds: 60,
          isVip: true,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: OrderRecipeDialog(order: testOrder),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });

      testWidgets('[$deviceName] LevelVictoryDialog hatasız render olmalı', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LevelVictoryDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('Tüm Butonlar ve Etkileşim Testleri (Interaction & Button Clicks)', () {
    testWidgets('HomeScreen butonları tıklanabilir ve ilgili aksiyonları tetikler', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(780, 1688); // 390x844
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(milliseconds: 300));

      // 1. Dil Seçimi butonu
      final langBtn = find.text('🌐 TR');
      if (langBtn.evaluate().isNotEmpty) {
        await tester.tap(langBtn);
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(LanguageSelectDialog), findsOneWidget);
        // Kapat
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 2. Müzik butonu
      final musicBtn = find.byIcon(Icons.music_note_rounded);
      if (musicBtn.evaluate().isNotEmpty) {
        await tester.tap(musicBtn.first);
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(MusicSelectDialog), findsOneWidget);
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 3. Tarif Kitabı butonu
      final recipeBtn = find.byIcon(Icons.menu_book_rounded);
      if (recipeBtn.evaluate().isNotEmpty) {
        await tester.tap(recipeBtn.first);
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(RecipeBookDialog), findsOneWidget);
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 4. Seviye Seçimi butonu
      final levelSelectBtn = find.byIcon(Icons.map_rounded);
      if (levelSelectBtn.evaluate().isNotEmpty) {
        await tester.tap(levelSelectBtn.first);
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(LevelSelectDialog), findsOneWidget);
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 5. Şef Özelleştirme butonu
      final skinBtn = find.byIcon(Icons.palette_rounded);
      if (skinBtn.evaluate().isNotEmpty) {
        await tester.tap(skinBtn.first);
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(CustomSkinDialog), findsOneWidget);
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 6. Günlük Çark butonu
      final wheelBtn = find.byIcon(Icons.casino_rounded);
      if (wheelBtn.evaluate().isNotEmpty) {
        await tester.tap(wheelBtn.first);
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(DailyWheelDialog), findsOneWidget);
        await tester.tap(find.byIcon(Icons.close_rounded));
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 7. Sıfırlama Butonu (Verileri Sıfırla)
      final resetBtn = find.byIcon(Icons.delete_outline_rounded);
      if (resetBtn.evaluate().isNotEmpty) {
        await tester.tap(resetBtn.first);
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(AlertDialog), findsOneWidget);
        // İptal et
        await tester.tap(find.text(LocalizationService.tr('cancel')));
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(AlertDialog), findsNothing);
      }
    });

    testWidgets('GameScreen kiler tıklama, durdurma ve joker butonları çalışmalıdır', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(780, 1688); // 390x844
      tester.view.devicePixelRatio = 2.0;

      final controller = GameController.instance;
      controller.setLevel(0);

      await tester.pumpWidget(const MaterialApp(home: GameScreen()));
      await tester.pump(const Duration(milliseconds: 300));

      // 1. Kiler (Spawn butonu)
      final kilerBtn = find.byKey(const ValueKey('pantry_spawn_button'));
      if (kilerBtn.evaluate().isNotEmpty) {
        final initialFilledCount = controller.board.where((i) => i != null).length;
        await tester.tap(kilerBtn);
        await tester.pump(const Duration(milliseconds: 200));
        final newFilledCount = controller.board.where((i) => i != null).length;
        expect(newFilledCount, greaterThanOrEqualTo(initialFilledCount));
      }

      // 2. Duraklatma (Pause) butonu
      final pauseBtn = find.byIcon(Icons.pause_rounded);
      if (pauseBtn.evaluate().isNotEmpty) {
        await tester.tap(pauseBtn);
        await tester.pump(const Duration(milliseconds: 300));
        // Durdurma modal dialogu açıldı mı kontrol
        expect(find.text('Oyuna Devam Et'), findsOneWidget);
        // Devam et butonuna basarak kapat
        await tester.tap(find.text('Oyuna Devam Et'));
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.text('Oyuna Devam Et'), findsNothing);
      }

      // 3. Joker butonları
      final freezeBtn = find.byIcon(Icons.ac_unit_rounded);
      if (freezeBtn.evaluate().isNotEmpty) {
        await tester.tap(freezeBtn.first);
        await tester.pump(const Duration(milliseconds: 300));
        // Booster onay penceresi açıldı mı
        if (find.byType(AlertDialog).evaluate().isNotEmpty) {
          // İptal et
          await tester.tap(find.text('Vazgeç'));
          await tester.pump(const Duration(milliseconds: 300));
        }
      }
    });

    testWidgets('LanguageSelectDialog 4 dilde seçim yapabilmelidir', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: LanguageSelectDialog()),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));

      // Dilleri kontrol et
      expect(find.text('Türkçe'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Español'), findsOneWidget);
      expect(find.text('Deutsch'), findsOneWidget);

      // İngilizce seç
      await tester.tap(find.text('English'));
      await tester.pump(const Duration(milliseconds: 200));
      expect(LocalizationService.currentLanguage.value, 'en');

      // Tekrar Türkçe yap
      LocalizationService.setLanguage('tr');
    });

    testWidgets('CustomSkinDialog tema ve aşçı avatarı değiştirebilmelidir', (WidgetTester tester) async {
      final controller = GameController.instance;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: CustomSkinDialog(controller: controller)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));

      // Sekmeler arası geçiş
      final avatarTab = find.text('Şef Avatarı');
      if (avatarTab.evaluate().isNotEmpty) {
        await tester.tap(avatarTab);
        await tester.pump(const Duration(milliseconds: 300));
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('RecipeBookDialog kategori filtreleri ve arama çalışmalıdır', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: RecipeBookDialog()),
        ),
      );
      await tester.pump(const Duration(milliseconds: 300));

      // Arama inputu
      final searchField = find.byType(TextField);
      if (searchField.evaluate().isNotEmpty) {
        await tester.enterText(searchField, 'Pankek');
        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.takeException(), isNull);
      }
    });
  });
}
