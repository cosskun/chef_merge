import 'dart:math';
import '../models/item_model.dart';
import '../models/order_model.dart';
import '../models/recipe_model.dart';

/// Kilerden malzeme çıkarma (Smart Demand-Weighted Spawning) mantığını yöneten Domain motoru.
abstract final class SpawnEngine {
  /// Aktif siparişlerin (veya bölüm tariflerinin) hammadde gereksinim yoğunluğuna göre
  /// en uygun hammaddeyi olasılıksal olarak seçer.
  static GameItem selectWeightedSpawnItem({
    required List<CustomerOrder> orders,
    required List<GameItem?> board,
    required List<GameItem> levelRawPool,
    required bool isEndlessMode,
    required List<GameItem> fallbackOrderPool,
    Random? random,
  }) {
    final rng = random ?? Random();

    // 1. Hedef sipariş kodlarını topla
    final targetOrders = <String>[];
    if (orders.isNotEmpty) {
      for (final o in orders) {
        if (o.isPartyTray) {
          targetOrders.addAll(o.partyItems.map((item) => item.code));
        } else {
          targetOrders.add(o.targetItem.code);
        }
      }
    } else {
      targetOrders.addAll(fallbackOrderPool.map((item) => item.code));
    }

    // 2. Hammadde gereksinim yoğunluklarını hesapla
    final demandCounts = <String, int>{};
    for (final orderCode in targetOrders) {
      final reqs = Recipe.getRawIngredientsRequirements(orderCode);
      reqs.forEach((rawCode, count) {
        demandCounts[rawCode] = (demandCounts[rawCode] ?? 0) + count;
      });
    }

    // 3. Mod havuzunu belirle (Sonsuz modda aktif siparişlerin hammaddeleri gelir)
    final List<GameItem> pool;
    if (isEndlessMode) {
      final neededCodes = demandCounts.keys.toSet();
      final neededPool = GameItem.rawPool.where((item) => neededCodes.contains(item.code)).toList();
      pool = neededPool.isNotEmpty ? neededPool : GameItem.rawPool;
    } else {
      pool = levelRawPool;
    }

    if (pool.isEmpty) {
      return GameItem.rawTomato;
    }

    // 4. Tezgâhtaki mevcut malzeme sayılarını çıkar
    final boardCounts = <String, int>{};
    for (final item in board) {
      if (item != null) {
        boardCounts[item.code] = (boardCounts[item.code] ?? 0) + 1;
      }
    }

    // 5. Ağırlıklı havuz oluştur (Tezgâhta çok birikenleri azalt, eksik ve gerekli olanları artır)
    final weightedPool = <GameItem>[];
    for (final item in pool) {
      int weight = demandCounts[item.code] ?? 1;

      final onBoard = boardCounts[item.code] ?? 0;
      if (onBoard >= 4) {
        weight = max(1, (weight / 2).floor());
      } else if (onBoard == 0 && (demandCounts[item.code] ?? 0) > 0) {
        weight += 1;
      }

      for (int w = 0; w < weight; w++) {
        weightedPool.add(item);
      }
    }

    if (weightedPool.isNotEmpty) {
      return weightedPool[rng.nextInt(weightedPool.length)];
    }
    return pool[rng.nextInt(pool.length)];
  }

  /// Sonsuz mod başlangıcı için aktif siparişlerin hammaddelerini çıkarır
  static List<GameItem> getEndlessStarters(List<CustomerOrder> orders) {
    final starters = <GameItem>[];
    for (final order in orders) {
      final items = order.isPartyTray ? order.partyItems : [order.targetItem];
      for (final item in items) {
        final reqs = Recipe.getRawIngredientsRequirements(item.code);
        for (final code in reqs.keys) {
          final rawItem = GameItem.findByCode(code);
          if (rawItem != null && !starters.contains(rawItem)) {
            starters.add(rawItem);
          }
        }
      }
    }
    return starters;
  }
}
