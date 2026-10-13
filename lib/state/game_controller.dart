import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../config/game_config.dart';
import '../engines/order_engine.dart';
import '../engines/score_engine.dart';
import '../engines/spawn_engine.dart';
import '../models/item_model.dart';
import '../models/level_model.dart';
import '../models/order_model.dart';
import '../models/recipe_model.dart';
import '../models/skin_model.dart';
import '../services/save_service.dart';
import '../services/sound_service.dart';

/// Ekranda beliren uçuşan puan ve uyarı efektleri
class FloatingEvent {
  final String id;
  final String text;
  final Color color;
  final IconData? icon;
  final Offset position;
  final int durationMs;

  FloatingEvent({
    required this.id,
    required this.text,
    required this.color,
    this.icon,
    required this.position,
    this.durationMs = 1400,
  });
}

/// İki kart birleştiğinde tetiklenen parçacık/ışıma efekti
class MergeEffectEvent {
  final int slotIndex;
  final GameItem resultItem;

  MergeEffectEvent({required this.slotIndex, required this.resultItem});
}

/// Yemeğin müşteriye uçarak teslim edilme animasyonu efekti
class DeliveryFlyEvent {
  final String id;
  final String emoji;
  final Offset startOffset;
  final Offset endOffset;
  final bool isVip;

  DeliveryFlyEvent({
    required this.id,
    required this.emoji,
    required this.startOffset,
    required this.endOffset,
    this.isVip = false,
  });
}

/// Oyunun tüm durumunu, etkileşimlerini ve motor koordinasyonunu yöneten merkezi Controller.
class GameController extends ChangeNotifier {
  static final GameController instance = GameController._internal();
  factory GameController() => instance;

  static const int boardSize = GameConfig.boardSize;
  static const int maxOrders = GameConfig.maxActiveOrders;
  static const double defaultLevelDuration = GameConfig.defaultLevelDuration;

  // --- OYUN TAHTASI & SİPARİŞ LİSTELERİ ---
  final List<GameItem?> _board = List<GameItem?>.filled(boardSize, null);
  final List<CustomerOrder> _orders = [];
  final List<FloatingEvent> _floatingEvents = [];
  final List<DeliveryFlyEvent> _flyEvents = [];

  // --- SEVİYE & İLERLEME ---
  int _currentLevelIndex = 0;
  final Set<int> _unlockedLevels = {0};
  final Map<int, int> _levelStars = {};

  // --- SKOR & İSTATİSTİKLER ---
  int _score = 0;
  int _highScore = 0;
  int _endlessHighScore = 0;
  int _servedCount = 0;
  int _fastDeliveryCount = 0;
  int _failedCount = 0;
  int _streak = 0;
  int _maxStreak = 0;
  int _totalTips = 0;

  double _levelDuration = defaultLevelDuration;
  double _remainingLevelTime = defaultLevelDuration;

  bool _isPlaying = false;
  bool _hasTriggeredVictory = false;

  // --- SONSUZ MOD & GÜÇLENDİRİCİLER (BOOSTERS) ---
  bool _isEndlessMode = false;
  int _endlessLives = 3;

  double _freezeTimerRemaining = 0.0;
  int _freezeBoosters = GameConfig.defaultBoosterCount;
  int _spatulaBoosters = GameConfig.defaultBoosterCount;
  int _broomBoosters = GameConfig.defaultBoosterCount;

  // --- KİŞİSELLEŞTİRME ---
  String _boardSkinId = 'classic';
  String _chefAvatar = '👨‍🍳';

  // --- GİZLİ SİMYA & MÜFETTİŞ BASKINI ---
  final Set<String> _discoveredSecretRecipes = {};
  Recipe? _lastDiscoveredRecipe;
  int _inspectorCountdownTicks = GameConfig.inspectorRaidIntervalTicks;
  bool _isInspectorRaidActive = false;
  String? _inspectorRaidMessage;
  bool? _inspectorCleanPassed;

  Timer? _gameTicker;
  final Random _random = Random();
  MergeEffectEvent? _lastMergeEffect;

  // =================== PUBLIC GETTERS ===================
  List<GameItem?> get board => List.unmodifiable(_board);
  List<CustomerOrder> get orders => List.unmodifiable(_orders);
  List<FloatingEvent> get floatingEvents => List.unmodifiable(_floatingEvents);
  List<DeliveryFlyEvent> get flyEvents => List.unmodifiable(_flyEvents);

