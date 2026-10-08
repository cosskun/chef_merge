import 'dart:async';
import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../services/save_service.dart';
import '../services/sound_service.dart';
import '../state/game_controller.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _progressController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  final List<String> _foodIcons = ['🍅', '🥪', '🧀', '🍕', '🍟', '🍜', '🍣', '🧇', '🧋', '👑'];
  int _currentIconIndex = 0;
  Timer? _iconTimer;

  final List<String> _loadingTips = [
    '💡 İpucu: Aynı iki malzemeyi üst üste sürükleyerek yeni lezzetler keşfet!',
    '🌍 Bilgi: 100 bölümü tamamla, Dünya Şefler Şampiyonu ol!',
    '⚡ İpucu: Siparişleri art arda hızlı teslim ederek Alevli Kombo başlat!',
    '🛂 Bilgi: Her 5 bölümde bir pasaportuna yeni bir şehir vizesi basılır!',
    '🧪 İpucu: Gizli simya tariflerini keşfederek devasa ekstra puanlar kazan!',
    '🎩 Bilgi: Kazandığın şef şapkalarını Dükkan menüsünden giyebilirsin!',
  ];
  int _currentTipIndex = 0;
  Timer? _tipTimer;

  @override
  void initState() {
    super.initState();

    // Pulse & Float Animation for Mascot
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.06).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Progress Bar Animation (0% to 100% in 2.2 seconds)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOutCubic,
    );

    // Icon cycling timer
    _iconTimer = Timer.periodic(const Duration(milliseconds: 280), (timer) {
      if (mounted) {
        setState(() {
          _currentIconIndex = (_currentIconIndex + 1) % _foodIcons.length;
        });
      }
    });

    // Tip cycling timer
    _tipTimer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      if (mounted) {
        setState(() {
          _currentTipIndex = (_currentTipIndex + 1) % _loadingTips.length;
        });
      }
    });

    _startAppInitialization();
  }

  Future<void> _startAppInitialization() async {
    // Start progress animation
    _progressController.forward();

    // Perform any background asset or sound initialization if needed
    await Future.delayed(const Duration(milliseconds: 2400));

    if (!mounted) return;

    // Smooth page transition to HomeScreen
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    _iconTimer?.cancel();
    _tipTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Premium Warm Kitchen Gradient Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFF3E0),
                    Color(0xFFFFE0B2),
                    Color(0xFFFFCC80),
                    Color(0xFFFFAB91),
                  ],
                ),
              ),
            ),
          ),

          // 2. Subtle Background Food Pattern Watermarks
          Positioned(
            top: 40,
            left: 20,
            child: Opacity(
              opacity: 0.12,
              child: const Text('🍕', style: TextStyle(fontSize: 70)),
            ),
          ),
          Positioned(
            top: 120,
            right: 25,
            child: Opacity(
              opacity: 0.12,
              child: const Text('🍔', style: TextStyle(fontSize: 65)),
            ),
          ),
          Positioned(
            bottom: 140,
            left: 30,
            child: Opacity(
              opacity: 0.12,
              child: const Text('🍣', style: TextStyle(fontSize: 60)),
            ),
          ),
          Positioned(
            bottom: 180,
            right: 25,
            child: Opacity(
              opacity: 0.12,
              child: const Text('🍜', style: TextStyle(fontSize: 65)),
            ),
          ),

          // 3. Center Content
          SafeArea(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Spacer
                    const SizedBox(height: 10),

                    // Main Mascot & Branding Box
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Floating & Pulsing Mascot Badge
                        ScaleTransition(
                          scale: _pulseAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer Glow Circle
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.orange.shade400.withValues(alpha: 0.5),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              // Core Chef Circle
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [Color(0xFFFF8A65), Color(0xFFD84315)],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepOrange.withValues(alpha: 0.45),
                                      blurRadius: 22,
                                      spreadRadius: 4,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                  border: Border.all(color: Colors.white, width: 3.5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  GameController.instance.chefAvatar.isNotEmpty
                                      ? GameController.instance.chefAvatar
                                      : '👨‍🍳',
                                  style: const TextStyle(fontSize: 56),
                                ),
                              ),
                              // Orbiting Food Icon Bubble
                              Positioned(
                                top: 4,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.15),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    _foodIcons[_currentIconIndex],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),

                        // Game Title
                        Text(
                          'ChefMerge',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            color: Colors.brown.shade900,
                            shadows: [
                              Shadow(
                                color: Colors.white.withValues(alpha: 0.8),
                                offset: const Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Subtitle Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.orange.shade300, width: 1.2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            LocalizationService.tr('app_subtitle'),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Bottom Section: Animated Loading Bar & Tips
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Progress Percentage
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            final percent = (_progressAnimation.value * 100).toInt();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Mutfak Hazırlanıyor... 🍳',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown.shade800,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '%$percent',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.deepOrange.shade800,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 8),

                        // Custom Rounded Loading Bar
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return Container(
                              height: 14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.orange.shade300, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withValues(alpha: 0.15),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  children: [
                                    // Filled progress gradient
                                    FractionallySizedBox(
                                      widthFactor: _progressAnimation.value.clamp(0.02, 1.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFFFB74D),
                                              Color(0xFFFF7043),
                                              Color(0xFFE64A19),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Animated Rotating Chef Tips
                        SizedBox(
                          width: double.infinity,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            layoutBuilder: (currentChild, previousChildren) => currentChild ?? const SizedBox.shrink(),
                            child: Container(
                              key: ValueKey<int>(_currentTipIndex),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.orange.shade200),
                              ),
                              child: Text(
                                _loadingTips[_currentTipIndex],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown.shade800,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Version info
                        Text(
                          'v2.5 • Google DeepMind & ChefMerge Studio',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.brown.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
