import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../state/game_controller.dart';

class LevelVictoryDialog extends StatelessWidget {
  final GameController controller;

  const LevelVictoryDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final level = controller.currentLevel;
    final stars = level.calculateStars(controller.score);
    final isPassed = level.isPassed(controller.score);
    final hasNext = isPassed && (controller.currentLevelIndex + 1 < GameLevel.allLevels.length);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: const Color(0xFFFFFDF9),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            // Top Badge (Celebration / Failure)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isPassed ? Colors.amber.shade100 : Colors.red.shade100,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: isPassed
                        ? Colors.amber.withValues(alpha: 0.35)
                        : Colors.red.withValues(alpha: 0.25),
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                isPassed ? '🎉' : '⏱️',
                style: const TextStyle(fontSize: 36),
              ),
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              isPassed ? 'Süre Doldu & Tebrikler!' : 'Süre Doldu!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isPassed ? Colors.brown.shade900 : Colors.red.shade800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              isPassed
                  ? 'Bölüm ${level.number}: ${level.title} Tamamlandı!'
                  : 'Geçiş barajı için en az %40 (${level.star1Score} P) gerekliydi.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 10),

            // Star Rating Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isStarEarned = index < stars;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedScale(
                    scale: isStarEarned ? 1.15 : 0.85,
                    duration: Duration(milliseconds: 300 + (index * 150)),
                    child: Text(
                      isStarEarned ? '⭐' : '⚪',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),

            // Rich Session Stats Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.orange.shade50.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: Column(
                children: [
                  _buildStatRow('🍲 Teslim Edilen Tabak', '${controller.servedCount} Adet', Colors.blue.shade800),
                  const SizedBox(height: 4),
                  _buildStatRow('⚡ Hızlı Teslimat Bonusu', '${controller.fastDeliveryCount} Adet', Colors.orange.shade900),
                  const SizedBox(height: 4),
                  _buildStatRow('💔 Teslim Edilemeyen (Kaçan)', '${controller.failedCount} Adet', Colors.red.shade700),
                  const SizedBox(height: 4),
                  _buildStatRow('🔥 En Uzun Seri (Kombo)', '${controller.maxStreak} Tabak', Colors.deepOrange),
                  const SizedBox(height: 4),
                  _buildStatRow('💵 Kazanılan Bahşiş (Tips)', '+${controller.totalTips} P', Colors.green.shade800),
                  const Divider(height: 14),
                  _buildStatRow(
                    '🏆 TOPLAM PUAN',
                    '${controller.score} P',
                    isPassed ? Colors.amber.shade900 : Colors.red.shade800,
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Thresholds Footnote
            Text(
              'Barajlar: ⭐ 1 Yıldız: ${level.star1Score} P  •  ⭐⭐ 2 Yıldız: ${level.star2Score} P  •  ⭐⭐⭐ 3 Yıldız: ${level.star3Score} P',
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
                color: Colors.brown.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.brown.shade800,
                      side: BorderSide(color: Colors.brown.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      controller.restartGame();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tekrar Oyna'),
                  ),
                ),
                if (hasNext) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7043),
                        foregroundColor: Colors.white,
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        controller.nextLevel();
                      },
                      child: const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sonraki Bölüm',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward_rounded, size: 17),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildStatRow(String label, String value, Color color, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isBold ? 12 : 11,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
              color: Colors.brown.shade900,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 14 : 11.5,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
