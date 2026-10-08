import 'dart:io';

void main() {
  final file = File('lib/models/level_model.dart');
  var content = file.readAsStringSync();

  // Level 9: add butter
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.avocado, GameItem.egg, GameItem.cheese],',
    'rawPool: [GameItem.rawBread, GameItem.avocado, GameItem.egg, GameItem.cheese, GameItem.butter],',
  );

  // Level 13: add milk so players can make pancake with egg + milk or rawBread + honey
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.butter, GameItem.honey, GameItem.egg],',
    'rawPool: [GameItem.rawBread, GameItem.butter, GameItem.honey, GameItem.egg, GameItem.milk],',
  );

  // Level 14: add sucuk & milk
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.butter, GameItem.honey, GameItem.strawberry, GameItem.egg],',
    'rawPool: [GameItem.rawBread, GameItem.butter, GameItem.honey, GameItem.strawberry, GameItem.egg, GameItem.sucuk, GameItem.milk],',
  );

  // Level 33: add potato for frenchFries
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.rawMeat, GameItem.cheese, GameItem.mushroom, GameItem.onion],',
    'rawPool: [GameItem.rawBread, GameItem.rawMeat, GameItem.cheese, GameItem.mushroom, GameItem.onion, GameItem.potato],',
  );

  // Level 39: add rawBread for crispyChickenBurger
  content = content.replaceFirst(
    'rawPool: [GameItem.rawChicken, GameItem.pepper, GameItem.potato],',
    'rawPool: [GameItem.rawChicken, GameItem.pepper, GameItem.potato, GameItem.rawBread],',
  );

  // Level 43: add sausage & rawBread for hotDog
  content = content.replaceFirst(
    'rawPool: [GameItem.potato, GameItem.cheese, GameItem.butter],',
    'rawPool: [GameItem.potato, GameItem.cheese, GameItem.butter, GameItem.sausage, GameItem.rawBread],',
  );

  // Level 48: add lemon for guacamole
  content = content.replaceFirst(
    'rawPool: [GameItem.tortilla, GameItem.rawMeat, GameItem.cheese, GameItem.avocado],',
    'rawPool: [GameItem.tortilla, GameItem.rawMeat, GameItem.cheese, GameItem.avocado, GameItem.lemon],',
  );

  // Level 56: add butter for donerMeat
  content = content.replaceFirst(
    'rawPool: [GameItem.rawMeat, GameItem.rawBread],',
    'rawPool: [GameItem.rawMeat, GameItem.rawBread, GameItem.butter],',
  );

  // Level 57: add butter for donerMeat
  content = content.replaceFirst(
    'rawPool: [GameItem.rawMeat, GameItem.tortilla, GameItem.rawTomato],',
    'rawPool: [GameItem.rawMeat, GameItem.tortilla, GameItem.butter, GameItem.rawTomato, GameItem.rawBread],',
  );

  // Level 59: add tortilla for durumDoner
  content = content.replaceFirst(
    'rawPool: [GameItem.rawMeat, GameItem.rawBread, GameItem.butter, GameItem.rawTomato],',
    'rawPool: [GameItem.rawMeat, GameItem.rawBread, GameItem.butter, GameItem.rawTomato, GameItem.tortilla, GameItem.cheese],',
  );

  // Level 60: add rawRice for padisahTray / pilaf
  content = content.replaceFirst(
    'rawPool: [GameItem.rawMeat, GameItem.tortilla, GameItem.rawBread, GameItem.butter, GameItem.rawTomato, GameItem.cheese],',
    'rawPool: [GameItem.rawMeat, GameItem.tortilla, GameItem.rawBread, GameItem.butter, GameItem.rawTomato, GameItem.cheese, GameItem.rawRice],',
  );

  // Level 72: add butter for chocoCookie
  content = content.replaceFirst(
    'rawPool: [GameItem.donutDough, GameItem.chocolate, GameItem.strawberry, GameItem.rawBread],',
    'rawPool: [GameItem.donutDough, GameItem.chocolate, GameItem.strawberry, GameItem.rawBread, GameItem.butter],',
  );

  // Level 73: add nuts for nuttyWaffle and donutDough for strawberryDonut
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.butter, GameItem.chocolate, GameItem.strawberry, GameItem.banana],',
    'rawPool: [GameItem.rawBread, GameItem.butter, GameItem.chocolate, GameItem.strawberry, GameItem.banana, GameItem.nuts, GameItem.donutDough],',
  );

  // Level 77: add rawRice for ramenNoodles (rawBread + rawRice) or pastaDough
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.egg, GameItem.rawMeat],',
    'rawPool: [GameItem.rawBread, GameItem.rawRice, GameItem.egg, GameItem.rawMeat],',
  );

  // Level 79: add rawRice for ramenNoodles
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.rawMeat, GameItem.mushroom, GameItem.egg],',
    'rawPool: [GameItem.rawBread, GameItem.rawRice, GameItem.rawMeat, GameItem.mushroom, GameItem.egg],',
  );

  // Level 88: add tarator/lemon for calamariFritti
  content = content.replaceFirst(
    'rawPool: [GameItem.calamari, GameItem.butter, GameItem.eggplant, GameItem.rawTomato],',
    'rawPool: [GameItem.calamari, GameItem.tarator, GameItem.butter, GameItem.eggplant, GameItem.rawTomato],',
  );

  // Level 92: add lemon for americano
  content = content.replaceFirst(
    'rawPool: [GameItem.rawCoffee, GameItem.milk],',
    'rawPool: [GameItem.rawCoffee, GameItem.milk, GameItem.lemon],',
  );

  // Level 94: add honey for caramelMacchiato
  content = content.replaceFirst(
    'rawPool: [GameItem.rawCoffee, GameItem.milk, GameItem.iceCreamCone, GameItem.strawberry],',
    'rawPool: [GameItem.rawCoffee, GameItem.milk, GameItem.honey, GameItem.iceCreamCone, GameItem.strawberry],',
  );

  // Level 96: add mushroom for supremePizza
  content = content.replaceFirst(
    'rawPool: [GameItem.rawBread, GameItem.pastaDough, GameItem.rawTomato, GameItem.cheese, GameItem.rawMeat, GameItem.sucuk],',
    'rawPool: [GameItem.rawBread, GameItem.pastaDough, GameItem.rawTomato, GameItem.cheese, GameItem.rawMeat, GameItem.sucuk, GameItem.mushroom],',
  );

  // Level 98: add rawBread for chefRamen
  content = content.replaceFirst(
    'rawPool: [GameItem.rawSalmon, GameItem.rawRice, GameItem.avocado, GameItem.calamari, GameItem.tarator, GameItem.rawMeat],',
    'rawPool: [GameItem.rawSalmon, GameItem.rawRice, GameItem.rawBread, GameItem.avocado, GameItem.calamari, GameItem.tarator, GameItem.rawMeat],',
  );

  // Level 99: add rawBread & rawRice for iskender & padisahTray & vanillaIceCream for dondurmaliKunefe
  content = content.replaceFirst(
    'rawPool: [GameItem.rawMeat, GameItem.butter, GameItem.eggplant, GameItem.milk, GameItem.tortilla, GameItem.cheese, GameItem.croissantDough, GameItem.nuts],',
    'rawPool: [GameItem.rawMeat, GameItem.butter, GameItem.rawBread, GameItem.rawRice, GameItem.eggplant, GameItem.milk, GameItem.tortilla, GameItem.cheese, GameItem.iceCreamCone],',
  );

  // Level 100: add butter, potato, sucuk, rawTomato, iceCreamCone
  content = content.replaceFirst(
    'rawPool: [GameItem.rawSalmon, GameItem.rawRice, GameItem.rawMeat, GameItem.rawBread, GameItem.cheese, GameItem.pastaDough, GameItem.chocolate, GameItem.avocado],',
    'rawPool: [GameItem.rawSalmon, GameItem.rawRice, GameItem.rawMeat, GameItem.rawBread, GameItem.cheese, GameItem.pastaDough, GameItem.butter, GameItem.rawTomato, GameItem.sucuk, GameItem.iceCreamCone, GameItem.milk],',
  );

  file.writeAsStringSync(content);
  print('Successfully updated rawPools across all levels!');
}