  int get currentLevelIndex => _currentLevelIndex;
  GameLevel get currentLevel => GameLevel.allLevels[_currentLevelIndex.clamp(0, GameLevel.allLevels.length - 1)];
  Set<int> get unlockedLevels => Set.unmodifiable(_unlockedLevels);
  Map<int, int> get levelStars => Map.unmodifiable(_levelStars);
  int get highestUnlockedIndex => _unlockedLevels.reduce(max);

  int get score => _score;
  int get highScore => _highScore;
  int get endlessHighScore => _endlessHighScore;
  int get servedCount => _servedCount;
  int get fastDeliveryCount => _fastDeliveryCount;
  int get failedCount => _failedCount;
  int get streak => _streak;
  int get maxStreak => _maxStreak;
  int get totalTips => _totalTips;

  double get levelDuration => _levelDuration;
  double get remainingLevelTime => _remainingLevelTime;
  double get levelTimeRatio => _isEndlessMode ? 1.0 : (_remainingLevelTime / _levelDuration).clamp(0.0, 1.0);

  bool get isPlaying => _isPlaying;
  bool get isLevelComplete => _isEndlessMode ? false : _score >= currentLevel.star1Score;
  bool get hasTriggeredVictory => _hasTriggeredVictory;
  MergeEffectEvent? get lastMergeEffect => _lastMergeEffect;

  bool get isEndlessMode => _isEndlessMode;
  int get endlessLives => _endlessLives;
  bool get isFrozen => _freezeTimerRemaining > 0;
  double get freezeTimerRemaining => _freezeTimerRemaining;
  int get freezeBoosters => _freezeBoosters;
  int get spatulaBoosters => _spatulaBoosters;
  int get broomBoosters => _broomBoosters;

  String get boardSkinId => _boardSkinId;
  BoardSkin get currentBoardSkin => BoardSkin.getById(_boardSkinId);
  String get chefAvatar => _chefAvatar;

  Set<String> get discoveredSecretRecipes => Set.unmodifiable(_discoveredSecretRecipes);
  Recipe? get lastDiscoveredRecipe => _lastDiscoveredRecipe;
  bool get isInspectorRaidActive => _isInspectorRaidActive;
  String? get inspectorRaidMessage => _inspectorRaidMessage;
  bool? get inspectorCleanPassed => _inspectorCleanPassed;
  int get totalStarsEarned => _levelStars.values.fold(0, (a, b) => a + b);

