import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../models/item_model.dart';
import '../services/save_service.dart';
import '../services/localization_service.dart';

class RecipeCategoryFilter {
  final String id;
  final String title;
  final String icon;

  const RecipeCategoryFilter({
    required this.id,
    required this.title,
    required this.icon,
  });
}

class RecipeBookDialog extends StatefulWidget {
  const RecipeBookDialog({super.key});

  @override
  State<RecipeBookDialog> createState() => _RecipeBookDialogState();
}

class _RecipeBookDialogState extends State<RecipeBookDialog> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  late Set<String> _discoveredSecrets;

  final List<RecipeCategoryFilter> _categories = const [
    RecipeCategoryFilter(id: 'all', title: 'Tümü', icon: '🌟'),
    RecipeCategoryFilter(id: 'soup', title: 'Çorbalar', icon: '🍲'),
    RecipeCategoryFilter(id: 'toast', title: 'Tost & Sandviç', icon: '🥪'),
    RecipeCategoryFilter(id: 'pasta', title: 'Makarna & Lazanya', icon: '🍝'),
    RecipeCategoryFilter(id: 'bakery', title: 'Simit & Pide', icon: '🥨'),
    RecipeCategoryFilter(id: 'burger', title: 'Burger & Çıtır Tavuk', icon: '🍔'),
    RecipeCategoryFilter(id: 'pizza', title: 'Pizza', icon: '🍕'),
    RecipeCategoryFilter(id: 'street', title: 'Kumpir & Hot Dog', icon: '🥔'),
    RecipeCategoryFilter(id: 'mexican', title: 'Taco & Meksika', icon: '🌮'),
    RecipeCategoryFilter(id: 'traditional', title: 'Pilav & Döner', icon: '🍚'),
    RecipeCategoryFilter(id: 'dessert', title: 'Künefe & Tatlılar', icon: '🧀'),
    RecipeCategoryFilter(id: 'waffle', title: 'Waffle & Pastane', icon: '🧇'),
    RecipeCategoryFilter(id: 'asian', title: 'Ramen & Sushi', icon: '🍜'),
    RecipeCategoryFilter(id: 'drinks', title: 'Boba & Kahve', icon: '🧋'),
    RecipeCategoryFilter(id: 'secret', title: 'Gizli Simya', icon: '🧪'),
  ];

  @override
  void initState() {
    super.initState();
    _discoveredSecrets = SaveService.getDiscoveredSecretRecipes();
  }

  bool _matchesCategory(Recipe recipe, String categoryId) {
    if (categoryId == 'all') return true;
    if (categoryId == 'secret') return recipe.isSecret;

    final code = recipe.result.code.toLowerCase();
    final a = recipe.itemACode.toLowerCase();
    final b = recipe.itemBCode.toLowerCase();

    switch (categoryId) {
      case 'soup':
        return code.contains('soup') || code.contains('tomato') || code.contains('onion') || code.contains('mushroom') || code.contains('carrot');
      case 'toast':
        return code.contains('toast') || code.contains('bread') || code.contains('sandwich');
      case 'pasta':
        return code.contains('pasta') || code.contains('spaghetti') || code.contains('lasagna') || code.contains('bolognese');
      case 'bakery':
        return code.contains('simit') || code.contains('lahmacun') || code.contains('pide') || code.contains('baklava') || code.contains('sesame');
      case 'burger':
        return code.contains('burger') || code.contains('nugget') || code.contains('chicken') || code.contains('wings') || code.contains('patty') || code.contains('fries');
      case 'pizza':
        return code.contains('pizza');
      case 'street':
        return code.contains('kumpir') || code.contains('hot_dog') || code.contains('sausage');
      case 'mexican':
        return code.contains('taco') || code.contains('nacho') || code.contains('tortilla') || code.contains('quesadilla') || code.contains('guacamole');
      case 'traditional':
        return code.contains('pilaf') || code.contains('rice') || code.contains('doner') || code.contains('iskender') || code.contains('casserole');
      case 'dessert':
        return code.contains('kunefe') || code.contains('rice_pudding') || code.contains('baklava');
      case 'waffle':
        return code.contains('waffle') || code.contains('croissant') || code.contains('donut') || code.contains('cake') || code.contains('pancake');
      case 'asian':
        return code.contains('ramen') || code.contains('noodle') || code.contains('sushi') || code.contains('nori');
      case 'drinks':
        return code.contains('boba') || code.contains('coffee') || code.contains('espresso') || code.contains('latte') || code.contains('lassi') || code.contains('mocktail') || code.contains('tea');
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allRecipesList = [...Recipe.standardRecipes, ...Recipe.secretRecipes];

    final filteredRecipes = allRecipesList.where((recipe) {
      // Category filter
      if (!_matchesCategory(recipe, _selectedCategory)) return false;

      // Search filter
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final itemA = GameItem.findByCode(recipe.itemACode);
        final itemB = GameItem.findByCode(recipe.itemBCode);
        final result = recipe.result;

        final matchesTitle = recipe.title.toLowerCase().contains(q);
        final matchesResult = result.localizedName.toLowerCase().contains(q) || result.name.toLowerCase().contains(q);
        final matchesA = (itemA?.localizedName.toLowerCase().contains(q) ?? false) || (itemA?.name.toLowerCase().contains(q) ?? false);
        final matchesB = (itemB?.localizedName.toLowerCase().contains(q) ?? false) || (itemB?.name.toLowerCase().contains(q) ?? false);

        if (!matchesTitle && !matchesResult && !matchesA && !matchesB) {
          return false;
        }
      }

      return true;
    }).toList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: const Color(0xFFFFFDF9),
      insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 680),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 1. Header (Title & Close Button)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text('📖', style: TextStyle(fontSize: 22)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Şefin Tarif Rehberi',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: Colors.brown.shade900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${filteredRecipes.length}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'İki malzemeyi birleştir, yeni lezzeti ortaya çıkar!',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.brown.shade600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
            const SizedBox(height: 10),

            // 2. Search Bar
            Container(
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Tarif veya malzeme ara... (örn: makarna, burger, kumpir)',
                  hintStyle: TextStyle(fontSize: 11, color: Colors.brown.shade300),
                  prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Colors.orange),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 14, color: Colors.grey),
                          onPressed: () => setState(() => _searchQuery = ''),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 9),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // 3. Category Filter Chips (Horizontal Scroll)
            SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 6),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat.id;

                  return InkWell(
                    onTap: () => setState(() => _selectedCategory = cat.id),
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFF7043) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? Colors.deepOrange : Colors.orange.shade200,
                          width: isSelected ? 1.4 : 1.0,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: Colors.deepOrange.withValues(alpha: 0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(cat.icon, style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(
                            cat.title,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.brown.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // 4. Recipe Cards List (Redesigned & Crystal Clear)
            Expanded(
              child: filteredRecipes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🔍', style: TextStyle(fontSize: 32)),
                          const SizedBox(height: 6),
                          Text(
                            'Aradığınız kriterde tarif bulunamadı',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredRecipes.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final recipe = filteredRecipes[index];
                        final itemA = GameItem.findByCode(recipe.itemACode) ?? GameItem.rawTomato;
                        final itemB = GameItem.findByCode(recipe.itemBCode) ?? GameItem.rawTomato;
                        final result = recipe.result;
                        final isDiscovered = !recipe.isSecret || _discoveredSecrets.contains(result.code);

                        return _buildClearRecipeCard(
                          recipe: recipe,
                          itemA: itemA,
                          itemB: itemB,
                          result: result,
                          isDiscovered: isDiscovered,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClearRecipeCard({
    required Recipe recipe,
    required GameItem itemA,
    required GameItem itemB,
    required GameItem result,
    required bool isDiscovered,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: recipe.isSecret
            ? (isDiscovered ? const Color(0xFFFFF8E1) : const Color(0xFFF3E5F5))
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: recipe.isSecret
              ? (isDiscovered ? Colors.amber.shade400 : Colors.purple.shade200)
              : Colors.orange.shade100,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Target Dish Name & Level Stars Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    isDiscovered && result.imageAsset != null && result.imageAsset!.isNotEmpty
                        ? Image.asset(result.imageAsset!, width: 20, height: 20, fit: BoxFit.contain, errorBuilder: (c, e, s) => Text(result.emoji, style: const TextStyle(fontSize: 16)))
                        : Text(
                            isDiscovered ? result.emoji : '❓',
                            style: const TextStyle(fontSize: 16),
                          ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        isDiscovered ? result.localizedName : 'Gizli Simya Tarifi',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: recipe.isSecret ? Colors.deepPurple.shade900 : Colors.brown.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: recipe.isSecret ? Colors.purple.shade100 : Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  recipe.isSecret ? '🧪 Gizli' : '⭐' * result.level,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: recipe.isSecret ? Colors.purple.shade900 : Colors.brown.shade900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Row 2: Formula Box [Item A] + [Item B] ➔ [Result]
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.shade50.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Item A Box
                Expanded(child: _buildIngredientBox(itemA)),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ),

                // Item B Box
                Expanded(child: _buildIngredientBox(itemB)),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.deepOrange,
                    size: 16,
                  ),
                ),

                // Result Output Box
                Expanded(
                  child: isDiscovered
                      ? _buildIngredientBox(result, isResult: true)
                      : _buildHiddenResultBox(recipe.secretHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientBox(GameItem item, {bool isResult = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: isResult ? item.accentColor.withValues(alpha: 0.35) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isResult ? item.primaryColor : Colors.grey.shade300,
          width: isResult ? 1.5 : 0.9,
        ),
        boxShadow: [
          BoxShadow(
            color: (isResult ? item.primaryColor : Colors.black).withValues(alpha: 0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 38,
            height: 38,
            child: Center(
              child: item.imageAsset != null && item.imageAsset!.isNotEmpty
                  ? Image.asset(
                      item.imageAsset!,
                      width: 38,
                      height: 38,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.medium,
                      errorBuilder: (c, e, s) => Text(item.emoji, style: const TextStyle(fontSize: 26)),
                    )
                  : Text(item.emoji, style: const TextStyle(fontSize: 26)),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.localizedName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: isResult ? FontWeight.w900 : FontWeight.w700,
              color: Colors.brown.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHiddenResultBox(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200, width: 1.2),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 38,
            height: 38,
            child: Center(
              child: Text('❓', style: TextStyle(fontSize: 26)),
            ),
          ),
          SizedBox(height: 3),
          Text(
            'Keşfedilmedi',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
