import 'package:flutter/material.dart';
import '../state/game_controller.dart';

class LeaderboardDialog extends StatelessWidget {
  final GameController controller;

  const LeaderboardDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final playerScore = controller.highScore > 0 ? controller.highScore : controller.score;

    final List<Map<String, dynamic>> leaderboard = [
      {'name': 'Usta Şef Mehmet', 'avatar': '👨‍🍳', 'score': 8450, 'isPlayer': false},
      {'name': 'Gurme Ayşe', 'avatar': '👩‍🍳', 'score': 7200, 'isPlayer': false},
      {'name': 'Şef Can', 'avatar': '🧑‍🍳', 'score': 6150, 'isPlayer': false},
      {'name': 'Sen (Oyuncu)', 'avatar': '⭐', 'score': playerScore, 'isPlayer': true},
      {'name': 'Selin Hanım', 'avatar': '👩‍💼', 'score': 4800, 'isPlayer': false},
      {'name': 'Mert', 'avatar': '👨‍💻', 'score': 3900, 'isPlayer': false},
      {'name': 'Zeynep', 'avatar': '👩‍🎨', 'score': 3200, 'isPlayer': false},
      {'name': 'Ayşe Teyze', 'avatar': '👵', 'score': 2400, 'isPlayer': false},
    ];

    // Sort by score descending
    leaderboard.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color(0xFFFFFDF9),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('🏆', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oyuncu Sıralaması',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      Text(
                        'En usta şefler listesi ve rekorlar!',
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
            const Divider(height: 20),

            // Rankings List
            Expanded(
              child: ListView.separated(
                itemCount: leaderboard.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = leaderboard[index];
                  final isPlayer = item['isPlayer'] as bool;
                  final rank = index + 1;

                  String rankBadge = '#$rank';
                  Color rankColor = Colors.grey.shade700;
                  if (rank == 1) {
                    rankBadge = '🥇';
                  } else if (rank == 2) {
                    rankBadge = '🥈';
                  } else if (rank == 3) {
                    rankBadge = '🥉';
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: isPlayer
                          ? Colors.amber.shade100.withValues(alpha: 0.8)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isPlayer
                            ? Colors.amber.shade600
                            : Colors.grey.shade200,
                        width: isPlayer ? 2 : 1,
                      ),
                      boxShadow: isPlayer
                          ? [
                              BoxShadow(
                                color: Colors.amber.withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Rank Badge
                        SizedBox(
                          width: 32,
                          child: Text(
                            rankBadge,
                            style: TextStyle(
                              fontSize: rank <= 3 ? 18 : 13,
                              fontWeight: FontWeight.w900,
                              color: rankColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Avatar
                        Text(
                          item['avatar'] as String,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 10),

                        // Name
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isPlayer ? FontWeight.w900 : FontWeight.bold,
                                  color: isPlayer ? Colors.brown.shade900 : Colors.black87,
                                ),
                              ),
                              if (isPlayer)
                                Text(
                                  'Senin Rekorun',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber.shade900,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Score
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isPlayer ? Colors.amber.shade200 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${item['score']} P',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w900,
                              color: isPlayer ? Colors.brown.shade900 : Colors.black87,
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
      ),
    );
  }
}
