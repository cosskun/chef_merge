import 'dart:math';
import '../config/game_config.dart';
import '../models/item_model.dart';
import '../models/level_model.dart';
import '../models/order_model.dart';
import '../models/recipe_model.dart';

/// Puanlama, bonuslar, çarpanlar ve yıldız hesaplamalarından sorumlu Domain motoru.
abstract final class ScoreEngine {
  /// Bir siparişin teslimat puanını hammadde derinliği, hız bonusu, VIP ve parti durumuna göre hesaplar.
  static int calculateOrderPoints({
    required CustomerOrder order,
    int streak = 0,
    double comboMultiplier = 1.0,
  }) {
    int basePoints = order.calculateBasePoints();

    // Seri teslimat (Streak) bonusu
    final streakBonus = min(streak * GameConfig.streakStepBonus, GameConfig.maxStreakBonus);
    int total = basePoints + streakBonus;

    // Alevli kombo çarpanı
    if (comboMultiplier > 1.0) {
      total = (total * comboMultiplier).round();
    }

    return total;
  }

  /// 2 kart birleştirildiğinde kazanılan anlık küçük tecrübe puanı
  static int calculateMergePoints(GameItem item) {
    return 5 + (item.level * 5);
  }

  /// Hızlı seri teslimatlara göre kombo çarpanını belirler
  static double getComboMultiplier(int quickDeliveryStreak) {
    if (quickDeliveryStreak >= 6) {
      return GameConfig.comboTier3Multiplier; // 3.0x
    } else if (quickDeliveryStreak >= 4) {
      return GameConfig.comboTier2Multiplier; // 2.0x
    } else if (quickDeliveryStreak >= 2) {
      return GameConfig.comboTier1Multiplier; // 1.5x
    }
    return 1.0;
  }

  /// Skora göre kazanılan yıldız sayısını (0-3) belirler
  static int calculateStars({required int score, required GameLevel level}) {
    return level.calculateStars(score);
  }
}
