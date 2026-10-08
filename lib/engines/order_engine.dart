import '../config/game_config.dart';
import '../models/item_model.dart';
import '../models/order_model.dart';

/// Müşteri siparişleri akışını, sabır sürelerini ve teslimat doğrulamalarını yöneten Domain motoru.
abstract final class OrderEngine {
  /// Sabır sürelerini 1 tick (0.10 sn) azaltır ve süresi dolan siparişleri döndürür.
  static List<CustomerOrder> tickOrders({
    required List<CustomerOrder> orders,
    required double deltaSeconds,
    required bool isFrozen,
  }) {
    if (isFrozen) return const [];

    final expiredList = <CustomerOrder>[];
    for (final order in orders) {
      if (!order.isCompleted && !order.isExpired) {
        order.remainingSeconds -= deltaSeconds;
        if (order.remainingSeconds <= 0) {
          order.remainingSeconds = 0;
          order.isExpired = true;
          expiredList.add(order);
        }
      }
    }
    return expiredList;
  }

  /// Sipariş listesini maksimum kapasiteye (`GameConfig.maxActiveOrders`) kadar doldurur.
  static void ensureOrderSlots({
    required List<CustomerOrder> currentOrders,
    required List<GameItem> pool,
    double speedMultiplier = 1.0,
  }) {
    while (currentOrders.length < GameConfig.maxActiveOrders) {
      final newOrder = CustomerOrder.generateRandomOrder(
        pool: pool,
        speedMultiplier: speedMultiplier,
      );
      currentOrders.add(newOrder);
    }
  }

  /// Verilen yemeğin eşleştiği ilk aktif siparişi bulur
  static CustomerOrder? findMatchingOrder({
    required List<CustomerOrder> orders,
    required GameItem deliveredItem,
  }) {
    for (final order in orders) {
      if (order.isCompleted || order.isExpired) continue;

      if (order.isPartyTray) {
        for (int i = 0; i < order.partyItems.length; i++) {
          if (!order.partyCompletedItems[i] && order.partyItems[i].code == deliveredItem.code) {
            return order;
          }
        }
      } else if (order.targetItem.code == deliveredItem.code) {
        return order;
      }
    }
    return null;
  }
}
