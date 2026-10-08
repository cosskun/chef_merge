import 'package:flutter_test/flutter_test.dart';
import 'package:chef_merge/config/game_config.dart';
import 'package:chef_merge/engines/score_engine.dart';
import 'package:chef_merge/engines/spawn_engine.dart';
import 'package:chef_merge/engines/order_engine.dart';
import 'package:chef_merge/models/item_model.dart';
import 'package:chef_merge/models/level_model.dart';
import 'package:chef_merge/models/order_model.dart';

void main() {
  group('1. GameConfig Konfigürasyon Testleri', () {
    test('Temel tahta ve sipariş sabitleri doğru tanımlanmalıdır', () {
      expect(GameConfig.boardSize, 16);
      expect(GameConfig.maxActiveOrders, 3);
      expect(GameConfig.defaultLevelDuration, 180.0);
      expect(GameConfig.fastDeliveryRatio, 0.50);
      expect(GameConfig.freezeBoosterDuration, 10.0);
    });
  });

  group('2. ScoreEngine Domain Testleri', () {
    test('Hızlı teslimat ve VIP sipariş çarpanları doğru hesaplanmalıdır', () {
      final normalOrder = CustomerOrder(
        id: 'test_1',
        targetItem: GameItem.toast,
        customerName: 'Test',
        customerAvatar: '👨‍🍳',
        totalSeconds: 30.0,
        remainingSeconds: 20.0, // > %50 -> Hızlı teslimat
      );

      final points = ScoreEngine.calculateOrderPoints(order: normalOrder, streak: 2);
      expect(points, greaterThan(0));
      expect(normalOrder.isFastDelivery, isTrue);
    });

    test('Seri teslimat (Streak) kombo çarpanı kademeleri doğru çalışmalıdır', () {
      expect(ScoreEngine.getComboMultiplier(0), 1.0);
      expect(ScoreEngine.getComboMultiplier(1), 1.0);
      expect(ScoreEngine.getComboMultiplier(2), 1.5);
      expect(ScoreEngine.getComboMultiplier(4), 2.0);
      expect(ScoreEngine.getComboMultiplier(6), 3.0);
    });

    test('Yıldız hesaplamaları seviye eşiklerine göre doğru sonuç vermelidir', () {
      final level = GameLevel.allLevels[0];
      expect(ScoreEngine.calculateStars(score: level.star3Score, level: level), 3);
      expect(ScoreEngine.calculateStars(score: level.star2Score, level: level), 2);
      expect(ScoreEngine.calculateStars(score: level.star1Score, level: level), 1);
      expect(ScoreEngine.calculateStars(score: 0, level: level), 0);
    });
  });

  group('3. OrderEngine Domain Testleri', () {
    test('Sipariş sabır süreleri tick ile azalmalı ve süresi dolanlar tespit edilmelidir', () {
      final order1 = CustomerOrder(
        id: 'ord_1',
        targetItem: GameItem.rawTomato,
        customerName: 'Müşteri 1',
        customerAvatar: '👨‍🍳',
        totalSeconds: 10.0,
        remainingSeconds: 0.05,
      );

      final expired = OrderEngine.tickOrders(
        orders: [order1],
        deltaSeconds: 0.10,
        isFrozen: false,
      );

      expect(expired.length, 1);
      expect(expired.first.id, 'ord_1');
      expect(order1.isExpired, isTrue);
    });

    test('Buz dondurması etkinken sabır süreleri akmamalıdır', () {
      final order1 = CustomerOrder(
        id: 'ord_1',
        targetItem: GameItem.rawTomato,
        customerName: 'Müşteri 1',
        customerAvatar: '👨‍🍳',
        totalSeconds: 10.0,
        remainingSeconds: 5.0,
      );

      final expired = OrderEngine.tickOrders(
        orders: [order1],
        deltaSeconds: 0.10,
        isFrozen: true,
      );

      expect(expired.isEmpty, isTrue);
      expect(order1.remainingSeconds, 5.0);
    });

    test('Masa kapasitesi dolana kadar yeni sipariş oluşturulmalıdır', () {
      final orders = <CustomerOrder>[];
      OrderEngine.ensureOrderSlots(
        currentOrders: orders,
        pool: [GameItem.toast, GameItem.tomatoSoup],
      );

      expect(orders.length, GameConfig.maxActiveOrders);
    });
  });

  group('4. SpawnEngine Domain Testleri', () {
    test('Sonsuz mod için aktif siparişlerin başlangıç hammaddeleri üretilmelidir', () {
      final order = CustomerOrder(
        id: 'toast_order',
        targetItem: GameItem.toast,
        customerName: 'Ahmet',
        customerAvatar: '👨‍🍳',
        totalSeconds: 30.0,
        remainingSeconds: 30.0,
      );

      final starters = SpawnEngine.getEndlessStarters([order]);
      expect(starters.any((item) => item.code == 'raw_bread'), isTrue);
      expect(starters.any((item) => item.code == 'cheese'), isTrue);
    });
  });
}
