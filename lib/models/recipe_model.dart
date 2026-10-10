import 'item_model.dart';

class Recipe {
  final String itemACode;
  final String itemBCode;
  final GameItem result;
  final String title;
  final bool isSecret;
  final String secretHint;

  const Recipe({
    required this.itemACode,
    required this.itemBCode,
    required this.result,
    required this.title,
    this.isSecret = false,
    this.secretHint = '',
  });

  bool matches(String a, String b) {
    return (itemACode == a && itemBCode == b) ||
        (itemACode == b && itemBCode == a);
  }

  static const List<Recipe> standardRecipes = [
    Recipe(
      itemACode: 'raw_tomato',
      itemBCode: 'raw_tomato',
      result: GameItem.choppedTomato,
      title: 'Domates Doğrama',
    ),
    Recipe(
      itemACode: 'chopped_tomato',
      itemBCode: 'chopped_tomato',
      result: GameItem.tomatoSoup,
      title: 'Domates Çorbası Pişirme',
    ),
    Recipe(
      itemACode: 'tomato_soup',
      itemBCode: 'milk',
      result: GameItem.creamySoup,
      title: 'Kremalı Domates Çorbası',
    ),
    Recipe(
      itemACode: 'onion',
      itemBCode: 'onion',
      result: GameItem.onionSoup,
      title: 'Karamelize Soğan Çorbası',
    ),
    Recipe(
      itemACode: 'carrot',
      itemBCode: 'carrot',
      result: GameItem.carrotSoup,
      title: 'Havuç Çorbası Pişirme',
    ),
    Recipe(
      itemACode: 'mushroom',
      itemBCode: 'mushroom',
      result: GameItem.mushroomSoup,
      title: 'Mantar Çorbası Pişirme',
    ),
    Recipe(
      itemACode: 'mushroom_soup',
      itemBCode: 'milk',
      result: GameItem.creamyMushroomSoup,
      title: 'Kremalı Mantar Çorbası',
    ),
    Recipe(
      itemACode: 'tomato_soup',
      itemBCode: 'carrot_soup',
      result: GameItem.gardenSoup,
      title: 'Zengin Bahçe Çorbası',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'raw_bread',
      result: GameItem.bakedBread,
      title: 'Somun Ekmek Pişirme',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'cheese',
      result: GameItem.toast,
      title: 'Kaşarlı Tost Yapımı',
    ),
    Recipe(
      itemACode: 'toast',
      itemBCode: 'sucuk',
      result: GameItem.sucukToast,
      title: 'Sucuklu Karışık Tost',
    ),
    Recipe(
      itemACode: 'toast',
      itemBCode: 'lettuce',
      result: GameItem.lettuceToast,
      title: 'Marullu Sandviç',
    ),
    Recipe(
      itemACode: 'lettuce_toast',
      itemBCode: 'egg',
      result: GameItem.clubSandwich,
      title: '3 Katlı Gurme Club Sandviç',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'chopped_tomato',
      result: GameItem.pizzaBase,
      title: 'Soslu Pizza Tabanı Hazırlama',
    ),
    Recipe(
      itemACode: 'pizza_base',
      itemBCode: 'cheese',
      result: GameItem.pizza,
      title: 'Margherita Pizza Pişirme',
    ),
    Recipe(
      itemACode: 'pizza',
      itemBCode: 'sucuk',
      result: GameItem.pepperoniPizza,
      title: 'Pepperoni Pizza Pişirme',
    ),
    Recipe(
      itemACode: 'pizza',
      itemBCode: 'mushroom',
      result: GameItem.mushroomPizza,
      title: 'Mantarlı Pizza Pişirme',
    ),
    Recipe(
      itemACode: 'pizza',
      itemBCode: 'olive',
      result: GameItem.mediterraneanPizza,
      title: 'Akdeniz Zeytinli Pizza',
    ),
    Recipe(
      itemACode: 'pizza',
      itemBCode: 'cheese',
      result: GameItem.fourCheesePizza,
      title: 'Dört Peynirli Gurme Pizza',
    ),
    Recipe(
      itemACode: 'pepperoni_pizza',
      itemBCode: 'mushroom',
      result: GameItem.supremePizza,
      title: 'Mega Şef Pizzası',
    ),
    Recipe(
      itemACode: 'pasta_dough',
      itemBCode: 'pasta_dough',
      result: GameItem.spaghetti,
      title: 'Taze Spagetti Açma',
    ),
    Recipe(
      itemACode: 'spaghetti',
      itemBCode: 'chopped_tomato',
      result: GameItem.napoliPasta,
      title: 'Napoli Soslu Makarna',
    ),
    Recipe(
      itemACode: 'napoli_pasta',
      itemBCode: 'raw_meat',
      result: GameItem.bolognesePasta,
      title: 'Bolonez Soslu Spagetti',
    ),
    Recipe(
      itemACode: 'spaghetti',
      itemBCode: 'creamy_mushroom_soup',
      result: GameItem.alfredoPasta,
      title: 'Kremalı Fettuccine Alfredo',
    ),
    Recipe(
      itemACode: 'bolognese_pasta',
      itemBCode: 'cheese',
      result: GameItem.lasagna,
      title: 'Fırında Bolonez Lazanya',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'sesame',
      result: GameItem.simit,
      title: 'Çıtır Sokak Simidi',
    ),
    Recipe(
      itemACode: 'simit',
      itemBCode: 'cheese',
      result: GameItem.cheeseSimit,
      title: 'Kaşarlı Fırın Simidi',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'raw_meat',
      result: GameItem.lahmacun,
      title: 'Taş Fırın Lahmacun',
    ),
    Recipe(
      itemACode: 'lahmacun',
      itemBCode: 'cheese',
      result: GameItem.pide,
      title: 'Kıymalı Kaşarlı Pide',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'nuts',
      result: GameItem.baklava,
      title: 'Fıstıklı Antep Baklavası',
    ),
    Recipe(
      itemACode: 'egg',
      itemBCode: 'milk',
      result: GameItem.crepeBatter,
      title: 'Taze Krep Pişirme',
    ),
    Recipe(
      itemACode: 'crepe_batter',
      itemBCode: 'honey',
      result: GameItem.pancake,
      title: 'Ballı Pofuduk Pankek',
    ),
    Recipe(
      itemACode: 'crepe_batter',
      itemBCode: 'butter',
      result: GameItem.honeyCrepe,
      title: 'Ballı Fransız Krepi',
    ),
    Recipe(
      itemACode: 'pancake',
      itemBCode: 'strawberry',
      result: GameItem.strawberryPancake,
      title: 'Çilekli Pankek Kulesi',
    ),
    Recipe(
      itemACode: 'crepe_batter',
      itemBCode: 'chocolate',
      result: GameItem.chocoCrepe,
      title: 'Muzlu Çikolatalı Krep',
    ),
    Recipe(
      itemACode: 'crepe_batter',
      itemBCode: 'strawberry',
      result: GameItem.strawberryCrepe,
      title: 'Çilekli Fransız Çıtır Krep',
    ),
    Recipe(
      itemACode: 'raw_meat',
      itemBCode: 'raw_meat',
      result: GameItem.sauteedMeat,
      title: 'Lokum Dana Et Sote',
    ),
    Recipe(
      itemACode: 'raw_meat',
      itemBCode: 'onion',
      result: GameItem.cookedPatty,
      title: 'Cızbız Izgara Köfte',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'cooked_patty',
      result: GameItem.burger,
      title: 'Klasik Hamburger',
    ),
    Recipe(
      itemACode: 'burger',
      itemBCode: 'cheese',
      result: GameItem.cheeseBurger,
      title: 'Double Cheeseburger',
    ),
    Recipe(
      itemACode: 'potato',
      itemBCode: 'potato',
      result: GameItem.frenchFries,
      title: 'Çıtır Patates Kızartması',
    ),
    Recipe(
      itemACode: 'cheese_burger',
      itemBCode: 'french_fries',
      result: GameItem.tripleMonsterBurger,
      title: 'Burger & Patates Menü',
    ),
    Recipe(
      itemACode: 'burger',
      itemBCode: 'sucuk',
      result: GameItem.baconBurger,
      title: 'Sucuklu Gurme Burger',
    ),
    Recipe(
      itemACode: 'burger',
      itemBCode: 'mushroom',
      result: GameItem.mushroomSwissBurger,
      title: 'Mantar Soslu Burger',
    ),
    Recipe(
      itemACode: 'raw_chicken',
      itemBCode: 'raw_chicken',
      result: GameItem.chickenNugget,
      title: 'Altın Çıtır Nugget',
    ),
    Recipe(
      itemACode: 'chicken_nugget',
      itemBCode: 'french_fries',
      result: GameItem.chickenBucket,
      title: 'Çıtır Tavuk Kovası',
    ),
    Recipe(
      itemACode: 'chicken_nugget',
      itemBCode: 'baked_bread',
      result: GameItem.crispyChickenBurger,
      title: 'Zinger Çıtır Tavuk Burger',
    ),
    Recipe(
      itemACode: 'raw_chicken',
      itemBCode: 'pepper',
      result: GameItem.buffaloWings,
      title: 'Buffalo Acılı Kanatlar',
    ),
    Recipe(
      itemACode: 'sausage',
      itemBCode: 'baked_bread',
      result: GameItem.hotDog,
      title: 'Klasik Hot Dog',
    ),
    Recipe(
      itemACode: 'hot_dog',
      itemBCode: 'cheese',
      result: GameItem.cheddarHotDog,
      title: 'Cheddar Soslu Hot Dog',
    ),
    Recipe(
      itemACode: 'potato',
      itemBCode: 'butter',
      result: GameItem.kumpirBase,
      title: 'Tereyağlı Kumpir Tabanı',
    ),
    Recipe(
      itemACode: 'kumpir_base',
      itemBCode: 'sausage',
      result: GameItem.ortakoyKumpir,
      title: 'Ortaköy Dev Karışık Kumpir',
    ),
    Recipe(
      itemACode: 'tortilla',
      itemBCode: 'raw_meat',
      result: GameItem.taco,
      title: 'Çıtır Taco Yapımı',
    ),
    Recipe(
      itemACode: 'tortilla',
      itemBCode: 'cheese',
      result: GameItem.quesadilla,
      title: 'Peynirli Quesadilla',
    ),
    Recipe(
      itemACode: 'taco',
      itemBCode: 'cheese',
      result: GameItem.burrito,
      title: 'Dev Burrito Sarımı',
    ),
    Recipe(
      itemACode: 'avocado',
      itemBCode: 'lemon',
      result: GameItem.guacamole,
      title: 'Taze Guacamole Sos',
    ),
    Recipe(
      itemACode: 'tortilla',
      itemBCode: 'butter',
      result: GameItem.nachos,
      title: 'Eritme Nachos Yapımı',
    ),
    Recipe(
      itemACode: 'nachos',
      itemBCode: 'guacamole',
      result: GameItem.nachosSupreme,
      title: 'Nachos Supreme Tabağı',
    ),
    Recipe(
      itemACode: 'burrito',
      itemBCode: 'nachos',
      result: GameItem.fiestaGrande,
      title: 'Fiesta El Grande Şöleni',
    ),
    Recipe(
      itemACode: 'raw_rice',
      itemBCode: 'butter',
      result: GameItem.plainPilaf,
      title: 'Tereyağlı Pilav Pişirme',
    ),
    Recipe(
      itemACode: 'raw_rice',
      itemBCode: 'grape_leaves',
      result: GameItem.stuffedGrapeLeaves,
      title: 'Zeytinyağlı Yaprak Sarma',
    ),
    Recipe(
      itemACode: 'plain_pilaf',
      itemBCode: 'carrot',
      result: GameItem.veggiePilaf,
      title: 'Renkli Sebzeli Pilav',
    ),
    Recipe(
      itemACode: 'plain_pilaf',
      itemBCode: 'sauteed_meat',
      result: GameItem.meatPilaf,
      title: 'Kavurmalı Pilav Hazırlama',
    ),
    Recipe(
      itemACode: 'meat_pilaf',
      itemBCode: 'chopped_tomato',
      result: GameItem.royalPilaf,
      title: 'Saray Ziyafet Pilavı',
    ),
    Recipe(
      itemACode: 'raw_meat',
      itemBCode: 'butter',
      result: GameItem.donerMeat,
      title: 'Yaprak Döner Pişirme',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'butter',
      result: GameItem.pideBread,
      title: 'Taş Fırın Tırnak Pide',
    ),
    Recipe(
      itemACode: 'doner_meat',
      itemBCode: 'lavash',
      result: GameItem.durumDoner,
      title: 'Et Döner Dürüm',
    ),
    Recipe(
      itemACode: 'doner_meat',
      itemBCode: 'baked_bread',
      result: GameItem.tombikDoner,
      title: 'Tombik Döner Hazırlama',
    ),
    Recipe(
      itemACode: 'durum_doner',
      itemBCode: 'cheese',
      result: GameItem.cheeseDurum,
      title: 'Kaşarlı Hatay Dürüm',
    ),
    Recipe(
      itemACode: 'doner_meat',
      itemBCode: 'pide_bread',
      result: GameItem.iskender,
      title: 'Bursa İskender Kebap',
    ),
    Recipe(
      itemACode: 'iskender',
      itemBCode: 'plain_pilaf',
      result: GameItem.padisahTray,
      title: 'Padişah Saray Tepsisi',
    ),
    Recipe(
      itemACode: 'eggplant',
      itemBCode: 'milk',
      result: GameItem.begendiPuree,
      title: 'Köz Patlıcan Beğendi',
    ),
    Recipe(
      itemACode: 'begendi_puree',
      itemBCode: 'sauteed_meat',
      result: GameItem.hunkarBegendi,
      title: 'Hünkar Beğendi',
    ),
    Recipe(
      itemACode: 'eggplant',
      itemBCode: 'sauteed_meat',
      result: GameItem.aliNazik,
      title: 'Sarımsaklı Ali Nazik Kebabı',
    ),
    Recipe(
      itemACode: 'potato',
      itemBCode: 'peas',
      result: GameItem.veggieGarnish,
      title: 'Sebzeli Garnitür',
    ),
    Recipe(
      itemACode: 'sauteed_meat',
      itemBCode: 'veggie_garnish',
      result: GameItem.ormanKebabi,
      title: 'Geleneksel Orman Kebabı',
    ),
    Recipe(
      itemACode: 'calamari',
      itemBCode: 'tarator',
      result: GameItem.calamariFritti,
      title: 'Tarator Soslu Çıtır Kalamar Tava',
    ),
    Recipe(
      itemACode: 'eggplant',
      itemBCode: 'chopped_tomato',
      result: GameItem.saksuka,
      title: 'Zeytinyağlı Anne Usulü Şakşuka',
    ),
    Recipe(
      itemACode: 'calamari',
      itemBCode: 'butter',
      result: GameItem.garlicShrimp,
      title: 'Güveçte Tereyağlı Sarımsaklı Karides',
    ),
    Recipe(
      itemACode: 'calamari_fritti',
      itemBCode: 'saksuka',
      result: GameItem.aegeanMezzePlatter,
      title: 'Ege Kıyıları Meze Şöleni',
    ),
    Recipe(
      itemACode: 'milk',
      itemBCode: 'raw_rice',
      result: GameItem.ricePudding,
      title: 'Geleneksel Fırın Sütlaç',
    ),
    Recipe(
      itemACode: 'butter',
      itemBCode: 'cheese',
      result: GameItem.kunefe,
      title: 'Sıcak Peynirli Künefe',
    ),
    Recipe(
      itemACode: 'kunefe',
      itemBCode: 'vanilla_ice_cream',
      result: GameItem.dondurmaliKunefe,
      title: 'Dondurmalı Saray Künefesi',
    ),
    Recipe(
      itemACode: 'ice_cream_cone',
      itemBCode: 'milk',
      result: GameItem.vanillaIceCream,
      title: 'Vanilyalı Dondurma Çekme',
    ),
    Recipe(
      itemACode: 'vanilla_ice_cream',
      itemBCode: 'strawberry',
      result: GameItem.strawberryIceCream,
      title: 'Çilekli Dondurma Yapımı',
    ),
    Recipe(
      itemACode: 'vanilla_ice_cream',
      itemBCode: 'chocolate',
      result: GameItem.chocoIceCream,
      title: 'Çikolatalı Dondurma Yapımı',
    ),
    Recipe(
      itemACode: 'vanilla_ice_cream',
      itemBCode: 'banana',
      result: GameItem.bananaIceCream,
      title: 'Muzlu Dondurma Yapımı',
    ),
    Recipe(
      itemACode: 'strawberry_ice_cream',
      itemBCode: 'choco_ice_cream',
      result: GameItem.dualIceCream,
      title: 'İkili Gurme Külah',
    ),
    Recipe(
      itemACode: 'strawberry_ice_cream',
      itemBCode: 'milk',
      result: GameItem.sundae,
      title: 'Çilekli Sundae Kupa',
    ),
    Recipe(
      itemACode: 'banana_ice_cream',
      itemBCode: 'chocolate',
      result: GameItem.bananaSplit,
      title: 'Banana Split Ziyafeti',
    ),
    Recipe(
      itemACode: 'choco_ice_cream',
      itemBCode: 'nuts',
      result: GameItem.magnumTower,
      title: 'Magnum Karamel Kulesi',
    ),
    Recipe(
      itemACode: 'milk',
      itemBCode: 'strawberry',
      result: GameItem.milkshake,
      title: 'Çilekli Milkshake',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'butter',
      result: GameItem.waffle,
      title: 'Çıtır Waffle Pişirme',
    ),
    Recipe(
      itemACode: 'waffle',
      itemBCode: 'nuts',
      result: GameItem.nuttyWaffle,
      title: 'Fıstıklı Karamel Waffle',
    ),
    Recipe(
      itemACode: 'waffle',
      itemBCode: 'strawberry',
      result: GameItem.megaWaffle,
      title: 'Mega Waffle Ziyafeti',
    ),
    Recipe(
      itemACode: 'croissant_dough',
      itemBCode: 'butter',
      result: GameItem.plainCroissant,
      title: 'Tereyağlı Kruvasan Pişirme',
    ),
    Recipe(
      itemACode: 'plain_croissant',
      itemBCode: 'chocolate',
      result: GameItem.chocoCroissant,
      title: 'Çikolatalı Kruvasan Yapımı',
    ),
    Recipe(
      itemACode: 'plain_croissant',
      itemBCode: 'strawberry',
      result: GameItem.strawberryCroissant,
      title: 'Çilekli Kruvasan Yapımı',
    ),
    Recipe(
      itemACode: 'donut_dough',
      itemBCode: 'caramel',
      result: GameItem.donutDough,
      title: 'Glaze Donut Kızartma',
    ),
    Recipe(
      itemACode: 'donut_dough',
      itemBCode: 'chocolate',
      result: GameItem.chocoDonut,
      title: 'Çikolatalı Donut',
    ),
    Recipe(
      itemACode: 'donut_dough',
      itemBCode: 'strawberry',
      result: GameItem.strawberryDonut,
      title: 'Çilekli Donut',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'strawberry',
      result: GameItem.strawberryCake,
      title: 'Çilekli Yaş Pasta',
    ),
    Recipe(
      itemACode: 'strawberry_cake',
      itemBCode: 'chocolate',
      result: GameItem.chocoGrandCake,
      title: 'Dev Çikolatalı Pasta',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'butter',
      result: GameItem.cookie,
      title: 'Fırın Kurabiye',
    ),
    Recipe(
      itemACode: 'cookie',
      itemBCode: 'chocolate',
      result: GameItem.chocoCookie,
      title: 'Çikolatalı Cookie',
    ),
    Recipe(
      itemACode: 'raw_coffee',
      itemBCode: 'raw_coffee',
      result: GameItem.groundCoffee,
      title: 'Kahve Çekirdeği Öğütme',
    ),
    Recipe(
      itemACode: 'ground_coffee',
      itemBCode: 'ground_coffee',
      result: GameItem.espresso,
      title: 'Espresso Demleme',
    ),
    Recipe(
      itemACode: 'espresso',
      itemBCode: 'lemon',
      result: GameItem.americano,
      title: 'Buzlu Americano Hazırlama',
    ),
    Recipe(
      itemACode: 'milk',
      itemBCode: 'milk',
      result: GameItem.steamedMilk,
      title: 'Süt Köpürtme',
    ),
    Recipe(
      itemACode: 'espresso',
      itemBCode: 'steamed_milk',
      result: GameItem.latte,
      title: 'Latte',
    ),
    Recipe(
      itemACode: 'latte',
      itemBCode: 'chocolate',
      result: GameItem.mocha,
      title: 'Çikolatalı Mocha Yapımı',
    ),
    Recipe(
      itemACode: 'latte',
      itemBCode: 'honey',
      result: GameItem.caramelMacchiato,
      title: 'Caramel Macchiato Yapımı',
    ),
    Recipe(
      itemACode: 'latte',
      itemBCode: 'ice_cream_cone',
      result: GameItem.frappuccino,
      title: 'Buzlu Frappe Hazırlama',
    ),
    Recipe(
      itemACode: 'mocha',
      itemBCode: 'nuts',
      result: GameItem.royalBarista,
      title: 'Royal Barista Spesiyali',
    ),
    Recipe(
      itemACode: 'raw_rice',
      itemBCode: 'raw_rice',
      result: GameItem.sushiRice,
      title: 'Suşi Pirinci Hazırlama',
    ),
    Recipe(
      itemACode: 'raw_salmon',
      itemBCode: 'raw_salmon',
      result: GameItem.slicedSalmon,
      title: 'Somon Fileto Dilimleme',
    ),
    Recipe(
      itemACode: 'sushi_rice',
      itemBCode: 'sliced_salmon',
      result: GameItem.salmonNigiri,
      title: 'Somon Nigiri Hazırlama',
    ),
    Recipe(
      itemACode: 'sushi_rice',
      itemBCode: 'raw_salmon',
      result: GameItem.sushiRoll,
      title: 'Somon Maki Roll Sarımı',
    ),
    Recipe(
      itemACode: 'sushi_roll',
      itemBCode: 'cucumber',
      result: GameItem.cucumberMaki,
      title: 'Salatalıklı Maki Sarımı',
    ),
    Recipe(
      itemACode: 'cucumber_maki',
      itemBCode: 'avocado',
      result: GameItem.californiaRoll,
      title: 'Gurme California Roll',
    ),
    Recipe(
      itemACode: 'california_roll',
      itemBCode: 'sliced_salmon',
      result: GameItem.dragonRoll,
      title: 'Spesiyal Dragon Roll',
    ),
    Recipe(
      itemACode: 'dragon_roll',
      itemBCode: 'avocado',
      result: GameItem.goldenDragonRoll,
      title: 'Altın Dragon Roll Şöleni',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'raw_meat',
      result: GameItem.dimSum,
      title: 'Buharda Dim Sum Mantı',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'raw_rice',
      result: GameItem.ramenNoodles,
      title: 'El Yapımı Erişte Açma',
    ),
    Recipe(
      itemACode: 'ramen_noodles',
      itemBCode: 'raw_meat',
      result: GameItem.chefRamen,
      title: 'Usta Rameni Pişirme',
    ),
    Recipe(
      itemACode: 'egg',
      itemBCode: 'egg',
      result: GameItem.friedEgg,
      title: 'Sahanda Göz Yumurta Pişirme',
    ),
    Recipe(
      itemACode: 'fried_egg',
      itemBCode: 'sucuk',
      result: GameItem.sucukFriedEgg,
      title: 'Sucuklu Sahanda Yumurta',
    ),
    Recipe(
      itemACode: 'sucuk_fried_egg',
      itemBCode: 'cheese',
      result: GameItem.englishBreakfast,
      title: 'Kral Kahvaltı Tabağı',
    ),
    Recipe(
      itemACode: 'raw_bread',
      itemBCode: 'sliced_salmon',
      result: GameItem.fishBread,
      title: 'Çıtır Balık Ekmek',
    ),
    Recipe(
      itemACode: 'sliced_salmon',
      itemBCode: 'butter',
      result: GameItem.seafoodPan,
      title: 'Tereyağlı Deniz Tavası',
    ),
    Recipe(
      itemACode: 'lemon',
      itemBCode: 'lemon',
      result: GameItem.lemonade,
      title: 'Taze Limonata Sıkma',
    ),
    Recipe(
      itemACode: 'lemonade',
      itemBCode: 'strawberry',
      result: GameItem.smoothie,
      title: 'Çilekli Smoothie',
    ),
    Recipe(
      itemACode: 'smoothie',
      itemBCode: 'milk',
      result: GameItem.bubbleTea,
      title: 'Sütlü Bubble Tea',
    ),
  ];

