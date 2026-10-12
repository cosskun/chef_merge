import 'package:flutter_test/flutter_test.dart';
import 'package:chef_merge/models/item_model.dart';
import 'package:chef_merge/models/level_model.dart';
import 'package:chef_merge/models/recipe_model.dart';
import 'package:chef_merge/services/localization_service.dart';
import 'package:chef_merge/state/game_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('1. 100 Seviye Doğrulama Testleri (100 Levels Integrity)', () {
    test('Toplamda tam 100 seviye tanımlı olmalıdır', () {
      expect(GameLevel.allLevels.length, 100);
    });

    test('Bütün seviyelerin numaraları 1-100 arasında sıralı ve benzersiz olmalıdır', () {
      for (int i = 0; i < GameLevel.allLevels.length; i++) {
        final level = GameLevel.allLevels[i];
        expect(level.number, i + 1);
        expect(level.title.isNotEmpty, true);
        expect(level.categoryName.isNotEmpty, true);
        expect(level.targetScore > 0, true);
        expect(level.rawPool.isNotEmpty, true);
        expect(level.orderPool.isNotEmpty, true);
      }
    });

    test('Bölüm 100 (Final) en yüksek puana sahip olmalıdır', () {
      final finalLevel = GameLevel.allLevels.last;
      expect(finalLevel.number, 100);
      expect(finalLevel.targetScore, 16650);
      expect(finalLevel.star1Score, 7500);
      expect(finalLevel.durationSeconds, 300);
    });
  });

  group('2. Tarif & Malzeme Doğrulama Testleri (Recipes & Items)', () {
    test('Tüm standart tariflerin girdileri ve çıktıları geçerli bir GameItem olmalıdır', () {
      for (final recipe in Recipe.standardRecipes) {
        final itemA = GameItem.findByCode(recipe.itemACode);
        final itemB = GameItem.findByCode(recipe.itemBCode);
        expect(itemA, isNotNull, reason: 'Tarif A girdisi geçersiz: ${recipe.itemACode}');
        expect(itemB, isNotNull, reason: 'Tarif B girdisi geçersiz: ${recipe.itemBCode}');
        expect(recipe.result, isNotNull);
      }
    });

    test('Yeni eklenen kategoriler (Makarna, Simit, Tavuk, Kumpir, Künefe, Ege Meze, Saray Yemekleri) kayıtlı olmalıdır', () {
      final testCodes = [
        'spaghetti', 'lasagna', 'simit', 'lahmacun', 'pide', 'baklava',
        'raw_chicken', 'chicken_bucket', 'buffalo_wings', 'ortakoy_kumpir',
        'kunefe', 'calamari_fritti', 'saksuka', 'garlic_shrimp', 'aegean_mezze_platter',
        'sauteed_meat', 'begendi_puree', 'hunkar_begendi', 'ali_nazik', 'orman_kebabi'
      ];

      for (final code in testCodes) {
        final item = GameItem.findByCode(code);
        expect(item, isNotNull, reason: 'Malzeme bulunamadı: $code');
      }
    });

    test('Her 100 bölümdeki tüm siparişler, o bölümün rawPool malzemeleriyle üretilebilir olmalıdır', () {
      final issues = <String>[];

      for (final level in GameLevel.allLevels) {
        final craftable = <String>{...level.rawPool.map((i) => i.code)};
        bool added = true;
        while (added) {
          added = false;
          for (final recipe in Recipe.recipes) {
            if (craftable.contains(recipe.itemACode) && craftable.contains(recipe.itemBCode)) {
              if (!craftable.contains(recipe.result.code)) {
                craftable.add(recipe.result.code);
                added = true;
              }
            }
          }
        }

        for (final order in level.orderPool) {
          if (!craftable.contains(order.code)) {
            issues.add('Bölüm ${level.number} (${level.title}): Sipariş "${order.name}" (${order.code}) rawPool ${level.rawPool.map((r) => r.code).toList()} ile üretilemiyor!');
          }
        }
      }

      expect(issues, isEmpty, reason: '\n' + issues.join('\n'));
    });
  });

  group('3. Çoklu Dil (Localization) Testleri', () {
    test('4 ana dil (TR, EN, ES, DE) aktif olmalıdır', () {
      expect(LocalizationService.supportedLanguages.length, 4);
    });

    test('Dil değiştiğinde reaktif olarak çeviriler güncellenmelidir', () async {
      await LocalizationService.setLanguage('tr');
      expect(LocalizationService.tr('play'), 'OYNA');

      await LocalizationService.setLanguage('en');
      expect(LocalizationService.tr('play'), 'PLAY');

      await LocalizationService.setLanguage('es');
      expect(LocalizationService.tr('play'), 'JUGAR');

      await LocalizationService.setLanguage('de');
      expect(LocalizationService.tr('play'), 'SPIELEN');

      // Geri Türkçeye al
      await LocalizationService.setLanguage('tr');
    });

    test('Malzeme isimleri farklı dillerde çevrilmelidir', () async {
      await LocalizationService.setLanguage('en');
      expect(LocalizationService.getItemName('raw_tomato'), 'Tomato');
      expect(LocalizationService.getItemName('toast'), 'Cheese Toast');

      await LocalizationService.setLanguage('tr');
      expect(LocalizationService.getItemName('raw_tomato'), 'Domates');
      expect(LocalizationService.getItemName('toast'), 'Kaşarlı Tost');
    });
  });

  group('4. Oyun Mantığı & Birleştirme (Game Engine)', () {
    test('Aynı 2 ham domates birleşince doğranmış domates üretmelidir', () {
      final controller = GameController.instance;
      controller.setLevel(0);

      // Tahtaya kontrollü malzeme yerleştir
      controller.setItemAt(0, GameItem.rawTomato);
      controller.setItemAt(1, GameItem.rawTomato);

      controller.mergeSlots(0, 1);

      expect(controller.board[0], isNull);
      expect(controller.board[1]?.code, 'chopped_tomato');
    });

    test('Çöp kutusu yanmış yemeği veya istenmeyen malzemeyi temizlemelidir', () {
      final controller = GameController.instance;
      controller.setLevel(0);
      controller.setItemAt(0, GameItem.ruinedFood);

      controller.trashItem(0);
      expect(controller.board[0], isNull);
    });

    test('Tarif hammadde gereksinimleri (getRawIngredientsRequirements) doğru hesaplanmalıdır', () {
      final toastReqs = Recipe.getRawIngredientsRequirements('toast');
      expect(toastReqs['raw_bread'], 2, reason: '1 Kaşarlı Tost için 2 adet çiğ ekmek gerekir');
      expect(toastReqs['cheese'], 1, reason: '1 Kaşarlı Tost için 1 adet kaşar gerekir');
    });

    test('Sonsuz modda kiler malzemeleri aktif siparişlerin tariflerine göre gelmelidir', () {
      final controller = GameController.instance;
      controller.startEndlessMode();

      // Aktif siparişlerin gerektirdiği hammadde kodları
      final neededCodes = <String>{};
      for (final o in controller.orders) {
        if (o.isPartyTray) {
          for (final item in o.partyItems) {
            neededCodes.addAll(Recipe.getRawIngredientsRequirements(item.code).keys);
          }
        } else {
          neededCodes.addAll(Recipe.getRawIngredientsRequirements(o.targetItem.code).keys);
        }
      }

      // Tahtayı temizle ve 10 kez malzeme çıkararak aktif siparişlere ait olduğunu doğrula
      for (int i = 0; i < 16; i++) {
        controller.setItemAt(i, null);
      }

      for (int i = 0; i < 10; i++) {
        final success = controller.spawnIngredient();
        expect(success, isTrue);
        final spawnedItem = controller.board[i];
        expect(neededCodes.contains(spawnedItem?.code), isTrue,
            reason: 'Çıkan malzeme (${spawnedItem?.name}) aktif siparişlerin hammaddesi olmalıdır.');
      }
    });

    test('Süpürge jokeri tahtadaki tüm malzemeleri ve çöpleri tamamen temizlemelidir', () {
      final controller = GameController.instance;
      controller.setLevel(0);
      controller.addBroomBoosters(1);

      // Tahtayı domates, soğan ve çöp ile doldur
      controller.setItemAt(0, GameItem.rawTomato);
      controller.setItemAt(1, GameItem.onion);
      controller.setItemAt(2, GameItem.ruinedFood);
      controller.setItemAt(3, GameItem.cheese);

      controller.useBroomBooster();

      for (int i = 0; i < GameController.boardSize; i++) {
        expect(controller.board[i], isNull, reason: 'Slot $i boş olmalıdır');
      }
    });
  });

  group('5. Veri Sıfırlama (Data Reset) Testleri', () {
    test('Veri sıfırlama çeviri anahtarları 4 dilde de mevcut olmalıdır', () {
      for (final lang in ['tr', 'en', 'es', 'de']) {
        LocalizationService.currentLanguage.value = lang;
        expect(LocalizationService.tr('reset_data').isNotEmpty, true);
        expect(LocalizationService.tr('reset_confirm_title').isNotEmpty, true);
        expect(LocalizationService.tr('reset_confirm_message').isNotEmpty, true);
        expect(LocalizationService.tr('confirm_reset').isNotEmpty, true);
        expect(LocalizationService.tr('cancel').isNotEmpty, true);
        expect(LocalizationService.tr('reset_success').isNotEmpty, true);
      }
    });

    test('resetAllData() tüm oyun ilerlemesini ve istatistikleri sıfırlamalıdır', () async {
      final controller = GameController.instance;
      controller.setLevel(5);

      await controller.resetAllData(keepSettings: true);

      expect(controller.currentLevelIndex, 0);
      expect(controller.unlockedLevels, {0});
      expect(controller.levelStars.isEmpty, true);
      expect(controller.totalStarsEarned, 0);
      expect(controller.highScore, 0);
      expect(controller.endlessHighScore, 0);
      expect(controller.boardSkinId, 'classic');
      expect(controller.chefAvatar, '👨‍🍳');
      expect(controller.freezeBoosters, 3);
      expect(controller.spatulaBoosters, 3);
      expect(controller.broomBoosters, 3);
    });
  });
}

