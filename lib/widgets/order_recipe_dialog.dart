import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/recipe_model.dart';
import '../models/item_model.dart';
import '../services/localization_service.dart';

class OrderRecipeDialog extends StatelessWidget {
  final CustomerOrder order;

  const OrderRecipeDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final targetItem = order.targetItem;
    final List<Recipe> steps = order.isPartyTray
        ? order.partyItems
            .expand((item) => Recipe.getStepsFor(item.code))
            .toSet()
            .toList()
        : Recipe.getStepsFor(targetItem.code);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color(0xFFFFFDF9),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 600),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Top Header with Order Info (100% Overflow Protected)
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: targetItem.accentColor.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: targetItem.imageAsset != null && targetItem.imageAsset!.isNotEmpty
                      ? Image.asset(targetItem.imageAsset!, width: 32, height: 32, fit: BoxFit.contain, errorBuilder: (c, e, s) => Text(targetItem.emoji, style: const TextStyle(fontSize: 26)))
                      : Text(
                          targetItem.emoji,
                          style: const TextStyle(fontSize: 26),
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            order.customerAvatar,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "${order.customerName}'in Siparişi",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        targetItem.localizedName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.brown.shade700,
                  onPressed: () => Navigator.of(context).pop(),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),

            const Divider(height: 20),

            // 2. Recipe Steps Title
            Row(
              children: [
                const Icon(Icons.auto_awesome, size: 16, color: Colors.orange),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Gerekli Birleştirme Adımları:',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 3. Scrollable Steps List (Fits any screen height without vertical overflow)
            Flexible(
              child: steps.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Bu ürün doğrudan kilerden çıkarılabilir!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.brown.shade600, fontSize: 12),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: steps.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final stepIndex = index + 1;
                        final recipe = steps[index];
                        final itemA = GameItem.findByCode(recipe.itemACode) ?? GameItem.rawTomato;
                        final itemB = GameItem.findByCode(recipe.itemBCode) ?? GameItem.rawTomato;
                        final result = recipe.result;

                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.orange.shade100),
                          ),
                          child: Row(
                            children: [
                              // Step Number Badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade600,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '$stepIndex',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),

                              // Item A
                              _buildStepItem(itemA),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown,
                                  ),
                                ),
                              ),

                              // Item B
                              _buildStepItem(itemB),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.orange,
                                  size: 14,
                                ),
                              ),

                              // Result Item
                              Expanded(child: _buildStepResult(result)),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 12),

            // 4. Got it Button
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Anladım, Yapmaya Başla!',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(GameItem item) {
    return SizedBox(
      width: 46,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: item.primaryColor.withValues(alpha: 0.4),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: item.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: item.imageAsset != null && item.imageAsset!.isNotEmpty
                ? Image.asset(
                    item.imageAsset!,
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                    errorBuilder: (c, e, s) => Text(item.emoji, style: const TextStyle(fontSize: 18)),
                  )
                : Text(item.emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 2),
          Text(
            item.localizedName,
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w700),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepResult(GameItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: BoxDecoration(
        color: item.accentColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: item.primaryColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: item.primaryColor.withValues(alpha: 0.12),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            child: item.imageAsset != null && item.imageAsset!.isNotEmpty
                ? Image.asset(
                    item.imageAsset!,
                    width: 26,
                    height: 26,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.medium,
                    errorBuilder: (c, e, s) => Text(item.emoji, style: const TextStyle(fontSize: 18)),
                  )
                : Text(item.emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              item.localizedName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: Colors.brown.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
