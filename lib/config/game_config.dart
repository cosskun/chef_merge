/// Oyun mekanikleri, süreler, çarpanlar ve sabit kuralları içeren merkezi konfigürasyon sınıfı.
abstract final class GameConfig {
  // --- Tahta & Kiler Kuralları ---
  static const int boardSize = 16; // 4x4 Grid
  static const int boardRowCount = 4;
  static const int boardColCount = 4;

  // --- Sipariş Kuralları ---
  static const int maxActiveOrders = 3;
  static const double defaultLevelDuration = 180.0; // 3 Dakika
  static const double fastDeliveryRatio = 0.50; // Kalan süre %50'den fazlaysa hızlı teslimat sayılır

  // --- Olasılıklar ---
  static const double vipOrderProbability = 0.18; // %18 VIP Gurme Müşteri
  static const double partyOrderProbability = 0.16; // %16 2 Tabaklı Büyük Parti & Zafer Tepsisi
  static const double secretRecipeSpawnProbability = 0.10; // %10 Gizli Simya Şansı

  // --- Puanlama & Çarpanlar ---
  static const double fastDeliveryMultiplier = 1.35; // Hızlı teslimat bonusu
  static const double vipScoreMultiplier = 2.20; // VIP Müşteri puan çarpanı
  static const double partyTrayBonusMultiplier = 1.20; // 2 Tabaklı Zafer Tepsisi bonusu
  static const int defaultBasePoints = 25;
  static const int pointsPerRawIngredient = 15;
  static const int pointsPerItemLevel = 10;
  static const int streakStepBonus = 20; // Her streak basamağında +20 puan
  static const int maxStreakBonus = 120; // Maksimum streak bonus tavanı
  static const int orderTimeoutPenalty = 50; // Sipariş zaman aşımı ceza puanı

  // --- Alevli Kombo (Fire Combo) Kuralları ---
  static const double comboResetWindowSeconds = 3.0; // 3 saniye içinde teslim edilmezse kombo sıfırlanır
  static const double comboTier1Multiplier = 1.5; // 2 Seri teslimat
  static const double comboTier2Multiplier = 2.0; // 4 Seri teslimat
  static const double comboTier3Multiplier = 3.0; // 6+ Seri çılgın alev teslimatı

  // --- Güçlendiriciler (Boosters) ---
  static const int defaultBoosterCount = 3;
  static const double freezeBoosterDuration = 10.0; // 10 saniye dondurma

  // --- Müfettiş Baskını (Inspector Raid) ---
  static const int inspectorRaidIntervalTicks = 450; // ~45 saniye
  static const double inspectorRaidCleanBoardThreshold = 0.60; // Tahtanın en az %60'ı temiz/düzenli olmalı
  static const int inspectorSuccessReward = 200;
  static const int inspectorFailurePenalty = 100;
}
