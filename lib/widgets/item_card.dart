import 'package:flutter/material.dart';
import '../models/item_model.dart';

class ItemCard extends StatelessWidget {
  final GameItem item;
  final int slotIndex;
  final bool isDragging;
  final bool isHighlighted;

  const ItemCard({
    super.key,
    required this.item,
    required this.slotIndex,
    this.isDragging = false,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: slotIndex,
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 75,
          height: 80,
          child: Transform.scale(
            scale: 1.15,
            child: _buildCardContent(isFeedback: true),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.25,
        child: _buildCardContent(),
      ),
      child: _buildCardContent(),
    );
  }

  Widget _buildCardContent({bool isFeedback = false}) {
    final stars = '⭐' * item.level;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            item.accentColor.withValues(alpha: 0.9),
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isHighlighted
              ? Colors.amberAccent
              : item.primaryColor.withValues(alpha: 0.6),
          width: isHighlighted ? 2.5 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isFeedback
                ? Colors.black.withValues(alpha: 0.35)
                : item.primaryColor.withValues(alpha: 0.18),
            blurRadius: isFeedback ? 14 : 4,
            offset: Offset(0, isFeedback ? 6 : 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Level Stars top right
          Positioned(
            top: 1,
            right: 2,
            child: Text(
              stars,
              style: const TextStyle(fontSize: 7.5),
            ),
          ),

          // Main Center Content
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: item.imageAsset != null && item.imageAsset!.isNotEmpty
                    ? Image.asset(
                        item.imageAsset!,
                        width: 44,
                        height: 44,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Text(
                          item.emoji,
                          style: const TextStyle(fontSize: 34),
                        ),
                      )
                    : Text(
                        item.emoji,
                        style: const TextStyle(fontSize: 34),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
