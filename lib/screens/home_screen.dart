import 'package:flutter/material.dart';
import '../state/game_controller.dart';
import '../services/sound_service.dart';
import '../widgets/level_select_dialog.dart';
import '../widgets/leaderboard_dialog.dart';
import '../widgets/recipe_book_dialog.dart';
import '../widgets/music_select_dialog.dart';
import '../widgets/custom_skin_dialog.dart';
import '../widgets/language_select_dialog.dart';
import '../services/localization_service.dart';
import '../widgets/daily_wheel_dialog.dart';
import '../services/save_service.dart';
import '../models/level_model.dart';
import 'game_screen.dart';
import 'tutorial_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late GameController _controller;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    SoundService.init();
    if (SoundService.musicEnabled) {
      SoundService.playBgm();
    }
    _controller = GameController.instance;
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _startGame([int? levelIndex]) {
    if (levelIndex != null) {
      _controller.setLevel(levelIndex);
    } else {
      _controller.setLevel(_controller.currentLevelIndex);
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  void _startEndlessMode() {
    _controller.startEndlessMode();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  void _openTutorial() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const TutorialScreen()),
    );
  }

  void _openLevelSelect() {
    showDialog(
      context: context,
      builder: (context) => LevelSelectDialog(controller: _controller),
    );
  }

  void _openLeaderboard() {
    showDialog(
      context: context,
      builder: (context) => LeaderboardDialog(controller: _controller),
    );
  }

  void _openRecipeBook() {
    showDialog(
      context: context,
      builder: (context) => const RecipeBookDialog(),
    );
  }

  void _openCustomSkins() {
    showDialog(
      context: context,
      builder: (context) => CustomSkinDialog(controller: _controller),
    ).then((_) {
      setState(() {});
    });
  }

  void _openMusicSelect() {
    showDialog(
      context: context,
      builder: (context) => const MusicSelectDialog(),
    ).then((_) {
      setState(() {});
    });
  }

  void _openLanguageSelect() {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectDialog(),
    ).then((_) {
      setState(() {});
    });
  }

  void _openDailyWheel() {
    showDialog(
      context: context,
      builder: (context) => DailyWheelDialog(controller: _controller),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final currentLevel = _controller.currentLevel;
        final stars = _controller.levelStars[_controller.currentLevelIndex] ?? 0;

        return Scaffold(
          backgroundColor: const Color(0xFFFBF7F0),
          body: Stack(
            children: [
              // Background Gradient
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFF3E0),
                        Color(0xFFFFE0B2),
                        Color(0xFFFBE9E7),
                      ],
                    ),
                  ),
                ),
              ),

              // Responsive Mobile Frame
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 460),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SafeArea(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraints.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                        // 1. Top Bar: Quick Stats & Music / Sound / Shop Settings
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            // Stars & High Score pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.orange.shade200),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '⭐ ${_controller.totalStarsEarned}',
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFF8F00),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '🏆 ${_controller.highScore} P',
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                // Language Selection Button
                                InkWell(
                                  onTap: _openLanguageSelect,
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: Colors.orange.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          LocalizationService.currentOption.flag,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          LocalizationService.currentOption.code.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                // Star Shop / Customization Button
                                InkWell(
                                  onTap: _openCustomSkins,
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: Colors.amber.shade300),
                                    ),
                                    child: Row(
                                      children: [
                                        const Text('🎨', style: TextStyle(fontSize: 13)),
                                        const SizedBox(width: 3),
                                        Text(
                                          LocalizationService.tr('shop'),
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                // Music Selection / Settings Button
                                InkWell(
                                  onTap: _openMusicSelect,
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: Colors.orange.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          SoundService.currentTrack.icon,
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          LocalizationService.tr('music'),
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                // Master Audio (Music & Sound) Mute/Unmute
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.all(4),
                                  constraints: const BoxConstraints(),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      side: BorderSide(
                                        color: !SoundService.isMuted
                                            ? Colors.orange.shade200
                                            : Colors.red.shade200,
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    !SoundService.isMuted
                                        ? Icons.volume_up_rounded
                                        : Icons.volume_off_rounded,
                                    color: !SoundService.isMuted
                                        ? Colors.brown.shade800
                                        : Colors.red.shade700,
                                    size: 18,
                                  ),
                                  onPressed: () async {
                                    await SoundService.toggleMasterAudio();
                                    if (mounted) setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                        // 2. Hero Section: Mascot & Game Title
                        Column(
                          children: [
                            AnimatedBuilder(
                              animation: _animController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, -6 * _animController.value),
                                  child: child,
                                );
                              },
                              child: Container(
                                width: 85,
                                height: 85,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFF8A65), Color(0xFFFF5722)],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepOrange.withValues(alpha: 0.35),
                                      blurRadius: 18,
                                      spreadRadius: 3,
                                      offset: const Offset(0, 6),
                                    )
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(_controller.chefAvatar, style: const TextStyle(fontSize: 46)),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'ChefMerge',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.brown.shade900,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                LocalizationService.tr('app_subtitle'),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // 3. Current / Saved Level Card
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: currentLevel.themeColor.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: currentLevel.themeColor.withValues(alpha: 0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: currentLevel.themeColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                alignment: Alignment.center,
                                child: Text(currentLevel.icon, style: const TextStyle(fontSize: 22)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${LocalizationService.tr('level')}: ${currentLevel.number} / ${GameLevel.allLevels.length}',
                                          style: TextStyle(
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.bold,
                                            color: currentLevel.themeColor,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '⭐' * stars,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      currentLevel.title,
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.brown.shade900,
                                      ),
                                    ),
                                    Text(
                                      '🎯 3⭐ ${LocalizationService.tr('target')}: ${currentLevel.targetScore} P',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                                color: currentLevel.themeColor,
                                onPressed: () => _startGame(),
                              ),
                            ],
                          ),
                        ),

                        // 4. Main Actions (Kariyer & Sonsuz Mod + Menüler)
                        Column(
                          children: [
                            // 1. Kariyer Oyna Butonu
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF7043),
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  shadowColor: Colors.deepOrange.withValues(alpha: 0.45),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () => _startGame(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.play_arrow_rounded, size: 26),
                                    const SizedBox(width: 6),
                                    Text(
                                      LocalizationService.tr('play'),
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),

                            // 2. 🔥 Sonsuz Hızlı Mutfak Modu Butonu
                            SizedBox(
                              width: double.infinity,
                              height: 42,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE65100),
                                  foregroundColor: Colors.white,
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: _startEndlessMode,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('🔥', style: TextStyle(fontSize: 15)),
                                    const SizedBox(width: 6),
                                    Text(
                                      LocalizationService.tr('endless_mode'),
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                    if (_controller.endlessHighScore > 0) ...[
                                      const SizedBox(width: 6),
                                      Text(
                                        '(${_controller.endlessHighScore} P)',
                                        style: const TextStyle(fontSize: 10.5, color: Color(0xFFFFE082), fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Row 1 of Secondary Buttons: Bölümler & Şans Çarkı
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSecondaryButton(
                                    icon: '🗺️',
                                    title: '${LocalizationService.tr('level_select')} (${GameLevel.allLevels.length})',
                                    onTap: _openLevelSelect,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildSecondaryButton(
                                    icon: '🎡',
                                    title: LocalizationService.tr('daily_wheel'),
                                    onTap: _openDailyWheel,
                                    highlightColor: Colors.amber.shade50,
                                    badgeText: SaveService.canSpinDailyWheel() ? 'HEDİYE' : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Row 2 of Secondary Buttons: Sıralama & Tarifler
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSecondaryButton(
                                    icon: '🏆',
                                    title: LocalizationService.tr('leaderboard'),
                                    onTap: _openLeaderboard,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildSecondaryButton(
                                    icon: '📖',
                                    title: LocalizationService.tr('recipe_book'),
                                    onTap: _openRecipeBook,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),

                            // Row 3 of Secondary Buttons: Nasıl Oynanır? (Rehber)
                            _buildSecondaryButton(
                              icon: '🎓',
                              title: LocalizationService.tr('how_to_play'),
                              onTap: _openTutorial,
                            ),
                          ],
                        ),

                        // 5. Footer Info
                        Text(
                          'ChefMerge v2.5 • 100 ${LocalizationService.tr('level')} • ${LocalizationService.tr('endless_mode')}',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  ],
),
);
},
);
}

  Widget _buildSecondaryButton({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color? highlightColor,
    String? badgeText,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: highlightColor ?? Colors.white,
        foregroundColor: Colors.brown.shade900,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: Colors.orange.shade200, width: 1.2),
        ),
      ),
      onPressed: onTap,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (badgeText != null) ...[
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF5722), Color(0xFFE64A19)],
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
