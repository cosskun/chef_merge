import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../models/recipe_model.dart';
import '../models/item_model.dart';

class OrderRecipeDialog extends StatefulWidget {
  final CustomerOrder order;
  final int initialPageIndex;

  const OrderRecipeDialog({
    super.key,
    required this.order,
    this.initialPageIndex = 0,
  });

  @override
  State<OrderRecipeDialog> createState() => _OrderRecipeDialogState();
}

class _OrderRecipeDialogState extends State<OrderRecipeDialog> {
  late int _currentPage;
  late final PageController _pageController;

  bool get _isMultiItem => widget.order.isPartyTray && widget.order.partyItems.length > 1;
  int get _totalPages => _isMultiItem ? widget.order.partyItems.length : 1;

  GameItem get _currentItem {
    if (_isMultiItem) {
      final safeIndex = _currentPage.clamp(0, widget.order.partyItems.length - 1);
      return widget.order.partyItems[safeIndex];
    }
    return widget.order.targetItem;
  }

  @override
  void initState() {
    super.initState();
    final maxIndex = _totalPages - 1;
    _currentPage = widget.initialPageIndex.clamp(0, maxIndex);
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    if (page >= 0 && page < _totalPages) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = _currentItem;

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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    key: ValueKey(currentItem.code),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: currentItem.accentColor.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: currentItem.imageAsset != null && currentItem.imageAsset!.isNotEmpty
                        ? Image.asset(
                            currentItem.imageAsset!,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                            errorBuilder: (c, e, s) => Text(
                              currentItem.emoji,
                              style: const TextStyle(fontSize: 26),
                            ),
                          )
                        : Text(
                            currentItem.emoji,
                            style: const TextStyle(fontSize: 26),
                          ),
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
                            widget.order.customerAvatar,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              "${widget.order.customerName}'in Siparişi",
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
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          currentItem.localizedName,
                          key: ValueKey(currentItem.code),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade900,
                            height: 1.15,
                          ),
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

            const Divider(height: 16),

            // 2. Multi-Item Pagination Bar (Only visible when single order has multiple items)
            if (_isMultiItem) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: 'Önceki Yemek',
                      icon: const Icon(Icons.chevron_left_rounded, size: 22),
                      color: _currentPage > 0 ? Colors.deepOrange : Colors.grey.shade400,
                      onPressed: _currentPage > 0 ? () => _goToPage(_currentPage - 1) : null,
                      visualDensity: VisualDensity.compact,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Yemek ${_currentPage + 1} / $_totalPages: ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              currentItem.localizedName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange.shade800,
                              ),
                            ),
                          ),
                          if (widget.order.isPartyTray &&
                              _currentPage < widget.order.partyCompletedItems.length &&
                              widget.order.partyCompletedItems[_currentPage]) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.check_circle_rounded, color: Colors.green, size: 14),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Sonraki Yemek',
                      icon: const Icon(Icons.chevron_right_rounded, size: 22),
                      color: _currentPage < _totalPages - 1 ? Colors.deepOrange : Colors.grey.shade400,
                      onPressed: _currentPage < _totalPages - 1 ? () => _goToPage(_currentPage + 1) : null,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],

            // 3. Recipe Steps Title
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
            const SizedBox(height: 8),

            // 4. Scrollable / Paged Steps List
            Flexible(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _totalPages,
                physics: _isMultiItem ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, pageIdx) {
                  final pageItem = _isMultiItem ? widget.order.partyItems[pageIdx] : widget.order.targetItem;
                  final steps = Recipe.getStepsFor(pageItem.code);

                  if (steps.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Bu ürün doğrudan kilerden çıkarılabilir!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.brown.shade600, fontSize: 12),
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
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
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // 5. Got it Button
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
