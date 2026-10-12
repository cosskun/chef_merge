import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../state/game_controller.dart';
import 'order_recipe_dialog.dart';

class OrderCard extends StatelessWidget {
  final CustomerOrder order;
  final GameController controller;

  const OrderCard({
    super.key,
    required this.order,
    required this.controller,
  });

  Color _getPatienceColor(double ratio) {
    if (ratio > 0.5) {
      return const Color(0xFF4CAF50); // Yeşil
    } else if (ratio > 0.25) {
      return const Color(0xFFFF9800); // Turuncu
    } else {
      return const Color(0xFFF44336); // Kırmızı
    }
  }

  void _showRecipe(BuildContext context, {int initialPageIndex = 0}) {
    final wasPlaying = controller.isPlaying;
    if (wasPlaying) {
      controller.pauseGame();
    }
    showDialog(
      context: context,
      builder: (context) => OrderRecipeDialog(
        order: order,
        initialPageIndex: initialPageIndex,
      ),
    ).then((_) {
      if (wasPlaying && !controller.hasTriggeredVictory) {
        controller.resumeGame();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = order.progressRatio;
    final isFast = order.isFastDelivery;
    final isCritical = progress < 0.25 && !order.isCompleted && !order.isExpired;
    final isVip = order.isVip;
    final basePoints = order.calculateBasePoints();

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) {
        controller.deliverOrder(details.data, order.id);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          decoration: BoxDecoration(
            color: order.isCompleted
                ? Colors.green.shade50
                : order.isExpired
                    ? Colors.red.shade50
                    : isVip
                        ? const Color(0xFFFFF8E1) // Altın zemin
                        : isHovered
                            ? Colors.amber.shade100
                            : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isHovered
                  ? Colors.amber.shade700
                  : isVip
                      ? const Color(0xFFFFB300) // VIP Altın çerçeve
                      : isCritical
                          ? Colors.redAccent
                          : Colors.orange.shade200,
              width: isHovered ? 2.5 : (isVip ? 2.0 : (isCritical ? 1.8 : 1.2)),
            ),
            boxShadow: [
              BoxShadow(
                color: isVip
                    ? Colors.amber.withValues(alpha: 0.45)
                    : isHovered
                        ? Colors.amber.withValues(alpha: 0.4)
                        : Colors.black.withValues(alpha: 0.05),
                blurRadius: isVip ? 8 : (isHovered ? 6 : 3),
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Header (Customer Avatar & Name + VIP Badge)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: isVip
                        ? const Color(0xFFFFECB3)
                        : Colors.orange.shade50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        order.customerAvatar,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          order.customerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                            color: isVip
                                ? Colors.amber.shade900
                                : Colors.brown.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Middle Content (Dish Emoji & Name or Party Tray Grid) - Tap to view recipe
                Expanded(
                  child: order.isPartyTray
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(order.partyItems.length, (idx) {
                              final item = order.partyItems[idx];
                              final isDone = order.partyCompletedItems[idx];

                              return Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(6),
                                  onTap: () => _showRecipe(context, initialPageIndex: idx),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 1),
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    decoration: BoxDecoration(
                                      color: isDone
                                          ? Colors.green.shade100
                                          : Colors.orange.shade50.withValues(alpha: 0.5),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isDone ? Colors.green : Colors.orange.shade200,
                                        width: isDone ? 1.2 : 0.8,
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            item.imageAsset != null && item.imageAsset!.isNotEmpty
                                                ? Image.asset(item.imageAsset!, width: 16, height: 16, fit: BoxFit.contain, errorBuilder: (c, e, s) => Text(item.emoji, style: const TextStyle(fontSize: 14)))
                                                : Text(item.emoji, style: const TextStyle(fontSize: 14)),
                                            Text(
                                              item.localizedName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 6.5,
                                                fontWeight: FontWeight.bold,
                                                color: isDone ? Colors.green.shade900 : Colors.brown.shade800,
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (isDone)
                                          const Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Icon(Icons.check_circle, color: Colors.green, size: 10),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      : InkWell(
                          onTap: () => _showRecipe(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: order.targetItem.imageAsset != null && order.targetItem.imageAsset!.isNotEmpty
                                        ? Image.asset(
                                            order.targetItem.imageAsset!,
                                            width: 26,
                                            height: 26,
                                            fit: BoxFit.contain,
                                            errorBuilder: (c, e, s) => Text(
                                              order.targetItem.emoji,
                                              style: const TextStyle(fontSize: 22),
                                            ),
                                          )
                                        : Text(
                                            order.targetItem.emoji,
                                            style: const TextStyle(fontSize: 22),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      order.targetItem.localizedName,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.brown.shade900,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),

                // 3. Bottom Row: Reward Badge & Tarif Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (order.isCompleted)
                          const Text(
                            '✅ Teslim',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        else if (order.isExpired)
                          const Text(
                            '❌ Ayrıldı',
                            style: TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          )
                        else ...[
                          // Reward badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                            decoration: BoxDecoration(
                              color: isVip
                                  ? Colors.amber.shade200
                                  : isFast
                                      ? Colors.amber.shade100
                                      : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isVip ? '👑 +$basePoints' : (isFast ? '⚡+$basePoints' : '⭐+$basePoints'),
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: isVip
                                    ? Colors.brown.shade900
                                    : isFast
                                        ? Colors.deepOrange.shade800
                                        : Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          // Mini Tarif button
                          InkWell(
                            onTap: () => _showRecipe(context),
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.amber.shade300, width: 0.8),
                              ),
                              child: const Text(
                                '💡Tarif',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // 4. Patience Progress Bar
                if (!order.isCompleted && !order.isExpired)
                  Container(
                    height: 3.5,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _getPatienceColor(progress),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
