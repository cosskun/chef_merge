import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chef_merge/main.dart';
import 'package:chef_merge/models/order_model.dart';
import 'package:chef_merge/models/item_model.dart';
import 'package:chef_merge/models/level_model.dart';
import 'package:chef_merge/widgets/order_recipe_dialog.dart';
import 'package:chef_merge/widgets/level_victory_dialog.dart';
import 'package:chef_merge/widgets/recipe_book_dialog.dart';
import 'package:chef_merge/widgets/level_select_dialog.dart';
import 'package:chef_merge/widgets/custom_skin_dialog.dart';
import 'package:chef_merge/widgets/music_select_dialog.dart';
import 'package:chef_merge/widgets/daily_wheel_dialog.dart';
import 'package:chef_merge/widgets/language_select_dialog.dart';
import 'package:chef_merge/state/game_controller.dart';
import 'package:chef_merge/screens/splash_screen.dart';
import 'package:chef_merge/screens/home_screen.dart';
import 'package:chef_merge/screens/game_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final screenSizes = [
    const Size(320, 568), // iPhone SE 1st gen / Small Android
    const Size(360, 640), // Standard Budget Android
    const Size(375, 667), // iPhone 8 / SE 2nd gen
    const Size(390, 844), // iPhone 13/14
    const Size(412, 915), // Modern Android (Pixel 7 / Galaxy S23)
  ];

  for (final size in screenSizes) {
    group('Ekran Boyutu (${size.width}x${size.height}) Taşma & Piksel Hata Testleri', () {
      testWidgets('SplashScreen sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(home: SplashScreen()),
        );
        await tester.pump(const Duration(milliseconds: 3000));

        expect(tester.takeException(), isNull, reason: 'SplashScreen taşma hatası verdi!');
      });

      testWidgets('HomeScreen sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(home: HomeScreen()),
        );
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull, reason: 'HomeScreen taşma hatası verdi!');
      });

      testWidgets('GameScreen sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(home: GameScreen()),
        );
        await tester.pump(const Duration(milliseconds: 100));

        expect(tester.takeException(), isNull, reason: 'GameScreen taşma hatası verdi!');
      });

      testWidgets('OrderRecipeDialog (Uzun VIP İsimli Sipariş) sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        final testOrder = CustomerOrder(
          id: 'vip_test',
          customerName: '🕵️ 👑 VIP Michelin Müfettişi',
          customerAvatar: '🕵️',
          targetItem: GameItem.lasagna,
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
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'OrderRecipeDialog taşma hatası verdi!');
      });

      testWidgets('LevelVictoryDialog sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LevelVictoryDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'LevelVictoryDialog taşma hatası verdi!');
      });

      testWidgets('LanguageSelectDialog sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: LanguageSelectDialog(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'LanguageSelectDialog taşma hatası verdi!');
      });

      testWidgets('LevelSelectDialog sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: LevelSelectDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'LevelSelectDialog taşma hatası verdi!');
      });

      testWidgets('CustomSkinDialog (Mutfak & Şef Maskotları) sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomSkinDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'CustomSkinDialog taşma hatası verdi!');

        // 2. Sekmeye (Şef Maskotları) geçip orada da taşma kontrolü yap
        final mascotTabFinder = find.text('Şef Maskotları');
        if (mascotTabFinder.evaluate().isNotEmpty) {
          await tester.tap(mascotTabFinder);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: 'CustomSkinDialog Şef Maskotları sekmesinde taşma hatası verdi!');
        }
      });
      testWidgets('MusicSelectDialog sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: MusicSelectDialog(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'MusicSelectDialog taşma hatası verdi!');
      });

      testWidgets('DailyWheelDialog sıfır overflow ile render olmalıdır', (WidgetTester tester) async {
        tester.view.physicalSize = Size(size.width * 2, size.height * 2);
        tester.view.devicePixelRatio = 2.0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DailyWheelDialog(controller: GameController.instance),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'DailyWheelDialog taşma hatası verdi!');
      });
    });
  }

  group('Samsung OneUI Yüksek Font Ölçeği (1.35x Metin Boyutu) Taşma Testleri', () {
    testWidgets('LevelSelectDialog Samsung 1.35x font ile taşmamalıdır', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360 * 2, 640 * 2);
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.35)),
            child: child!,
          ),
          home: Scaffold(
            body: LevelSelectDialog(controller: GameController.instance),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: 'LevelSelectDialog 1.35x font ölçeğinde taştı!');
    });

    testWidgets('CustomSkinDialog (Tezgâh & Maskot) Samsung 1.35x font ile taşmamalıdır', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360 * 2, 640 * 2);
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.35)),
            child: child!,
          ),
          home: Scaffold(
            body: CustomSkinDialog(controller: GameController.instance),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: 'CustomSkinDialog 1.35x font ölçeğinde taştı!');

      final mascotTabFinder = find.text('Şef Maskotları');
      if (mascotTabFinder.evaluate().isNotEmpty) {
        await tester.tap(mascotTabFinder);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: 'CustomSkinDialog Şef Maskotları 1.35x font ölçeğinde taştı!');
      }
    });
  });
}
