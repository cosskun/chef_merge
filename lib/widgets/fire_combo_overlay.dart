import 'package:flutter/material.dart';
import '../state/game_controller.dart';

class FireComboOverlay extends StatelessWidget {
  final GameController controller;

  const FireComboOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final flyEvents = controller.flyEvents;

    return Stack(
      children: [
        // 1. ⚡ Hızlı Teslimat Uçan Tabak Animasyonları
        ...flyEvents.map((fly) {
          return TweenAnimationBuilder<double>(
            key: ValueKey(fly.id),
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              final currentX = fly.startOffset.dx + (fly.endOffset.dx - fly.startOffset.dx) * value;
              final currentY = fly.startOffset.dy + (fly.endOffset.dy - fly.startOffset.dy) * value - (40 * (1 - (value - 0.5).abs() * 2));
              final scale = 1.0 + (0.5 * (1 - value));
              final opacity = (1.0 - value).clamp(0.0, 1.0);

              return Positioned(
                left: currentX - 25,
                top: currentY - 25,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: fly.isVip
                              ? Colors.amber.shade300
                              : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: fly.isVip
                                  ? Colors.amber.withValues(alpha: 0.8)
                                  : Colors.orange.withValues(alpha: 0.6),
                              blurRadius: 12,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Text(
                          fly.emoji,
                          style: const TextStyle(fontSize: 26),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
