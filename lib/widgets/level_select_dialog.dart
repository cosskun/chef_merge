import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../state/game_controller.dart';
import '../services/save_service.dart';
import 'daily_wheel_dialog.dart';

class LevelSelectDialog extends StatelessWidget {
  final GameController controller;

  const LevelSelectDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color(0xFFFFFDF9),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440, maxHeight: 580),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('🗺️', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Restoran Bölümleri',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      Text(
                        'Kolaydan zora doğru lezzet basamaklarını tırman!',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.brown.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const Divider(height: 16),

            // Daily Lucky Wheel Entry Banner
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (ctx) => DailyWheelDialog(controller: controller),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Row(
                  children: [
                    const Text('🎡', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Günlük Şans Çarkı',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.brown.shade900,
                                  ),
                                ),
                              ),
                              if (SaveService.canSpinDailyWheel()) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'HAZIR!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8.5,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            'Jokerler, dondurma molası ve puan kazan!',
                            style: TextStyle(fontSize: 10.5, color: Colors.brown.shade700),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.play_circle_fill_rounded, color: Colors.deepOrange, size: 24),
                  ],
                ),
              ),
            ),

            // Levels List
            Expanded(
              child: ListView.separated(
                itemCount: GameLevel.allLevels.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final level = GameLevel.allLevels[index];
                  final isUnlocked = controller.unlockedLevels.contains(index);
                  final isCurrent = controller.currentLevelIndex == index;

                  return InkWell(
                    onTap: isUnlocked
                        ? () {
                            controller.setLevel(index);
                            Navigator.of(context).pop();
                          }
                        : null,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? level.themeColor.withValues(alpha: 0.12)
                            : isUnlocked
                                ? Colors.white
                                : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isCurrent
                              ? level.themeColor
                              : isUnlocked
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade200,
                          width: isCurrent ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Level Icon & Number
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: isUnlocked
                                  ? level.themeColor.withValues(alpha: 0.2)
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              isUnlocked ? level.icon : '🔒',
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Level Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Bölüm ${level.number}: ${level.title}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                          color: isUnlocked
                                              ? Colors.brown.shade900
                                              : Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                    if (isCurrent) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1.5),
                                        decoration: BoxDecoration(
                                          color: level.themeColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Text(
                                          'Aktif',
                                          style: TextStyle(
                                            fontSize: 8.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  level.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: Colors.brown.shade600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '🎯 Hedef: ${level.targetScore} P',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: level.themeColor,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        '• ${level.categoryName}',
                                        style: TextStyle(
                                          fontSize: 9.5,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Arrow or Lock Icon
                          Icon(
                            isUnlocked
                                ? Icons.arrow_forward_ios_rounded
                                : Icons.lock_outline_rounded,
                            size: 16,
                            color: isUnlocked
                                ? level.themeColor
                                : Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