  // =================== 52 GİZLİ SİMYA LEZZETLERİ ===================
  static const List<Recipe> secretRecipes = [
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'vanilla_ice_cream',
      result: GameItem.friedIceCream,
      title: 'Kızarmış Dondurma',
      isSecret: true,
      secretHint: '🍞 Fırın Ekmeği + 🍨 Dondurma',
    ),
    Recipe(
      itemACode: 'espresso',
      itemBCode: 'vanilla_ice_cream',
      result: GameItem.affogato,
      title: 'İtalyan Affogato',
      isSecret: true,
      secretHint: '☕ Espresso + 🍨 Dondurma',
    ),
    Recipe(
      itemACode: 'pizza',
      itemBCode: 'chocolate',
      result: GameItem.chocolatePizza,
      title: 'Nutella Tatlı Pizza',
      isSecret: true,
      secretHint: '🍕 Pizza + 🍫 Çikolata',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'avocado',
      result: GameItem.avocadoToast,
      title: 'Gurme Avokado Tost',
      isSecret: true,
      secretHint: '🍞 Fırın Ekmeği + 🥑 Avokado',
    ),
    Recipe(
      itemACode: 'french_fries',
      itemBCode: 'mushroom',
      result: GameItem.truffleFries,
      title: 'Trüf Mantarlı Çıtır Patates',
      isSecret: true,
      secretHint: '🍟 Patates Kızartması + 🍄 Mantar',
    ),
    Recipe(
      itemACode: 'cheese_burger',
      itemBCode: 'honey',
      result: GameItem.honeyMustardBurger,
      title: 'Ballı Gurme Burger',
      isSecret: true,
      secretHint: '🍔 Cheeseburger + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'banana_split',
      itemBCode: 'honey',
      result: GameItem.bananaSplitDeluxe,
      title: 'Karamelize Banana Split',
      isSecret: true,
      secretHint: '🍌 Banana Split + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'chocolate',
      itemBCode: 'pepper',
      result: GameItem.mexicanHotChocolate,
      title: 'Aztek Acı Çikolatası',
      isSecret: true,
      secretHint: '🍫 Çikolata + 🫑 Köy Biberi',
    ),
    Recipe(
      itemACode: 'dim_sum',
      itemBCode: 'honey',
      result: GameItem.sweetChiliWings,
      title: 'Ballı Sweet Chili Tavuk',
      isSecret: true,
      secretHint: '🥟 Dim Sum + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'creamy_soup',
      itemBCode: 'mushroom',
      result: GameItem.truffleCappuccinoSoup,
      title: 'Trüf Mantarı Köpüğü',
      isSecret: true,
      secretHint: '🥣 Kremalı Çorba + 🍄 Mantar',
    ),
    Recipe(
      itemACode: 'choco_donut',
      itemBCode: 'chocolate',
      result: GameItem.nutellaDonut,
      title: 'Çikolatalı Bomboloni Donut',
      isSecret: true,
      secretHint: '🍩 Çikolatalı Donut + 🍫 Çikolata',
    ),
    Recipe(
      itemACode: 'bubble_tea',
      itemBCode: 'vanilla_ice_cream',
      result: GameItem.matchaIceCream,
      title: 'Matcha Dondurması',
      isSecret: true,
      secretHint: '🧋 Bubble Tea + 🍨 Dondurma',
    ),
    Recipe(
      itemACode: 'milkshake',
      itemBCode: 'honey',
      result: GameItem.caramelPopcornShake,
      title: 'Ballı Karamel Milkshake',
      isSecret: true,
      secretHint: '🥤 Milkshake + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'french_fries',
      itemBCode: 'cheese',
      result: GameItem.cheesyFriesSupreme,
      title: 'Eritme Peynirli Çıtır Patates',
      isSecret: true,
      secretHint: '🍟 Patates Kızartması + 🧀 Peynir',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'olive',
      result: GameItem.oliveFocaccia,
      title: 'Zeytinli İtalyan Focaccia',
      isSecret: true,
      secretHint: '🍞 Fırın Ekmeği + 🫒 Zeytin',
    ),
    Recipe(
      itemACode: 'pepperoni_pizza',
      itemBCode: 'fried_egg',
      result: GameItem.sucukluYumurtaliPizza,
      title: 'Sahanda Sucuklu Kahvaltı Pizzası',
      isSecret: true,
      secretHint: '🍕 Sucuklu Pizza + 🍳 Sahanda Yumurta',
    ),
    Recipe(
      itemACode: 'chef_ramen',
      itemBCode: 'cheese',
      result: GameItem.ramenCarbonara,
      title: 'Peynirli Ramen Carbonara',
      isSecret: true,
      secretHint: '🍜 Şef Rameni + 🧀 Peynir',
    ),
    Recipe(
      itemACode: 'donut_dough',
      itemBCode: 'honey',
      result: GameItem.honeyGlazeDonut,
      title: 'Ballı Glaze Çıtır Donut',
      isSecret: true,
      secretHint: '🍩 Donut Hamuru + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'nutty_waffle',
      itemBCode: 'banana',
      result: GameItem.nutBananaWaffle,
      title: 'Fındıklı Muzlu Kral Waffle',
      isSecret: true,
      secretHint: '🧇 Fındıklı Waffle + 🍌 Muz',
    ),
    Recipe(
      itemACode: 'onion',
      itemBCode: 'french_fries',
      result: GameItem.onionRingsDeluxe,
      title: 'Çıtır Soğan Halkası Sepeti',
      isSecret: true,
      secretHint: '🧅 Soğan + 🍟 Patates Kızartması',
    ),
    Recipe(
      itemACode: 'taco',
      itemBCode: 'pepper',
      result: GameItem.tacoSupremeHot,
      title: 'Alevli Supreme Taco',
      isSecret: true,
      secretHint: '🌮 Taco + 🫑 Köy Biberi',
    ),
    Recipe(
      itemACode: 'triple_monster_burger',
      itemBCode: 'pepper',
      result: GameItem.volcanoBurger,
      title: 'Yanardağ Biberli Burger',
      isSecret: true,
      secretHint: '🍔 Monster Burger + 🫑 Biber',
    ),
    Recipe(
      itemACode: 'latte',
      itemBCode: 'nuts',
      result: GameItem.icedLatteHazelnut,
      title: 'Fındık Şuruplu Buzlu Latte',
      isSecret: true,
      secretHint: '☕ Latte + 🥜 Fındık',
    ),
    Recipe(
      itemACode: 'strawberry',
      itemBCode: 'bubble_tea',
      result: GameItem.strawberryMatcha,
      title: 'Çilekli Buzlu Matcha',
      isSecret: true,
      secretHint: '🍓 Çilek + 🧋 Bubble Tea',
    ),
    Recipe(
      itemACode: 'bubble_tea',
      itemBCode: 'honey',
      result: GameItem.goldenMilkTea,
      title: 'Ballı Kraliyet Boba Tea',
      isSecret: true,
      secretHint: '🧋 Bubble Tea + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'iskender',
      itemBCode: 'mushroom',
      result: GameItem.gourmetMushroomKebab,
      title: 'Mantarlı Sultan Kebabı',
      isSecret: true,
      secretHint: '🥙 İskender Kebap + 🍄 Mantar',
    ),
    Recipe(
      itemACode: 'tomato_soup',
      itemBCode: 'mushroom',
      result: GameItem.creamyTrufflePasta,
      title: 'Trüf Mantarlı Kremalı Pasta',
      isSecret: true,
      secretHint: '🍲 Domates Çorbası + 🍄 Mantar',
    ),
    Recipe(
      itemACode: 'pepperoni_pizza',
      itemBCode: 'baked_bread',
      result: GameItem.pepperoniCalzone,
      title: 'Sucuklu Kapalı Calzone',
      isSecret: true,
      secretHint: '🍕 Sucuklu Pizza + 🍞 Fırın Ekmeği',
    ),
    Recipe(
      itemACode: 'durum_doner',
      itemBCode: 'cheese',
      result: GameItem.donerDurumSpecial,
      title: 'Kaşarlı Fırın Dürüm Döner',
      isSecret: true,
      secretHint: '🥙 Dürüm Döner + 🧀 Peynir',
    ),
    Recipe(
      itemACode: 'plain_croissant',
      itemBCode: 'nuts',
      result: GameItem.pistachioCroissant,
      title: 'Fıstık Dolgulu Çıtır Kruvasan',
      isSecret: true,
      secretHint: '🥐 Kruvasan + 🥜 Antep Fıstığı',
    ),
    Recipe(
      itemACode: 'chocolate',
      itemBCode: 'banana',
      result: GameItem.chocolateFondue,
      title: 'Muzlu Çikolata Şelalesi',
      isSecret: true,
      secretHint: '🍫 Çikolata + 🍌 Muz',
    ),
    Recipe(
      itemACode: 'caramel_macchiato',
      itemBCode: 'honey',
      result: GameItem.caramelMacchiatoSpecial,
      title: 'Ballı Karamel Macchiato',
      isSecret: true,
      secretHint: '☕ Karamel Macchiato + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'cooked_patty',
      result: GameItem.cheddarHotDog,
      title: 'Çedar Soslu Gurme Sosisli',
      isSecret: true,
      secretHint: '🍞 Fırın Ekmeği + 🥩 Köfte',
    ),
    Recipe(
      itemACode: 'burger',
      itemBCode: 'onion',
      result: GameItem.crispyOnionBurger,
      title: 'Çıtır Karamelize Soğan Burgeri',
      isSecret: true,
      secretHint: '🍔 Burger + 🧅 Kırmızı Soğan',
    ),
    Recipe(
      itemACode: 'potato',
      itemBCode: 'cheese',
      result: GameItem.potatoKumpirRoyal,
      title: 'Kaşarlı Tereyağlı Kral Kumpir',
      isSecret: true,
      secretHint: '🥔 Patates + 🧀 Kaşar Peyniri',
    ),
    Recipe(
      itemACode: 'potato',
      itemBCode: 'honey',
      result: GameItem.sweetPotatoFries,
      title: 'Ballı Çıtır Tatlı Patates',
      isSecret: true,
      secretHint: '🥔 Patates + 🍯 Süzme Bal',
    ),
    Recipe(
      itemACode: 'sucuk_fried_egg',
      itemBCode: 'pepper',
      result: GameItem.sucukluMenemen,
      title: 'Sucuklu Biberli Sıcak Menemen',
      isSecret: true,
      secretHint: '🍳 Sucuklu Yumurta + 🫑 Köy Biberi',
    ),
    Recipe(
      itemACode: 'chopped_tomato',
      itemBCode: 'olive',
      result: GameItem.mediterraneanSalad,
      title: 'Zeytinli Akdeniz Salatası',
      isSecret: true,
      secretHint: '🥣 Doğranmış Domates + 🫒 Zeytin',
    ),
    Recipe(
      itemACode: 'smoothie',
      itemBCode: 'nuts',
      result: GameItem.bananaNutSmoothie,
      title: 'Fıstıklı Muzlu Enerji Smoothie',
      isSecret: true,
      secretHint: '🥤 Smoothie + 🥜 Fındık',
    ),
    Recipe(
      itemACode: 'pancake',
      itemBCode: 'strawberry',
      result: GameItem.strawberryCrepe,
      title: 'Çilekli Fransız Çıtır Krep',
      isSecret: true,
      secretHint: '🥞 Pankek + 🍓 Çilek',
    ),
    Recipe(
      itemACode: 'choco_grand_cake',
      itemBCode: 'nuts',
      result: GameItem.nuttyChocolateBrownie,
      title: 'Fındıklı Sıcak Çikolatalı Sufle',
      isSecret: true,
      secretHint: '👑 Katlı Pasta + 🥜 Fındık',
    ),
    Recipe(
      itemACode: 'lemonade',
      itemBCode: 'honey',
      result: GameItem.honeyLimeTea,
      title: 'Ballı Nane Limon Çayı',
      isSecret: true,
      secretHint: '🍹 Limonata + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'nachos',
      itemBCode: 'pepper',
      result: GameItem.chiliCheeseNachos,
      title: 'Eritme Peynirli Alevli Nachos',
      isSecret: true,
      secretHint: '🧀 Nachos + 🫑 Acı Biber',
    ),
    Recipe(
      itemACode: 'bacon_burger',
      itemBCode: 'sucuk',
      result: GameItem.bbqBaconBurger,
      title: 'Füme Sucuklu BBQ Burger',
      isSecret: true,
      secretHint: '🍔 Bacon Burger + 🥓 Sucuk',
    ),
    Recipe(
      itemACode: 'cheese',
      itemBCode: 'baked_bread',
      result: GameItem.mozzarellaSticks,
      title: 'Çıtır Altın Mozzarella Çubukları',
      isSecret: true,
      secretHint: '🧀 Peynir + 🍞 Fırın Ekmeği',
    ),
    Recipe(
      itemACode: 'strawberry_donut',
      itemBCode: 'strawberry',
      result: GameItem.berryDonutSplit,
      title: 'Orman Meyveli Dolgulu Donut',
      isSecret: true,
      secretHint: '🍩 Çilekli Donut + 🍓 Çilek',
    ),
    Recipe(
      itemACode: 'espresso',
      itemBCode: 'chocolate',
      result: GameItem.turkishCoffeeDelight,
      title: 'Çikolatalı Sultan Türk Kahvesi',
      isSecret: true,
      secretHint: '☕ Espresso + 🍫 Çikolata',
    ),
    Recipe(
      itemACode: 'baked_bread',
      itemBCode: 'onion',
      result: GameItem.garlicHerbBread,
      title: 'Karamelize Soğanlı Çıtır Ekmek',
      isSecret: true,
      secretHint: '🍞 Fırın Ekmeği + 🧅 Kırmızı Soğan',
    ),
    Recipe(
      itemACode: 'ramen_noodles',
      itemBCode: 'pepper',
      result: GameItem.spicyRamenFire,
      title: 'Yanardağ Acılı Gurme Ramen',
      isSecret: true,
      secretHint: '🍜 Ramen Eriştesi + 🫑 Köy Biberi',
    ),
    Recipe(
      itemACode: 'bubble_tea',
      itemBCode: 'strawberry',
      result: GameItem.dragonFruitTea,
      title: 'Çilekli Tropikal Boba Tea',
      isSecret: true,
      secretHint: '🧋 Bubble Tea + 🍓 Çilek',
    ),
    Recipe(
      itemACode: 'meat_pilaf',
      itemBCode: 'honey',
      result: GameItem.honeyGlazedKebab,
      title: 'Ballı Nar Ekşili Zırh Kebabı',
      isSecret: true,
      secretHint: '🍚 Etli Pilav + 🍯 Bal',
    ),
    Recipe(
      itemACode: 'olive',
      itemBCode: 'baked_bread',
      result: GameItem.oliveTapenadeToast,
      title: 'Zeytin Ezmeli İtalyan Bruschetta',
      isSecret: true,
      secretHint: '🫒 Siyah Zeytin + 🍞 Fırın Ekmeği',
    ),
  ];

  static List<Recipe> get recipes => [...standardRecipes, ...secretRecipes];

  static Recipe? findRecipe(String codeA, String codeB) {
    for (final recipe in recipes) {
      if (recipe.matches(codeA, codeB)) {
        return recipe;
      }
    }
    return null;
  }

  static GameItem? getMergeResult(String codeA, String codeB) {
    return findRecipe(codeA, codeB)?.result;
  }

  static List<Recipe> getStepsFor(String targetCode) {
    final List<Recipe> steps = [];

    void resolve(String code) {
      final recipe = recipes.where((r) => r.result.code == code).firstOrNull;
      if (recipe != null) {
        resolve(recipe.itemACode);
        resolve(recipe.itemBCode);
        if (!steps.any((s) => s.result.code == recipe.result.code)) {
          steps.add(recipe);
        }
      }
    }

    resolve(targetCode);
    return steps;
  }

  static Map<String, int> getRawIngredientsRequirements(String targetCode) {
    final Map<String, int> counts = {};

    void resolve(String code) {
      final item = GameItem.findByCode(code);
      if (item != null && item.category == ItemCategory.raw) {
        counts[code] = (counts[code] ?? 0) + 1;
        return;
      }
      final recipe = recipes.where((r) => r.result.code == code).firstOrNull;
      if (recipe != null) {
        resolve(recipe.itemACode);
        resolve(recipe.itemBCode);
      } else {
        counts[code] = (counts[code] ?? 0) + 1;
      }
    }

    resolve(targetCode);
    return counts;
  }
}