  String get formattedRemainingTime {
    if (_isEndlessMode) return '∞';
    final int totalSec = _remainingLevelTime.ceil();
    final int min = totalSec ~/ 60;
    final int sec = totalSec % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  // =================== CONSTRUCTOR & INITIALIZATION ===================
  GameController._internal() {
    _initLevelState(_currentLevelIndex);
  }

  void loadSavedData() {
    final savedLastLevel = SaveService.getLastLevel();
    _currentLevelIndex = savedLastLevel.clamp(0, GameLevel.allLevels.length - 1);

    final savedUnlocked = SaveService.getUnlockedLevels();
    if (savedUnlocked.isNotEmpty) {
      _unlockedLevels.clear();
      _unlockedLevels.addAll(savedUnlocked);
    }
    _unlockedLevels.add(0); // 1. Bölüm daima açık

    final savedStars = SaveService.getLevelStars();
    _levelStars.clear();
    _levelStars.addAll(savedStars);

    _highScore = SaveService.getHighScore();
    _endlessHighScore = SaveService.getEndlessHighScore();
    _boardSkinId = SaveService.getBoardSkin();
    _chefAvatar = SaveService.getChefAvatar();

    _freezeBoosters = SaveService.getFreezeBoosters();
    _spatulaBoosters = SaveService.getSpatulaBoosters();
    _broomBoosters = SaveService.getBroomBoosters();

    _discoveredSecretRecipes.clear();
    _discoveredSecretRecipes.addAll(SaveService.getDiscoveredSecretRecipes());

    _initLevelState(_currentLevelIndex);
    notifyListeners();
  }

  /// Clears all game data through SaveService and resets controller state to initial defaults
  Future<void> resetAllData({bool keepSettings = true}) async {
    await SaveService.resetAllData(keepSettings: keepSettings);
    loadSavedData();
  }

  void _initLevelState(int levelIndex) {
    _isEndlessMode = false;
    _currentLevelIndex = levelIndex.clamp(0, GameLevel.allLevels.length - 1);
    _board.fillRange(0, boardSize, null);
    _orders.clear();
    _floatingEvents.clear();
    _flyEvents.clear();
    _score = 0;
    _servedCount = 0;
    _fastDeliveryCount = 0;
    _failedCount = 0;
    _streak = 0;
    _maxStreak = 0;
    _totalTips = 0;
    _freezeTimerRemaining = 0.0;
    _inspectorCountdownTicks = GameConfig.inspectorRaidIntervalTicks;
    _isInspectorRaidActive = false;
    _levelDuration = currentLevel.durationSeconds.toDouble();
    _remainingLevelTime = _levelDuration;
    _hasTriggeredVictory = false;

    // Seviye başlangıç kartlarını yerleştir
    final initialItems = currentLevel.initialBoardItems;
    for (int i = 0; i < initialItems.length && i < boardSize; i++) {
      _board[i] = initialItems[i];
    }

    _ensureOrders();
  }

  void startEndlessMode() {
    _isEndlessMode = true;
    _endlessLives = 3;
    _board.fillRange(0, boardSize, null);
    _orders.clear();
    _floatingEvents.clear();
    _flyEvents.clear();
    _score = 0;
    _servedCount = 0;
    _fastDeliveryCount = 0;
    _failedCount = 0;
    _streak = 0;
    _maxStreak = 0;
    _totalTips = 0;
    _freezeTimerRemaining = 0.0;
    _inspectorCountdownTicks = GameConfig.inspectorRaidIntervalTicks;
    _isInspectorRaidActive = false;
    _levelDuration = 999999.0;
    _remainingLevelTime = 999999.0;
    _hasTriggeredVictory = false;

    _ensureOrders();

    // Sonsuz mod başlangıç malzemelerini aktif siparişlerin gereksinimlerine göre yerleştir
    final starters = SpawnEngine.getEndlessStarters(_orders);
    for (int i = 0; i < starters.length && i < 6 && i < boardSize; i++) {
      _board[i] = starters[i];
    }

    resumeGame();
  }

  void setItemAt(int index, GameItem? item) {
    if (index >= 0 && index < boardSize) {
      _board[index] = item;
      notifyListeners();
    }
  }

  @visibleForTesting
  void setOrdersForTesting(List<CustomerOrder> testOrders) {
    _orders.clear();
    _orders.addAll(testOrders);
    notifyListeners();
  }

  void setBoardSkin(String skinId) {
    _boardSkinId = skinId;
    SaveService.saveBoardSkin(skinId);
    notifyListeners();
  }

  void setChefAvatar(String avatar) {
    _chefAvatar = avatar;
    SaveService.saveChefAvatar(avatar);
    notifyListeners();
  }

  void clearLastDiscoveredRecipe() {
    _lastDiscoveredRecipe = null;
    notifyListeners();
  }

  void dismissInspectorRaid() {
    _isInspectorRaidActive = false;
    notifyListeners();
  }

  // =================== GÜÇLENDİRİCİLER (BOOSTERS) ===================
  /// ❄️ Zamanı 10 saniyeliğine dondurur
  void useFreezeBooster() {
    if (_freezeBoosters <= 0 || _freezeTimerRemaining > 0) return;
    _freezeBoosters--;
    _freezeTimerRemaining = GameConfig.freezeBoosterDuration;
    SaveService.saveFreezeBoosters(_freezeBoosters);
    SoundService.playNormalDelivery();

    _addFloatingEvent(
      text: '❄️ ZAMAN DONDU! (10 sn)',
      color: Colors.cyanAccent.shade700,
      icon: Icons.ac_unit_rounded,
      position: const Offset(180, 200),
    );
    notifyListeners();
  }

  /// 🪄 Sihirli Şef: Tahtadaki uygun bir malzemeyi aktif sipariş yemeğine dönüştürür
  void useSpatulaBooster() {
    if (_spatulaBoosters <= 0) return;
    final activeOrders = _orders.where((o) => !o.isCompleted && !o.isExpired).toList();
    if (activeOrders.isEmpty) return;

    final targetItem = activeOrders.first.targetItem;

    int targetSlot = -1;
    for (int i = 0; i < boardSize; i++) {
      if (_board[i] == null || _board[i]!.category == ItemCategory.raw || _board[i] == GameItem.ruinedFood) {
        targetSlot = i;
        break;
      }
    }
    if (targetSlot == -1) targetSlot = 0;

    _spatulaBoosters--;
    SaveService.saveSpatulaBoosters(_spatulaBoosters);

    _board[targetSlot] = targetItem;
    SoundService.playFastDelivery();

    _addFloatingEvent(
      text: '🪄 SİHİRLİ ŞEF: ${targetItem.emoji} ${targetItem.name}!',
      color: Colors.amber.shade900,
      icon: Icons.auto_awesome,
      position: const Offset(160, 260),
    );
    notifyListeners();
  }

  /// 🌪️ Mutfak Süpürgesi: Tahtadaki tüm malzemeleri ve çöpleri anında süpürüp temizler
  void useBroomBooster() {
    if (_broomBoosters <= 0) return;
    int clearedCount = 0;
    for (int i = 0; i < boardSize; i++) {
      if (_board[i] != null) {
        _board[i] = null;
        clearedCount++;
      }
    }

    _broomBoosters--;
    SaveService.saveBroomBoosters(_broomBoosters);
    SoundService.playTrash();

    _addFloatingEvent(
      text: clearedCount > 0 ? '🌪️ $clearedCount MALZEME SÜPÜRÜLDÜ!' : '🌪️ TAHTA PIRIL PIRIL!',
      color: Colors.teal,
      icon: Icons.cleaning_services_rounded,
      position: const Offset(180, 300),
    );
    notifyListeners();
  }

  void addFreezeBoosters(int count) {
    _freezeBoosters += count;
    SaveService.saveFreezeBoosters(_freezeBoosters);
    notifyListeners();
  }

  void addSpatulaBoosters(int count) {
    _spatulaBoosters += count;
    SaveService.saveSpatulaBoosters(_spatulaBoosters);
    notifyListeners();
  }

  void addBroomBoosters(int count) {
    _broomBoosters += count;
    SaveService.saveBroomBoosters(_broomBoosters);
    notifyListeners();
  }

  void addBonusScore(int points) {
    _score += points;
    _updateHighScore();
    _addFloatingEvent(
      text: '⭐ +$points PUAN!',
      color: Colors.amber.shade800,
      icon: Icons.stars_rounded,
      position: const Offset(180, 240),
    );
    notifyListeners();
  }

  void claimDailyReward({
    int freeze = 0,
    int spatula = 0,
    int broom = 0,
    int score = 0,
    String? title,
  }) {
    if (freeze > 0) addFreezeBoosters(freeze);
    if (spatula > 0) addSpatulaBoosters(spatula);
    if (broom > 0) addBroomBoosters(broom);
    if (score > 0) addBonusScore(score);
    SaveService.markDailyWheelSpun();
    SoundService.playFastDelivery();
    notifyListeners();
  }

  // =================== OYUN DÖNGÜSÜ & ZAMANLAYICI ===================
  void resumeGame() {
    _isPlaying = true;
    SoundService.resumeBgm();
    _startTicker();
    notifyListeners();
  }

  void pauseGame() {
    _isPlaying = false;
    SoundService.pauseBgm();
    _gameTicker?.cancel();
    _gameTicker = null;
    notifyListeners();
  }

  void setLevel(int levelIndex) {
    if (levelIndex >= 0 && levelIndex < GameLevel.allLevels.length) {
      _initLevelState(levelIndex);
      SaveService.saveLastLevel(_currentLevelIndex);
      resumeGame();
    }
  }

  void nextLevel() {
    if (_currentLevelIndex + 1 < GameLevel.allLevels.length) {
      _unlockedLevels.add(_currentLevelIndex + 1);
      _initLevelState(_currentLevelIndex + 1);
    } else {
      _initLevelState(_currentLevelIndex);
    }
    SaveService.saveLastLevel(_currentLevelIndex);
    SaveService.saveUnlockedLevels(_unlockedLevels);
    resumeGame();
  }

  void _startTicker() {
    _gameTicker?.cancel();
    _gameTicker = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!_isPlaying) return;

      bool stateChanged = false;

      // 1. Dondurma (Freeze) geri sayımı
      if (_freezeTimerRemaining > 0) {
        _freezeTimerRemaining = max(0.0, _freezeTimerRemaining - 0.10);
        stateChanged = true;
      }

      // 2. Müfettiş Baskını Geri Sayımı
      if (_freezeTimerRemaining <= 0) {
        _inspectorCountdownTicks--;
        if (_inspectorCountdownTicks <= 0) {
          _inspectorCountdownTicks = GameConfig.inspectorRaidIntervalTicks + _random.nextInt(100);
          triggerInspectorRaid();
          stateChanged = true;
        }
      }

      // 3. Bölüm süresi geri sayımı
      if (!_isEndlessMode && _freezeTimerRemaining <= 0) {
        _remainingLevelTime -= 0.10;
        SoundService.updateTempoForRemainingSeconds(_remainingLevelTime);
        stateChanged = true;

        if (_remainingLevelTime <= 0) {
          _remainingLevelTime = 0;
          _concludeLevel();
          return;
        }
      }

      // 4. Sipariş sabır süreleri (OrderEngine ile yönetim)
      if (_freezeTimerRemaining <= 0) {
        final expiredOrders = OrderEngine.tickOrders(
          orders: _orders,
          deltaSeconds: 0.10,
          isFrozen: _freezeTimerRemaining > 0,
        );

        for (final expired in expiredOrders) {
          _handleOrderTimeout(expired);
          stateChanged = true;
        }
      }

      if (stateChanged) {
        notifyListeners();
      }
    });
  }

  void _handleOrderTimeout(CustomerOrder order) {
    _failedCount++;
    _streak = 0;
    _score = max(0, _score - GameConfig.orderTimeoutPenalty);
    SoundService.playTimeout();

    if (_isEndlessMode) {
      _endlessLives--;
      if (_endlessLives <= 0) {
        _concludeLevel();
        return;
      }
    }

    _addFloatingEvent(
      text: _isEndlessMode
          ? '💔 Süre Doldu! Kalan Can: $_endlessLives'
          : '-${GameConfig.orderTimeoutPenalty} 💔 Süre Doldu! Seri Bozuldu',
      color: Colors.redAccent,
      icon: Icons.cancel_outlined,
      position: const Offset(200, 140),
    );

    Timer(const Duration(milliseconds: 1200), () {
      _orders.removeWhere((o) => o.id == order.id);
      _ensureOrders();
      notifyListeners();
    });
  }

  void _ensureOrders() {
    final pool = _isEndlessMode ? GameItem.orderPool : currentLevel.orderPool;
    final speedMultiplier = _isEndlessMode ? 1.0 + (_score / 2000.0) : 1.0;
    OrderEngine.ensureOrderSlots(
      currentOrders: _orders,
      pool: pool,
      speedMultiplier: speedMultiplier,
    );
  }

  // =================== MALZEME ÇIKARMA & BİRLEŞTİRME ===================
  /// Kilerden akıllı ağırlıklı hammadde çıkarır
  bool spawnIngredient() {
    final emptyIndices = <int>[];
    for (int i = 0; i < boardSize; i++) {
      if (_board[i] == null) {
        emptyIndices.add(i);
      }
    }

    if (emptyIndices.isEmpty) {
      _addFloatingEvent(
        text: '⚠️ Tezgâh Dolu!',
        color: Colors.red,
        icon: Icons.warning_amber_rounded,
        position: const Offset(180, 320),
      );
      SoundService.playTimeout();
      return false;
    }

    final randomItem = SpawnEngine.selectWeightedSpawnItem(
      orders: _orders,
      board: _board,
      levelRawPool: currentLevel.validRawPool,
      isEndlessMode: _isEndlessMode,
      fallbackOrderPool: currentLevel.orderPool,
      random: _random,
    );

    final spawnIndex = emptyIndices.first;
    _board[spawnIndex] = randomItem;

    SoundService.playSpawn();
    notifyListeners();
    return true;
  }

  /// İki yuvadaki kartı birleştirir (Merge)
  bool mergeSlots(int fromIndex, int toIndex) {
    if (fromIndex == toIndex) return false;
    if (fromIndex < 0 || fromIndex >= boardSize) return false;
    if (toIndex < 0 || toIndex >= boardSize) return false;

    final itemA = _board[fromIndex];
    final itemB = _board[toIndex];

    if (itemA == null) return false;

    // Boş yuvaya taşıma
    if (itemB == null) {
      _board[toIndex] = itemA;
      _board[fromIndex] = null;
      SoundService.playMerge();
      notifyListeners();
      return true;
    }

    // Tarif eşleşmesini kontrol et
    final recipe = Recipe.findRecipe(itemA.code, itemB.code);

    if (recipe != null) {
      final result = recipe.result;
      _board[toIndex] = result;
      _board[fromIndex] = null;

      _lastMergeEffect = MergeEffectEvent(slotIndex: toIndex, resultItem: result);
      SoundService.playMerge();

      // Gizli Simya Tarifi Kontrolü
      if (recipe.isSecret) {
        final bool isFirstTime = !_discoveredSecretRecipes.contains(result.code);
        if (isFirstTime) {
          _discoveredSecretRecipes.add(result.code);
          SaveService.saveDiscoveredSecretRecipes(_discoveredSecretRecipes);
          _score += 150;
          _lastDiscoveredRecipe = recipe;
          SoundService.playFastDelivery();

          _addFloatingEvent(
            text: '🎉 YENİ GİZLİ SİMYA! ${result.name} (+150 P)',
            color: Colors.purple.shade800,
            icon: Icons.auto_awesome,
            position: Offset(150 + (toIndex % 4) * 50.0, 300 + (toIndex ~/ 4) * 60.0),
          );
        } else {
          _addFloatingEvent(
            text: '🧪 ${result.name} (Gizli Simya)',
            color: Colors.amber.shade900,
            icon: Icons.auto_awesome,
            position: Offset(150 + (toIndex % 4) * 50.0, 300 + (toIndex ~/ 4) * 60.0),
          );
        }
      } else {
        _addFloatingEvent(
          text: '✨ ${result.name}!',
          color: result.primaryColor,
          icon: Icons.star_rounded,
          position: Offset(150 + (toIndex % 4) * 50.0, 300 + (toIndex ~/ 4) * 60.0),
        );
      }

      notifyListeners();
      return true;
    }

    // Uyumsuz birleştirme -> Hatalı Karışım (Çöp)
    _board[toIndex] = GameItem.ruinedFood;
    _board[fromIndex] = null;

    SoundService.playTimeout();
    _addFloatingEvent(
      text: '💨 Hatalı Karışım! (Çöp kovasına at)',
      color: Colors.brown.shade800,
      icon: Icons.cloud_off_rounded,
      position: Offset(150 + (toIndex % 4) * 50.0, 300 + (toIndex ~/ 4) * 60.0),
    );

    notifyListeners();
    return true;
  }

  // =================== SİPARİŞ TESLİMATI ===================
  /// Belirli bir sipariş ID'sine kart teslim eder
  bool deliverOrder(int fromBoardIndex, String orderId) {
    if (fromBoardIndex < 0 || fromBoardIndex >= boardSize) return false;
    final item = _board[fromBoardIndex];
    if (item == null) return false;

    final orderIndex = _orders.indexWhere((o) => o.id == orderId);
    if (orderIndex == -1) return false;

    final order = _orders[orderIndex];
    if (order.isCompleted || order.isExpired) return false;

    // 1. Parti / Catering Tepsisi Teslimatı
    if (order.isPartyTray) {
      final bool delivered = order.tryDeliverPartyItem(item.code);
      if (delivered) {
        _board[fromBoardIndex] = null;
        _triggerDeliveryFly(
          emoji: item.emoji,
          fromIndex: fromBoardIndex,
          isVip: true,
        );

        if (order.isPartyFullyCompleted) {
          final basePoints = order.calculateBasePoints();
          _servedCount++;
          _streak++;
          if (_streak > _maxStreak) _maxStreak = _streak;

          int tipBonus = _calculateStreakTipBonus(_streak, isVip: false);
          _totalTips += tipBonus;

          final totalPoints = basePoints + tipBonus;
          _score += totalPoints;
          _updateHighScore();

          SoundService.playFastDelivery();
          _addFloatingEvent(
            text: '🍱 DEV CATERİNG PARTİSİ TAMAMLANDI!\n🎉 +$totalPoints PUAN DEV ŞÖLEN!',
            color: Colors.purple.shade900,
            icon: Icons.celebration_rounded,
            position: const Offset(160, 150),
          );

          Timer(const Duration(milliseconds: 1200), () {
            _orders.removeWhere((o) => o.id == order.id);
            _ensureOrders();
            notifyListeners();
          });
        } else {
          SoundService.playNormalDelivery();
          final doneCount = order.partyCompletedItems.where((c) => c).length;
          _addFloatingEvent(
            text: '🍱 PARTİ TEPSİSİNE EKLENDİ! ($doneCount/${order.partyItems.length}) 🥢',
            color: Colors.deepOrange.shade800,
            icon: Icons.restaurant_rounded,
            position: const Offset(180, 160),
          );
        }

        notifyListeners();
        return true;
      } else {
        // Hatalı parti teslimatı
        order.remainingSeconds = max(0.0, order.remainingSeconds - 5.0);
        _streak = 0;
        _addFloatingEvent(
          text: '❌ Bu yemek parti tepsisinde yok! (-5sn)',
          color: Colors.red,
          icon: Icons.error_outline,
          position: const Offset(180, 160),
        );
        SoundService.playTimeout();
        if (order.remainingSeconds <= 0) {
          order.isExpired = true;
          _handleOrderTimeout(order);
        }
        notifyListeners();
        return false;
      }
    }

    // 2. Standart veya VIP Tekli Sipariş Teslimatı
    if (item.code == order.targetItem.code) {
      final basePoints = order.calculateBasePoints();
      _servedCount++;
      _streak++;
      if (_streak > _maxStreak) _maxStreak = _streak;

      final tipBonus = _calculateStreakTipBonus(_streak, isVip: order.isVip);
      _totalTips += tipBonus;

      final totalPoints = basePoints + tipBonus;
      _score += totalPoints;
      _updateHighScore();

      order.isCompleted = true;
      _board[fromBoardIndex] = null;

      _triggerDeliveryFly(
        emoji: item.emoji,
        fromIndex: fromBoardIndex,
        isVip: order.isVip,
      );

      if (order.isFastDelivery) {
        _fastDeliveryCount++;
        SoundService.playFastDelivery();
      } else {
        SoundService.playNormalDelivery();
      }

      String message = order.isVip
          ? '👑 VIP GURME! +$basePoints P (3x)'
          : (order.isFastDelivery
              ? '⚡ HIZLI TESLİMAT! +$basePoints P'
              : '⭐ ZAMANINDA! +$basePoints P');

      if (tipBonus > 0) {
        message += '\n💵 +$tipBonus P BAHŞİŞ (🔥x$_streak)';
      }

      _addFloatingEvent(
        text: message,
        color: order.isVip
            ? Colors.amber.shade900
            : (tipBonus > 0 ? const Color(0xFFFF8F00) : Colors.green),
        icon: order.isVip
            ? Icons.workspace_premium_rounded
            : (tipBonus > 0 ? Icons.local_fire_department : Icons.check_circle_outline),
        position: const Offset(180, 160),
      );

      Timer(const Duration(milliseconds: 1000), () {
        _orders.removeWhere((o) => o.id == order.id);
        _ensureOrders();
        notifyListeners();
      });

      notifyListeners();
      return true;
    } else {
      order.remainingSeconds = max(0.0, order.remainingSeconds - 5.0);
      _streak = 0;

      _addFloatingEvent(
        text: '❌ Yanlış Yemek! (-5sn ⏱️ & Seri Bozuldu 🔥)',
        color: Colors.red,
        icon: Icons.error_outline,
        position: const Offset(180, 160),
      );
      SoundService.playTimeout();

      if (order.remainingSeconds <= 0) {
        order.isExpired = true;
        _handleOrderTimeout(order);
      }

      notifyListeners();
      return false;
    }
  }

  /// Herhangi bir eşleşen siparişe teslim eder, eşleşme yoksa ceza uygular
  bool deliverToMatchingOrPenalize(int fromBoardIndex) {
    if (fromBoardIndex < 0 || fromBoardIndex >= boardSize) return false;
    final item = _board[fromBoardIndex];
    if (item == null) return false;

    // Yukarıdaki siparişleri soldan sağa sırayla kontrol et:
    for (final order in _orders) {
      if (order.isCompleted || order.isExpired) continue;

      if (order.isPartyTray) {
        // Parti tepsisinde henüz teslim edilmemiş eşleşen ürün var mı?
        for (int i = 0; i < order.partyItems.length; i++) {
          if (!order.partyCompletedItems[i] && order.partyItems[i].code == item.code) {
            return deliverOrder(fromBoardIndex, order.id);
          }
        }
      } else {
        // Tekli veya VIP sipariş eşleşmesi
        if (order.targetItem.code == item.code) {
          return deliverOrder(fromBoardIndex, order.id);
        }
      }
    }

    // Eşleşme bulunamadı -> Ceza uygula
    _streak = 0;
    final activeOrders = _orders.where((o) => !o.isCompleted && !o.isExpired).toList();
    if (activeOrders.isNotEmpty) {
      final targetOrder = activeOrders.first;
      targetOrder.remainingSeconds = max(0.0, targetOrder.remainingSeconds - 5.0);
      if (targetOrder.remainingSeconds <= 0) {
        targetOrder.isExpired = true;
        _handleOrderTimeout(targetOrder);
      }
    }

    _addFloatingEvent(
      text: '❌ İstenmeyen Yemek! (-5sn ⏱️ & Seri Bozuldu 🔥)',
      color: Colors.red,
      icon: Icons.warning_amber_rounded,
      position: const Offset(180, 160),
    );
    SoundService.playTimeout();
    notifyListeners();
    return false;
  }

  int _calculateStreakTipBonus(int streakCount, {required bool isVip}) {
    if (streakCount >= 10) return isVip ? 75 : 45;
    if (streakCount >= 5) return isVip ? 40 : 25;
    if (streakCount >= 3) return isVip ? 20 : 12;
    return 0;
  }

  void _triggerDeliveryFly({
    required String emoji,
    required int fromIndex,
    bool isVip = false,
  }) {
    final startX = 60.0 + (fromIndex % 4) * 75.0;
    final startY = 380.0 + (fromIndex ~/ 4) * 75.0;
    final flyEvent = DeliveryFlyEvent(
      id: 'fly_${DateTime.now().microsecondsSinceEpoch}',
      emoji: emoji,
      startOffset: Offset(startX, startY),
      endOffset: const Offset(180, 90),
      isVip: isVip,
    );
    _flyEvents.add(flyEvent);

    Timer(const Duration(milliseconds: 700), () {
      _flyEvents.removeWhere((e) => e.id == flyEvent.id);
      notifyListeners();
    });
  }

  // =================== MÜFETTİŞ BASKINI & TEFTİŞ ===================
  void triggerInspectorRaid() {
    if (!_isPlaying || _hasTriggeredVictory) return;

    final ruinedCount = _board.where((item) => item == GameItem.ruinedFood).length;

    if (ruinedCount == 0) {
      _score += 300;
      _inspectorCleanPassed = true;
      _inspectorRaidMessage = 'MÜFETTİŞ BASKINI: MUTFAK PIRIL PIRIL!\n🌟 +300 Temiz Mutfak Bonusu Kazandınız!';
      SoundService.playFastDelivery();

      _addFloatingEvent(
        text: '🕵️‍♂️ MÜFETTİŞ BASKINI: MUTFAK PIRIL PIRIL!\n🌟 +300 P Temiz Mutfak Bonusu!',
        color: Colors.green.shade800,
        icon: Icons.verified_user_rounded,
        position: const Offset(180, 160),
        durationMs: 2500,
      );

      _updateHighScore();
    } else {
      _score = max(0, _score - 150);
      _streak = 0;
      _inspectorCleanPassed = false;
      _inspectorRaidMessage = 'MÜFETTİŞ BASKINI: TEZGÂHTA $ruinedCount ADET ÇÖP VAR!\n⚠️ -150 Hijyen Cezası & Kombo Sıfırlandı!';
      SoundService.playTimeout();

      _addFloatingEvent(
        text: '🕵️‍♂️ MÜFETTİŞ BASKINI: TEZGÂHTA $ruinedCount ÇÖP VAR!\n⚠️ -150 P Hijyen Cezası & Seri Sıfırlandı!',
        color: Colors.red.shade800,
        icon: Icons.gavel_rounded,
        position: const Offset(180, 160),
        durationMs: 2500,
      );
    }

    _isInspectorRaidActive = false;
    notifyListeners();
  }

  void _updateHighScore() {
    if (_isEndlessMode) {
      if (_score > _endlessHighScore) {
        _endlessHighScore = _score;
        SaveService.saveEndlessHighScore(_endlessHighScore);
      }
    } else {
      if (_score > _highScore) {
        _highScore = _score;
        SaveService.saveHighScore(_highScore);
      }
    }
  }

  void _concludeLevel() {
    _hasTriggeredVictory = true;
    pauseGame();
    SoundService.playFastDelivery();

    if (!_isEndlessMode) {
      final stars = currentLevel.calculateStars(_score);
      final prevStars = _levelStars[_currentLevelIndex] ?? 0;
      if (stars > prevStars) {
        _levelStars[_currentLevelIndex] = stars;
        SaveService.saveLevelStars(_levelStars);
      }

      if (_score >= currentLevel.star1Score) {
        if (_currentLevelIndex + 1 < GameLevel.allLevels.length) {
          _unlockedLevels.add(_currentLevelIndex + 1);
          SaveService.saveUnlockedLevels(_unlockedLevels);
        }
      }

      _updateHighScore();
    } else {
      _updateHighScore();
    }

    notifyListeners();
  }

  void trashItem(int index) {
    if (index >= 0 && index < boardSize && _board[index] != null) {
      _board[index] = null;
      SoundService.playTrash();
      _addFloatingEvent(
        text: '🗑️ Çöpe Atıldı',
        color: Colors.grey,
        icon: Icons.delete_outline,
        position: const Offset(200, 520),
      );
      notifyListeners();
    }
  }

  void _addFloatingEvent({
    required String text,
    required Color color,
    IconData? icon,
    required Offset position,
    int durationMs = 1400,
  }) {
    final event = FloatingEvent(
      id: 'event_${DateTime.now().microsecondsSinceEpoch}',
      text: text,
      color: color,
      icon: icon,
      position: position,
      durationMs: durationMs,
    );
    _floatingEvents.add(event);

    Timer(Duration(milliseconds: durationMs), () {
      _floatingEvents.removeWhere((e) => e.id == event.id);
      notifyListeners();
    });
  }

  void restartGame() {
    if (_isEndlessMode) {
      startEndlessMode();
    } else {
      _initLevelState(_currentLevelIndex);
      resumeGame();
    }
  }

  void togglePause() {
    if (_isPlaying) {
      pauseGame();
    } else {
      resumeGame();
    }
  }

  @override
  void dispose() {
    _gameTicker?.cancel();
    super.dispose();
  }
}
