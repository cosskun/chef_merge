import 'package:flutter/material.dart';
import '../models/item_model.dart';

/// Reusable widget for displaying food item visuals across the game
/// Supports custom PNG assets with automatic fallback to clean Unicode emojis.
class ItemIconWidget extends StatelessWidget {
  final GameItem item;
  final double size;
  final bool animate;

  const ItemIconWidget({
    super.key,
    required this.item,
    this.size = 36,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    if (item.imageAsset != null && item.imageAsset!.isNotEmpty) {
      return Image.asset(
        item.imageAsset!,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildEmojiFallback(),
      );
    }
    return _buildEmojiFallback();
  }

  Widget _buildEmojiFallback() {
    return Text(
      item.emoji,
      style: TextStyle(
        fontSize: size * 0.85,
        height: 1.1,
      ),
      textAlign: TextAlign.center,
    );
  }
}
