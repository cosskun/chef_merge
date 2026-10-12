import 'package:flutter_test/flutter_test.dart';
import 'package:chef_merge/models/level_model.dart';
import 'package:chef_merge/models/recipe_model.dart';
import 'package:chef_merge/models/item_model.dart';
import 'package:chef_merge/models/order_model.dart';
import 'package:chef_merge/engines/spawn_engine.dart';
import 'package:chef_merge/state/game_controller.dart';

CustomerOrder makeTestOrder(String id, GameItem item) {
  return CustomerOrder(
    id: id,
    targetItem: item,
    customerName: 'Test',
    customerAvatar: '👨‍🍳',
    totalSeconds: 60,
    remainingSeconds: 60,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Verify validRawPool across all 100 levels has NO extraneous ingredients', () {
    int totalMismatches = 0;
    for (final level in GameLevel.allLevels) {
      final neededRawCodes = <String>{};
      for (final order in level.orderPool) {
        final reqs = Recipe.getRawIngredientsRequirements(order.code);
        neededRawCodes.addAll(reqs.keys);
      }

      final extraneous = <String>[];
      for (final rawItem in level.validRawPool) {
        if (!neededRawCodes.contains(rawItem.code)) {
          extraneous.add(rawItem.code);
        }
      }

      if (extraneous.isNotEmpty) {
        totalMismatches++;
        print('Bölüm ${level.number} (${level.title}): Hâlâ gereksiz malzeme var: $extraneous');
      }
    }
    expect(totalMismatches, 0);
  });

  test('Level 6 pantry NEVER spawns tomatoes, onions, carrots, or mushrooms', () {
    final level6 = GameLevel.allLevels.firstWhere((l) => l.number == 6);
    final orders = [makeTestOrder('1', GameItem.bakedBread)];
    final board = List<GameItem?>.filled(36, null);

    for (int i = 0; i < 500; i++) {
      final spawned = SpawnEngine.selectWeightedSpawnItem(
        orders: orders,
        board: board,
        levelRawPool: level6.validRawPool,
        isEndlessMode: false,
        fallbackOrderPool: level6.orderPool,
      );
      expect(spawned.code, 'raw_bread');
    }
  });

  test('Level 14 pantry NEVER spawns raw_bread or butter', () {
    final level14 = GameLevel.allLevels.firstWhere((l) => l.number == 14);
    final orders = [
      makeTestOrder('1', GameItem.pancake),
      makeTestOrder('2', GameItem.strawberryPancake),
    ];
    final board = List<GameItem?>.filled(36, null);

    final forbiddenCodes = {'raw_bread', 'butter'};
    for (int i = 0; i < 500; i++) {
      final spawned = SpawnEngine.selectWeightedSpawnItem(
        orders: orders,
        board: board,
        levelRawPool: level14.validRawPool,
        isEndlessMode: false,
        fallbackOrderPool: level14.orderPool,
      );
      expect(forbiddenCodes.contains(spawned.code), isFalse);
    }
  });

  test('deliverToMatchingOrPenalize delivers to party tray before later single order (left-to-right)', () {
    final controller = GameController.instance;
    controller.setLevel(0);
    controller.pauseGame();

    // Setup orders: Order 0 (Party Tray: Toast + Bread), Order 1 (Bread), Order 2 (Toast)
    final partyOrder = CustomerOrder(
      id: 'party_1',
      targetItem: GameItem.toast,
      customerName: 'Parti Şefi',
      customerAvatar: '🎪',
      totalSeconds: 60,
      remainingSeconds: 60,
      isPartyTray: true,
      partyItems: [GameItem.toast, GameItem.bakedBread],
      partyCompletedItems: [false, true], // Bread is already completed, Toast is needed!
    );

    final singleBread = makeTestOrder('single_bread', GameItem.bakedBread);
    final singleToast = makeTestOrder('single_toast', GameItem.toast);

    controller.setOrdersForTesting([partyOrder, singleBread, singleToast]);

    // Place Toast at slot 0 on board
    controller.setItemAt(0, GameItem.toast);

    // Deliver to delivery drop area
    final delivered = controller.deliverToMatchingOrPenalize(0);

    expect(delivered, isTrue);
    // MUST deliver to partyOrder (the first order on the left)!
    expect(partyOrder.partyCompletedItems[0], isTrue);
    expect(singleToast.isCompleted, isFalse);
  });

  test('User noted levels (9, 11, 12, 13, 15, 16, 18, 19, 20, 26) strictly spawn only required ingredients', () {
    final board = List<GameItem?>.filled(36, null);

    void verifyLevelSpawns({
      required int levelNumber,
      required Set<String> forbiddenCodes,
      Set<String>? allowedCodesOnly,
    }) {
      final level = GameLevel.allLevels.firstWhere((l) => l.number == levelNumber);
      final orders = level.orderPool.map((item) => makeTestOrder('test_${item.code}', item)).toList();

      for (int i = 0; i < 200; i++) {
        final spawned = SpawnEngine.selectWeightedSpawnItem(
          orders: orders,
          board: board,
          levelRawPool: level.validRawPool,
          isEndlessMode: false,
          fallbackOrderPool: level.orderPool,
        );

        expect(forbiddenCodes.contains(spawned.code), isFalse,
            reason: 'Level $levelNumber: ${spawned.code} should NEVER spawn!');

        if (allowedCodesOnly != null) {
          expect(allowedCodesOnly.contains(spawned.code), isTrue,
              reason: 'Level $levelNumber: ${spawned.code} is not in allowed set $allowedCodesOnly!');
        }
      }
    }

    // 9. Bölüm: tereyağ kullanılmıyor
    verifyLevelSpawns(levelNumber: 9, forbiddenCodes: {'butter'});

    // 11. Bölüm: tereyağ kullanılmıyor, sadece yumurta
    verifyLevelSpawns(levelNumber: 11, forbiddenCodes: {'butter'}, allowedCodesOnly: {'egg'});

    // 12. Bölüm: tereyağ kullanılmıyor
    verifyLevelSpawns(levelNumber: 12, forbiddenCodes: {'butter'});

    // 13. Bölüm: tereyağ kullanılmıyor
    verifyLevelSpawns(levelNumber: 13, forbiddenCodes: {'butter'});

    // 14. Bölüm: tereyağ ve ekmek kullanılmıyor
    verifyLevelSpawns(levelNumber: 14, forbiddenCodes: {'butter', 'raw_bread'});

    // 15. Bölüm: ekmek hamuru ve tereyağ kullanılmıyor
    verifyLevelSpawns(levelNumber: 15, forbiddenCodes: {'raw_bread', 'butter'});

    // 16. Bölüm: sadece susam ve ekmek hamuru
    verifyLevelSpawns(
      levelNumber: 16,
      forbiddenCodes: {'egg', 'sucuk', 'milk', 'strawberry', 'cheese'},
      allowedCodesOnly: {'raw_bread', 'sesame'},
    );

    // 18. Bölüm: peynir kullanılmıyor
    verifyLevelSpawns(levelNumber: 18, forbiddenCodes: {'cheese'});

    // 19. Bölüm: tereyağ kullanılmıyor
    verifyLevelSpawns(levelNumber: 19, forbiddenCodes: {'butter'});

    // 20. Bölüm: kruvasan hamuru yok (fıstık + ekmek hamuru)
    verifyLevelSpawns(levelNumber: 20, forbiddenCodes: {'croissant_dough'});

    // 26. Bölüm: sadece makarna hamuru
    verifyLevelSpawns(
      levelNumber: 26,
      forbiddenCodes: {'raw_bread', 'raw_tomato', 'cheese', 'sucuk', 'mushroom', 'olive'},
      allowedCodesOnly: {'pasta_dough'},
    );
  });
}


