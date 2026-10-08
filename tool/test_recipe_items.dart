import 'package:chef_merge/models/recipe_model.dart';
import 'package:chef_merge/models/item_model.dart';

void main() {
  print('Total standardRecipes: ${Recipe.standardRecipes.length}');
  for (final recipe in Recipe.standardRecipes) {
    final itemA = GameItem.findByCode(recipe.itemACode);
    final itemB = GameItem.findByCode(recipe.itemBCode);
    if (itemA == null) {
      print('Recipe A missing item: ${recipe.itemACode}');
    }
    if (itemB == null) {
      print('Recipe B missing item: ${recipe.itemBCode}');
    }
  }
}
