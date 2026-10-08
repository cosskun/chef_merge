import 'package:flutter/material.dart';
import '../state/game_controller.dart';

class FloatingOverlay extends StatelessWidget {
  final List<FloatingEvent> events;

  const FloatingOverlay({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const SizedBox.shrink();

    return IgnorePointer(
      child: Stack(
        children: events.map((event) {
          return TweenAnimationBuilder<double>(
            key: ValueKey(event.id),
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1300),
            builder: (context, value, child) {
              final dyOffset = -60.0 * value;
              final opacity = (1.0 - (value * 0.95)).clamp(0.0, 1.0);
              final scale = 0.8 + (value * (1.0 - value) * 1.4);

              return Positioned(
                left: event.position.dx - 100,
                top: event.position.dy + dyOffset,
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: event.color, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: event.color.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (event.icon != null) ...[
                            Icon(event.icon, size: 16, color: event.color),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            event.text,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: event.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
