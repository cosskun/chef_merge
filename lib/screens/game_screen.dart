import 'package:flutter/material.dart';
import '../state/game_controller.dart';
import '../services/sound_service.dart';
import '../services/save_service.dart';
import '../widgets/order_card.dart';
import '../widgets/board_grid.dart';
import '../widgets/recipe_book_dialog.dart';
import '../widgets/level_select_dialog.dart';
import '../widgets/level_victory_dialog.dart';
import '../widgets/music_select_dialog.dart';
import '../widgets/floating_overlay.dart';
import '../widgets/fire_combo_overlay.dart';
import '../widgets/custom_skin_dialog.dart';
import '../widgets/daily_wheel_dialog.dart';
import '../models/recipe_model.dart';
import '../models/item_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late GameController _controller;
  late AnimationController _pulseController;
  bool _victoryDialogShowing = false;

  @override
  void initState() {
    super.initState();
    SoundService.init();
    if (SoundService.musicEnabled && !SoundService.isPlayingBgm) {
      SoundService.playBgm();
    }
    _controller = GameController.instance;
    _controller.resumeGame();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _controller.addListener(_checkVictory);
  }

  void _checkVictory() {
    if (_controller.hasTriggeredVictory && !_victoryDialogShowing) {
      _victoryDialogShowing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => LevelVictoryDialog(controller: _controller),
        ).then((_) {
          _victoryDialogShowing = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_checkVictory);
    _controller.pauseGame();
    _pulseController.dispose();
    super.dispose();
  }

  void _openRecipeBook() {
    final wasPlaying = _controller.isPlaying;
    if (wasPlaying) _controller.togglePause();
    showDialog(
      context: context,
      builder: (context) => const RecipeBookDialog(),
    ).then((_) {
      if (wasPlaying && !_controller.hasTriggeredVictory) {
        _controller.togglePause();
      }
    });
  }

  void _openMusicSelect() {
    final wasPlaying = _controller.isPlaying;
    if (wasPlaying) _controller.togglePause();
    showDialog(
      context: context,
      builder: (context) => const MusicSelectDialog(),
    ).then((_) {
      if (wasPlaying && !_controller.hasTriggeredVictory) {
        _controller.togglePause();
      }
      setState(() {});
    });
  }

  void _openLevelSelect() {
    final wasPlaying = _controller.isPlaying;
    if (wasPlaying) _controller.togglePause();
    showDialog(
      context: context,
      builder: (context) => LevelSelectDialog(controller: _controller),
    ).then((_) {
      if (wasPlaying && !_controller.hasTriggeredVictory) {
        _controller.togglePause();
      }
    });
  }

  void _openCustomSkins() {
    final wasPlaying = _controller.isPlaying;
    if (wasPlaying) _controller.togglePause();
    showDialog(
      context: context,
      builder: (context) => CustomSkinDialog(controller: _controller),
    ).then((_) {
      if (wasPlaying && !_controller.hasTriggeredVictory) {
        _controller.togglePause();
      }
    });
  }

  void _openDailyWheel() {
    final wasPlaying = _controller.isPlaying;
    if (wasPlaying) _controller.togglePause();
    showDialog(
      context: context,
      builder: (context) => DailyWheelDialog(controller: _controller),
    ).then((_) {
      if (wasPlaying && !_controller.hasTriggeredVictory) {
        _controller.togglePause();
      }
      setState(() {});
    });
  }

  Future<bool> _confirmExitGame() async {
    final wasPlaying = _controller.isPlaying;
    if (wasPlaying) {
      _controller.togglePause();
    }

    final isEndless = _controller.isEndlessMode;
    final level = _controller.currentLevel;

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        backgroundColor: const Color(0xFFFFFDF8),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('⏸️', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 10),
                Text(
                  'Oyun Duraklatıldı',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.brown.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isEndless ? Colors.purple.shade50 : Colors.amber.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isEndless ? Colors.purple.shade200 : Colors.amber.shade300,
                  width: 1.2,
                ),
              ),
              child: isEndless
                  ? Row(
                      children: [
                        const Text('♾️', style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sonsuz Şef Modu',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF4A148C),
                                ),
                              ),
                              Text(
                                'Mevcut Puan: ${_controller.score}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.purple.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(level.icon, style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bölüm ${level.number}: ${level.title}',
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF3E2723),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${level.categoryName} • Hedef: ${level.targetScore} Puan',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown.shade700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Recipe Book Quick Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 42),
                foregroundColor: Colors.brown.shade800,
                side: BorderSide(color: Colors.orange.shade200),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Text('📖', style: TextStyle(fontSize: 16)),
              label: const Text('Tarif Kitabını İncele', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                showDialog(
                  context: ctx,
                  builder: (context) => const RecipeBookDialog(),
                );
              },
            ),
            const SizedBox(height: 8),

            // Restart Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 42),
                foregroundColor: Colors.deepOrange.shade800,
                side: BorderSide(color: Colors.deepOrange.shade200),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Bölümü Yeniden Başlat', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(ctx).pop('restart');
              },
            ),
            const SizedBox(height: 8),

            // Master Sound & Music Toggle
            StatefulBuilder(
              builder: (ctx2, setDialogState) {
                final isMuted = SoundService.isMuted;
                return OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 42),
                    foregroundColor: isMuted ? Colors.red.shade700 : Colors.brown.shade800,
                    side: BorderSide(
                      color: isMuted ? Colors.red.shade200 : Colors.orange.shade200,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(
                    isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                    size: 18,
                    color: isMuted ? Colors.red.shade700 : Colors.deepOrange,
                  ),
                  label: Text(
                    isMuted ? 'Oyun Sesleri: Kapalı (Aç)' : 'Oyun Sesleri: Açık (Kapat)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await SoundService.toggleMasterAudio();
                    setDialogState(() {});
                    if (mounted) setState(() {});
                  },
                );
              },
            ),
            const SizedBox(height: 8),

            // Exit Button
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 42),
                foregroundColor: Colors.red.shade700,
                side: BorderSide(color: Colors.red.shade200),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.home_rounded, size: 18),
              label: const Text('Ana Menüye Dön', style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(ctx).pop('exit');
              },
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7043),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
              ),
              onPressed: () => Navigator.of(ctx).pop('resume'),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow_rounded, size: 20),
                  SizedBox(width: 4),
                  Text('Oyuna Devam Et', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (result == 'exit') {
      if (mounted) {
        Navigator.of(context).pop();
      }
      return true;
    } else if (result == 'restart') {
      _controller.restartGame();
      return false;
    } else {
      if (wasPlaying && !_controller.hasTriggeredVictory && !_controller.isPlaying) {
        _controller.togglePause();
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final level = _controller.currentLevel;
        final target = level.targetScore;
        final progressRatio = (_controller.score / target).clamp(0.0, 1.0);

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            await _confirmExitGame();
          },
          child: Scaffold(
            backgroundColor: const Color(0xFFFBF7F0),
            body: Stack(
            children: [
              // 1. Background Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        _controller.isEndlessMode
                            ? const Color(0xFFFFF3E0)
                            : level.themeColor.withValues(alpha: 0.15),
                        const Color(0xFFFFF9E6),
                        const Color(0xFFFBE9E7),
                      ],
                    ),
                  ),
                ),
              ),

              // 2. Responsive Mobile Frame container
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // 1. Top Header Bar (Level, Score, Actions)
                        _buildHeader(),

                        // 2. Level Timer & Target Progress Bar / Endless Lives
                        _buildLevelTimerAndProgressBar(progressRatio),

                        const SizedBox(height: 3),

                        // 3. Active Orders Section (Max 3 + VIP Support)
                        _buildOrdersSection(),

                        const SizedBox(height: 4),

                        // 4. Action Zones (Sipariş Teslim Yeri & Çöp Kovası)
                        _buildActionZones(),

                        const SizedBox(height: 4),

                        // 5. Board (4x4 Grid with Dynamic Skin)
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: BoardGrid(controller: _controller),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // 6. Boosters / Power-Ups Bar (❄️ 🪄 🌪️)
                        _buildBoostersBar(),

                        const SizedBox(height: 4),

                        // 7. Bottom Controls (Kiler / Spawner & Stats)
                        _buildBottomControls(),
                      ],
                    ),
                  ),
                ),
              ),

              // 3. 🔥 Kombo Ateşi & Uçan Tabak Animasyon Katmanı
              FireComboOverlay(controller: _controller),

              // 4. Floating Text & Particles Overlay
              FloatingOverlay(events: _controller.floatingEvents),

              // 5. 🧪 Gizli Simya Tarifi Keşfi Kutlama Katmanı
              if (_controller.lastDiscoveredRecipe != null)
                _buildSecretDiscoveryOverlay(_controller.lastDiscoveredRecipe!),
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange.shade200, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat('🍲 Servis', '${_controller.servedCount}', Colors.blue.shade700),
              const SizedBox(width: 6),
              _buildMiniStat('💵 Bahşiş', '+${_controller.totalTips} P', Colors.green.shade800),
              const SizedBox(width: 6),
              _buildMiniStat('🔥 Seri', 'x${_controller.streak}', Colors.deepOrange),
              const SizedBox(width: 6),
              _buildMiniStat('💔 Kaçan', '${_controller.failedCount}', Colors.red.shade700),
              const SizedBox(width: 8),

              // Score Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A65), Color(0xFFFF5722)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  '🏆 ${_controller.score} P',
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 6),

              // Volume / Master Mute Toggle
              InkWell(
                onTap: () async {
                  await SoundService.toggleMasterAudio();
                  if (mounted) setState(() {});
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: !SoundService.isMuted ? Colors.orange.shade50 : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: !SoundService.isMuted ? Colors.orange.shade200 : Colors.red.shade200,
                    ),
                  ),
                  child: Icon(
                    !SoundService.isMuted ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                    color: !SoundService.isMuted ? Colors.brown : Colors.red.shade700,
                    size: 17,
                  ),
                ),
              ),

              const SizedBox(width: 6),

              // Pause / Exit Button
              InkWell(
                onTap: () => _confirmExitGame(),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: const Icon(Icons.pause_rounded, color: Colors.brown, size: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelTimerAndProgressBar(double progress) {
    final level = _controller.currentLevel;
    final isLowTime = !_controller.isEndlessMode && _controller.remainingLevelTime <= 30.0;
    final isFrozen = _controller.isFrozen;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isFrozen
              ? Colors.cyan.shade50
              : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isFrozen
                ? Colors.cyan
                : (isLowTime ? Colors.redAccent : level.themeColor.withValues(alpha: 0.3)),
            width: (isFrozen || isLowTime) ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 3-Minute Session Countdown Timer or Endless Mode Lives
                  Row(
                    children: [
                      if (_controller.isEndlessMode) ...[
                        const Text('❤️ Can: ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red)),
                        Text(
                          '${_controller.endlessLives} / 3',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.red),
                        ),
                      ] else ...[
                        Icon(
                          isFrozen ? Icons.ac_unit_rounded : Icons.timer_outlined,
                          size: 14,
                          color: isFrozen ? Colors.cyan.shade800 : (isLowTime ? Colors.red : Colors.brown.shade800),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isFrozen
                              ? '❄️ BUZ: ${_controller.freezeTimerRemaining.toStringAsFixed(1)}s'
                              : 'Süre: ${_controller.formattedRemainingTime}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: isFrozen
                                ? Colors.cyan.shade900
                                : (isLowTime ? Colors.red : Colors.brown.shade900),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(width: 12),

                  // Active Tips Indicator or Target Indicator
                  if (_controller.streak >= 5)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.amber.shade400, width: 0.8),
                      ),
                      child: Text(
                        '🔥 BAHŞİŞ AKTİF (+10 P)',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w900,
                          color: Colors.brown.shade900,
                        ),
                      ),
                    )
                  else
                    Text(
                      _controller.isEndlessMode
                          ? '🔥 Hız Katmanı: ${(1.0 + (_controller.score / 2000.0)).toStringAsFixed(1)}x'
                          : '🎯 3⭐ Hedef: ${level.targetScore} P',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: level.themeColor,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 2.5),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _controller.levelTimeRatio,
                minHeight: 4,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isFrozen
                      ? Colors.cyan
                      : (isLowTime ? Colors.redAccent : level.themeColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 2, right: 4),
            child: Row(
              children: [
                const Text('🛎️', style: TextStyle(fontSize: 11)),
                const SizedBox(width: 4),
                Text(
                  'Siparişler (${_controller.orders.length}/3)',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.orange.shade200, width: 0.8),
                    ),
                    child: Text(
                      '⭐ 2-5 Lv. • 👑 VIP (3x)',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.brown.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _controller.orders.map((order) {
                return Expanded(
                  child: OrderCard(order: order, controller: _controller),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmUseBooster({
    required String icon,
    required String title,
    required String description,
    required int count,
    required VoidCallback onConfirm,
  }) {
    if (count <= 0) return;

    final wasPlaying = _controller.isPlaying;
    if (wasPlaying) _controller.togglePause();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFFFFFDF8),
        title: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.brown.shade800,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🎒 ', style: TextStyle(fontSize: 13)),
                  Text(
                    'Kalan Stok: $count Adet',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Vazgeç',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            child: const Text(
              'Kullan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ).then((_) {
      if (wasPlaying && !_controller.hasTriggeredVictory && !_controller.isPlaying) {
        _controller.togglePause();
      }
    });
  }

  Widget _buildBoostersBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          // ❄️ 1. Dondur (Buzdolabı Molası)
          Expanded(
            child: _buildBoosterButton(
              icon: '❄️',
              title: 'Dondur (10s)',
              count: _controller.freezeBoosters,
              color: Colors.cyan.shade600,
              bgColor: Colors.cyan.shade50,
              onTap: () => _confirmUseBooster(
                icon: '❄️',
                title: 'Zamanı Dondur',
                description: '10 saniye boyunca müşteri sabırlarını ve bölüm süresini dondurmak istiyor musunuz?',
                count: _controller.freezeBoosters,
                onConfirm: () => _controller.useFreezeBooster(),
              ),
            ),
          ),
          const SizedBox(width: 6),

          // 🪄 2. Sihirli Spatula
          Expanded(
            child: _buildBoosterButton(
              icon: '🪄',
              title: 'Sihirli Şef',
              count: _controller.spatulaBoosters,
              color: Colors.amber.shade800,
              bgColor: Colors.amber.shade50,
              onTap: () => _confirmUseBooster(
                icon: '🪄',
                title: 'Sihirli Şef',
                description: 'Mevcut siparişlerden birini anında hazırlayıp teslim etmek istiyor musunuz?',
                count: _controller.spatulaBoosters,
                onConfirm: () => _controller.useSpatulaBooster(),
              ),
            ),
          ),
          const SizedBox(width: 6),

          // 🌪️ 3. Çöp Süpürgesi
          Expanded(
            child: _buildBoosterButton(
              icon: '🌪️',
              title: 'Süpürge',
              count: _controller.broomBoosters,
              color: Colors.teal.shade700,
              bgColor: Colors.teal.shade50,
              onTap: () => _confirmUseBooster(
                icon: '🌪️',
                title: 'Mutfak Süpürgesi',
                description: 'Tahtadaki tüm malzemeleri ve çöpleri süpürüp tahtayı tamamen temizlemek istiyor musunuz?',
                count: _controller.broomBoosters,
                onConfirm: () => _controller.useBroomBooster(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoosterButton({
    required String icon,
    required String title,
    required int count,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    final bool hasItems = count > 0;

    return InkWell(
      onTap: hasItems ? onTap : null,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: hasItems ? bgColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasItems ? color.withValues(alpha: 0.5) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 4),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: hasItems ? color : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: hasItems ? color : Colors.grey,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$count',
                style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionZones() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          // 1. Central Universal Delivery Zone
          Expanded(
            flex: 3,
            child: DragTarget<int>(
              onWillAcceptWithDetails: (details) => true,
              onAcceptWithDetails: (details) {
                final slotIndex = details.data;
                _controller.deliverToMatchingOrPenalize(slotIndex);
              },
              builder: (context, candidateData, rejectedData) {
                final isHovered = candidateData.isNotEmpty;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 38,
                  decoration: BoxDecoration(
                    color: isHovered ? Colors.green.shade100 : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isHovered ? Colors.green.shade700 : Colors.green.shade300,
                      width: isHovered ? 2 : 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isHovered
                            ? Colors.green.withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.03),
                        blurRadius: 5,
                        offset: const Offset(0, 1.5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('📥', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 5),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Sipariş Teslim Yeri',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 8),

          // 2. Trash / Clear Zone
          Expanded(
            flex: 1,
            child: DragTarget<int>(
              onWillAcceptWithDetails: (details) => true,
              onAcceptWithDetails: (details) {
                _controller.trashItem(details.data);
              },
              builder: (context, candidateData, rejectedData) {
                final isHovered = candidateData.isNotEmpty;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 38,
                  decoration: BoxDecoration(
                    color: isHovered ? Colors.red.shade100 : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isHovered ? Colors.red.shade700 : Colors.red.shade200,
                      width: isHovered ? 2 : 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🗑️', style: TextStyle(fontSize: 13)),
                      const SizedBox(width: 3),
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Çöp Kovası',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF7043),
            foregroundColor: Colors.white,
            elevation: 3,
            shadowColor: Colors.deepOrange.withValues(alpha: 0.35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            _controller.spawnIngredient();
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🍅 🍞 🧀 🍚 🍌', style: TextStyle(fontSize: 14)),
              SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'KİLERDEN MALZEME ÇIKAR',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.touch_app_rounded, size: 17),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 9.5, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }


  Widget _buildSecretDiscoveryOverlay(Recipe recipe) {
    final resultItem = recipe.result;
    final in1 = GameItem.findByCode(recipe.itemACode);
    final in2 = GameItem.findByCode(recipe.itemBCode);

    return Positioned.fill(
      child: Material(
        color: Colors.black.withValues(alpha: 0.65),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2C1654), Color(0xFF4A148C), Color(0xFF311B92)],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.amberAccent, width: 2.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.purpleAccent.withValues(alpha: 0.6),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '🧪 GİZLİ SİMYA KEŞFİ! 🧪',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  resultItem?.emoji ?? '✨',
                  style: const TextStyle(fontSize: 60),
                ),
                const SizedBox(height: 8),
                Text(
                  resultItem?.name ?? 'Gizli Gurme Lezzeti',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${in1?.emoji ?? '?'} + ${in2?.emoji ?? '?'} ➔ ${resultItem?.emoji ?? '?'} ${resultItem?.name ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  resultItem?.description ?? '',
                  style: TextStyle(
                    color: Colors.purple.shade100,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amberAccent.withValues(alpha: 0.8)),
                  ),
                  child: const Text(
                    '+150 Keşif Puanı & Tarif Kitabına Eklendi!',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      foregroundColor: Colors.brown.shade900,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      _controller.clearLastDiscoveredRecipe();
                    },
                    child: const Text(
                      'HARİKA! 🚀',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
