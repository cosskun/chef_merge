import 'package:flutter/material.dart';
import '../state/game_controller.dart';
import 'item_card.dart';

class BoardGrid extends StatelessWidget {
  final GameController controller;

  const BoardGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final skin = controller.currentBoardSkin;

    return Container(
      constraints: const BoxConstraints(maxWidth: 380, maxHeight: 380),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: skin.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: skin.borderColor,
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: skin.borderColor.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          childAspectRatio: 1.0,
        ),
        itemCount: GameController.boardSize,
        itemBuilder: (context, index) {
          final item = controller.board[index];

          return DragTarget<int>(
            onWillAcceptWithDetails: (details) => details.data != index,
            onAcceptWithDetails: (details) {
              controller.mergeSlots(details.data, index);
            },
            builder: (context, candidateData, rejectedData) {
              final isHovered = candidateData.isNotEmpty;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: isHovered
                      ? skin.tileHoverColor
                      : skin.tileColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isHovered
                        ? Colors.amber.shade700
                        : skin.borderColor.withValues(alpha: 0.5),
                    width: isHovered ? 2.5 : 1.2,
                  ),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.3),
                            blurRadius: 6,
                            spreadRadius: 1,
                          )
                        ]
                      : null,
                ),
                child: item != null
                    ? ItemCard(
                        item: item,
                        slotIndex: index,
                        isHighlighted: isHovered,
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
