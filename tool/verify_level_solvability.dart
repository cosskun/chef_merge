import 'package:chef_merge/models/level_model.dart';
import 'package:chef_merge/models/recipe_model.dart';
import 'package:chef_merge/models/item_model.dart';

void main() {
  print('=== CHECKING 100 LEVELS CRAFTABILITY & RAW POOL INTEGRITY ===');
  int issueCount = 0;

  for (final level in GameLevel.allLevels) {
    // Collect all craftable items from rawPool
    final craftable = <String>{...level.rawPool.map((i) => i.code)};
    bool added = true;
    while (added) {
      added = false;
      for (final recipe in Recipe.recipes) {
        if (craftable.contains(recipe.itemACode) && craftable.contains(recipe.itemBCode)) {
          if (!craftable.contains(recipe.result.code)) {
            craftable.add(recipe.result.code);
            added = true;
          }
        }
      }
    }

    final missingInOrders = <String>[];
    for (final order in level.orderPool) {
      if (!craftable.contains(order.code)) {
        missingInOrders.add('${order.name} (${order.code})');
      }
    }

    if (missingInOrders.isNotEmpty) {
      issueCount++;
      print('❌ Bölüm ${level.number} (${level.title}):');
      print('   Raw Pool: ${level.rawPool.map((i) => "${i.name}(${i.code})").toList()}');
      print('   Eksik/Yapılamayan Siparişler: $missingInOrders');
    }
  }

  print('\nToplam Sorunlu Seviye Sayısı: $issueCount');
}
