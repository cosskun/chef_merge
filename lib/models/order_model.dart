import 'dart:math';
import 'item_model.dart';
import 'recipe_model.dart';

class CustomerOrder {
  final String id;
  final GameItem targetItem;
  final String customerName;
  final String customerAvatar;
  final double totalSeconds;
  double remainingSeconds;
  bool isCompleted;
  bool isExpired;
  final bool isVip; // Golden VIP Gurme Müşteri
  final bool isPartyTray; // 🍱 Büyük Parti & Catering Tepsisi
  final List<GameItem> partyItems;
  final List<bool> partyCompletedItems;

  CustomerOrder({
    required this.id,
    required this.targetItem,
    required this.customerName,
    required this.customerAvatar,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.isCompleted = false,
    this.isExpired = false,
    this.isVip = false,
    this.isPartyTray = false,
    List<GameItem>? partyItems,
    List<bool>? partyCompletedItems,
  })  : partyItems = partyItems ?? [],
        partyCompletedItems = partyCompletedItems ??
            (partyItems != null ? List<bool>.filled(partyItems.length, false) : []);

  double get progressRatio => (remainingSeconds / totalSeconds).clamp(0.0, 1.0);

  bool get isFastDelivery => progressRatio >= 0.50;

  bool get isPartyFullyCompleted {
    if (!isPartyTray) return isCompleted;
    return partyCompletedItems.isNotEmpty && partyCompletedItems.every((c) => c);
  }

  /// Tepsiden henüz teslim edilmemiş bir parça ile eşleşirse tamamlar
  bool tryDeliverPartyItem(String itemCode) {
    if (!isPartyTray) return false;
    for (int i = 0; i < partyItems.length; i++) {
      if (!partyCompletedItems[i] && partyItems[i].code == itemCode) {
        partyCompletedItems[i] = true;
        if (isPartyFullyCompleted) {
          isCompleted = true;
        }
        return true;
      }
    }
    return false;
  }

  /// Tarifin hammadde sayısı, aşama seviyesi, Parti Tepsisi ve VIP durumuna göre dengeli puanlama
  int calculateBasePoints() {
    if (isPartyTray) {
      int sumPoints = 0;
      for (final item in partyItems) {
        final rawCount = _getRawItemCount(item.code);
        final base = 25 + (rawCount * 15) + (item.level * 10);
        sumPoints += (isFastDelivery ? (base * 1.35).round() : base);
      }
      return (sumPoints * 1.2).round(); // 2 Tabaklı Zafer Tepsisi %20 ekstra bonus
    }

    final rawCount = _getRawItemCount(targetItem.code);
    final baseScore = 25 + (rawCount * 15) + (targetItem.level * 10);
    int points = isFastDelivery ? (baseScore * 1.35).round() : baseScore;

    // VIP Müşteri 2.2 Kat Puan Verir
    if (isVip) {
      points = (points * 2.2).round();
    }

    return points;
  }

  static int _getRawItemCount(String code) {
    try {
      final reqs = Recipe.getRawIngredientsRequirements(code);
      final count = reqs.values.fold<int>(0, (sum, c) => sum + c);
      return count > 0 ? count : 2;
    } catch (_) {
      return 2;
    }
  }

  static final List<Map<String, String>> customerPool = [
    {'name': 'Ahmet Usta', 'avatar': '👨‍🍳'},
    {'name': 'Selin Hanım', 'avatar': '👩‍💼'},
    {'name': 'Can', 'avatar': '🧒'},
    {'name': 'Zeynep', 'avatar': '👩‍🎨'},
    {'name': 'Gurme Mehmet', 'avatar': '🧐'},
    {'name': 'Elif', 'avatar': '👧'},
    {'name': 'Mert', 'avatar': '👨‍💻'},
    {'name': 'Ayşe Teyze', 'avatar': '👵'},
  ];

  static final List<Map<String, String>> vipCustomerPool = [
    {'name': '👑 VIP Kraliyet Gurmesi', 'avatar': '🤴'},
    {'name': '👑 VIP Michelin Denetçisi', 'avatar': '🕵️‍♂️'},
    {'name': '👑 VIP Ünlü Şef Gordon', 'avatar': '🎩'},
    {'name': '👑 VIP Milyarder Lezzet Avcısı', 'avatar': '💎'},
  ];

  static final List<Map<String, String>> partyCustomerPool = [
    {'name': '🍱 Doğum Günü Partisi', 'avatar': '🥳'},
    {'name': '🍱 Kurumsal Catering Tepsisi', 'avatar': '🏢'},
    {'name': '🍱 Arkadaş Film Gecesi Menüsü', 'avatar': '🎬'},
    {'name': '🍱 Şampiyonlar Zafer Tepsisi', 'avatar': '🎪'},
  ];

  static CustomerOrder generateRandomOrder({List<GameItem>? pool, double speedMultiplier = 1.0}) {
    final random = Random();
    final items = pool ?? GameItem.orderPool;

    // %16 İhtimalle 2 Parçalık "Büyük Parti & Zafer Tepsisi Siparişi" gelir!
    final bool isPartyOrder = items.length >= 2 && random.nextDouble() < 0.16;

    if (isPartyOrder) {
      final shuffled = List<GameItem>.from(items)..shuffle(random);
      final selectedItems = shuffled.take(2).toList();
      final partyCustomer = partyCustomerPool[random.nextInt(partyCustomerPool.length)];
      final duration = max(35.0, (52.0 + random.nextInt(6) - 3) / speedMultiplier);

      return CustomerOrder(
        id: 'party_${DateTime.now().microsecondsSinceEpoch}_${random.nextInt(1000)}',
        targetItem: selectedItems.first,
        customerName: partyCustomer['name']!,
        customerAvatar: partyCustomer['avatar']!,
        totalSeconds: duration,
        remainingSeconds: duration,
        isPartyTray: true,
        partyItems: selectedItems,
        partyCompletedItems: List<bool>.filled(selectedItems.length, false),
      );
    }

    final item = items[random.nextInt(items.length)];

    // %18 İhtimalle VIP Gurme Müşteri Gelir!
    final bool isVipOrder = random.nextDouble() < 0.18;
    final customer = isVipOrder
        ? vipCustomerPool[random.nextInt(vipCustomerPool.length)]
        : customerPool[random.nextInt(customerPool.length)];

    // Seviyeye göre dinamik müşteri sabır süresi
    double baseSeconds = 24.0;
    if (item.level >= 5) {
      baseSeconds = 46.0; // Seviye 5: 44 - 48 sn
    } else if (item.level == 4) {
      baseSeconds = 38.0; // Seviye 4: 36 - 42 sn
    } else if (item.level == 3) {
      baseSeconds = 30.0; // Seviye 3: 28 - 34 sn
    } else if (item.level == 2) {
      baseSeconds = 22.0; // Seviye 2: 20 - 26 sn
    }

    // Sonsuz modda hızlandırma çarpanı
    baseSeconds = max(12.0, baseSeconds / speedMultiplier);

    final duration = baseSeconds + random.nextInt(5) - 2;

    return CustomerOrder(
      id: 'order_${DateTime.now().microsecondsSinceEpoch}_${random.nextInt(1000)}',
      targetItem: item,
      customerName: customer['name']!,
      customerAvatar: customer['avatar']!,
      totalSeconds: duration,
      remainingSeconds: duration,
      isVip: isVipOrder,
    );
  }
}
