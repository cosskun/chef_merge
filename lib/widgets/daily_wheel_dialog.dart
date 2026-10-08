import 'dart:math';
import 'package:flutter/material.dart';
import '../state/game_controller.dart';
import '../services/save_service.dart';
import '../services/sound_service.dart';

class WheelReward {
  final String title;
  final String emoji;
  final Color color1;
  final Color color2;
  final int freeze;
  final int spatula;
  final int broom;
  final int score;
  final String celebrationText;

  const WheelReward({
    required this.title,
    required this.emoji,
    required this.color1,
    required this.color2,
    this.freeze = 0,
    this.spatula = 0,
    this.broom = 0,
    this.score = 0,
    required this.celebrationText,
  });
}

class DailyWheelDialog extends StatefulWidget {
  final GameController controller;

  const DailyWheelDialog({super.key, required this.controller});

  @override
  State<DailyWheelDialog> createState() => _DailyWheelDialogState();
}

class _DailyWheelDialogState extends State<DailyWheelDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _wheelAnimation;

  final List<WheelReward> _rewards = const [
    WheelReward(
      title: '+2 Buzdolabı',
      emoji: '❄️',
      color1: Color(0xFF0288D1),
      color2: Color(0xFF29B6F6),
      freeze: 2,
      celebrationText: '2 Adet Buzdolabı Molası Kazandınız!',
    ),
    WheelReward(
      title: '+500 Puan',
      emoji: '⭐',
      color1: Color(0xFFF57C00),
      color2: Color(0xFFFFB74D),
      score: 500,
      celebrationText: '+500 Puan Skora Eklendi!',
    ),
    WheelReward(
      title: '+1 Spatula',
      emoji: '🪄',
      color1: Color(0xFF7B1FA2),
      color2: Color(0xFFBA68C8),
      spatula: 1,
      celebrationText: '1 Adet Sihirli Spatula Kazandınız!',
    ),
    WheelReward(
      title: '+2 Süpürge',
      emoji: '🌪️',
      color1: Color(0xFF00796B),
      color2: Color(0xFF26A69A),
      broom: 2,
      celebrationText: '2 Adet Mutfak Süpürgesi Kazandınız!',
    ),
    WheelReward(
      title: '+1 Buzdolabı',
      emoji: '❄️',
      color1: Color(0xFF0277BD),
      color2: Color(0xFF4FC3F7),
      freeze: 1,
      celebrationText: '1 Adet Buzdolabı Molası Kazandınız!',
    ),
    WheelReward(
      title: 'BÜYÜK ŞEF!',
      emoji: '🎁',
      color1: Color(0xFFC2185B),
      color2: Color(0xFFFF4081),
      freeze: 1,
      spatula: 1,
      broom: 1,
      score: 300,
      celebrationText: 'BÜYÜK ŞEF PAKETİ!\n(1 ❄️ + 1 🪄 + 1 🌪️ + 300 P)',
    ),
    WheelReward(
      title: '+2 Spatula',
      emoji: '🪄',
      color1: Color(0xFF512DA8),
      color2: Color(0xFF9575CD),
      spatula: 2,
      celebrationText: '2 Adet Sihirli Spatula Kazandınız!',
    ),
    WheelReward(
      title: '+1000 Puan',
      emoji: '⭐',
      color1: Color(0xFFE65100),
      color2: Color(0xFFFFD54F),
      score: 1000,
      celebrationText: '+1000 Dev Puan Bonusu!',
    ),
  ];

  bool _isSpinning = false;
  bool _canSpin = true;
  double _currentRotation = 0.0;
  WheelReward? _wonReward;

  @override
  void initState() {
    super.initState();
    _canSpin = SaveService.canSpinDailyWheel();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    );

    _wheelAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onSpinCompleted();
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;
  double _targetRotation = 0.0;

  void _spinWheel() {
    if (_isSpinning || !_canSpin) return;

    setState(() {
      _isSpinning = true;
      _wonReward = null;
    });

    SoundService.playSpawn();

    final random = Random();
    final sliceAngle = (2 * pi) / _rewards.length;
    _selectedIndex = random.nextInt(_rewards.length);

    // Calculate rotation so that _selectedIndex lands under top pointer (angle = -pi/2 or 3*pi/2)
    final fullTurns = 6 + random.nextInt(3); // 6 to 8 full revolutions
    final sliceCenter = _selectedIndex * sliceAngle + (sliceAngle / 2);
    
    // Top pointer is at -pi/2 (270 degrees / 12 o'clock)
    // Formula for target angle that aligns sliceCenter with 12 o'clock pointer:
    final targetAngleOffset = (2 * pi) - sliceCenter - (pi / 2);
    _targetRotation = _currentRotation + (fullTurns * 2 * pi) + targetAngleOffset;

    _animController.reset();
    _animController.forward();
  }

  void _onSpinCompleted() {
    _currentRotation = _targetRotation % (2 * pi);
    final won = _rewards[_selectedIndex];

    // Award to game controller
    widget.controller.claimDailyReward(
      freeze: won.freeze,
      spatula: won.spatula,
      broom: won.broom,
      score: won.score,
      title: won.title,
    );

    setState(() {
      _isSpinning = false;
      _canSpin = false;
      _wonReward = won;
    });

    SoundService.playFastDelivery();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: const Color(0xFFFFFDF9),
      elevation: 16,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('🎡', style: TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Günlük Şans Çarkı',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.brown.shade900,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _canSpin
                                  ? 'Bugünkü ücretsiz şans hakkınız hazır!'
                                  : 'Bugünkü ödülünüzü aldınız ✨',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _canSpin ? Colors.green.shade800 : Colors.brown.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: _isSpinning ? null : () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Wheel Container with Pointer
            SizedBox(
              width: 280,
              height: 280,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating Wheel
                  AnimatedBuilder(
                    animation: _wheelAnimation,
                    builder: (context, child) {
                      final angle = _isSpinning
                          ? _currentRotation +
                              (_targetRotation - _currentRotation) * _wheelAnimation.value
                          : _currentRotation;

                      return Transform.rotate(
                        angle: angle,
                        child: CustomPaint(
                          size: const Size(270, 270),
                          painter: _WheelPainter(rewards: _rewards),
                        ),
                      );
                    },
                  ),

                  // Center Gold Hub
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Color(0xFFFFEE58), Color(0xFFFFB300), Color(0xFFF57F17)],
                      ),
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text('👨‍🍳', style: TextStyle(fontSize: 26)),
                    ),
                  ),

                  // Top Pointer (Arrow pointing down at 12 o'clock)
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 28,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Reward Announcement or Spin Button
            if (_wonReward != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade100, Colors.orange.shade50],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade700, width: 1.5),
                ),
                child: Column(
                  children: [
                    const Text(
                      '🎉 TEBRİKLER! 🎉',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_wonReward!.emoji} ${_wonReward!.celebrationText}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canSpin ? const Color(0xFFFF7043) : Colors.grey.shade400,
                  foregroundColor: Colors.white,
                  elevation: _canSpin ? 4 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _isSpinning ? null : (_canSpin ? _spinWheel : () => Navigator.of(context).pop()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isSpinning)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    else ...[
                      Text(_canSpin ? '🎡 ' : '✨ ', style: const TextStyle(fontSize: 18)),
                      Text(
                        _canSpin
                            ? 'ŞANS ÇARKINI ÇEVİR'
                            : 'YARIN TEKRAR GEL (TAMAM)',
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<WheelReward> rewards;

  _WheelPainter({required this.rewards});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sliceAngle = (2 * pi) / rewards.length;

    final paint = Paint()..style = PaintingStyle.fill;

    // Draw Outer Shadow & Rim
    final rimPaint = Paint()
      ..color = const Color(0xFFD7CCC8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius - 4, rimPaint);

    for (int i = 0; i < rewards.length; i++) {
      final reward = rewards[i];
      final startAngle = i * sliceAngle;

      paint.shader = RadialGradient(
        colors: [reward.color2, reward.color1],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

      // Draw Slice Pie
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 6),
        startAngle,
        sliceAngle,
        true,
        paint,
      );

      // Slice Divider Line
      final dividerPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.8)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;

      final pX = center.dx + (radius - 6) * cos(startAngle);
      final pY = center.dy + (radius - 6) * sin(startAngle);
      canvas.drawLine(center, Offset(pX, pY), dividerPaint);

      // Draw Emoji & Text inside slice
      canvas.save();
      final textAngle = startAngle + sliceAngle / 2;
      canvas.translate(center.dx, center.dy);
      canvas.rotate(textAngle);

      final textSpan = TextSpan(
        children: [
          TextSpan(
            text: '${reward.emoji}\n',
            style: const TextStyle(fontSize: 18),
          ),
          TextSpan(
            text: reward.title,
            style: const TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.black45, blurRadius: 3, offset: Offset(0, 1)),
              ],
            ),
          ),
        ],
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: 80);

      // Offset outward
      canvas.translate(radius * 0.58, 0);
      canvas.rotate(pi / 2); // Orient text upright relative to slice
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }

    // Outer Golden Pegs/Dots
    final pegPaint = Paint()..color = Colors.amberAccent;
    for (int i = 0; i < rewards.length * 2; i++) {
      final pegAngle = (i * pi) / rewards.length;
      final pegX = center.dx + (radius - 4) * cos(pegAngle);
      final pegY = center.dy + (radius - 4) * sin(pegAngle);
      canvas.drawCircle(Offset(pegX, pegY), 2.5, pegPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate) => false;
}
