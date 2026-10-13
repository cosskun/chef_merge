import 'package:flutter/material.dart';
import '../services/localization_service.dart';

enum ItemCategory { raw, processed, meal }

class GameItem {
  final String id;
  final String code;
  final String name;
  final String emoji;
  final int level;
  final ItemCategory category;
  final Color primaryColor;
  final Color accentColor;
  final String description;
  final String? imageAsset;

  const GameItem({
    required this.id,
    required this.code,
    required this.name,
    required this.emoji,
    required this.level,
    required this.category,
    required this.primaryColor,
    required this.accentColor,
    required this.description,
    this.imageAsset,
  });

  String get localizedName => LocalizationService.getItemName(id, name);

  // =================== 1. DOMATES & ÇORBA SERİSİ ===================
  static const GameItem rawTomato = GameItem(
    id: 'raw_tomato',
    code: 'raw_tomato',
    name: 'Domates',
    emoji: '🍅',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFEF5350),
    accentColor: Color(0xFFFFCDD2),
    description: 'Taze dalından koparılmış sulu domates.',
    imageAsset: 'assets/items/raw_tomato.png',
  );

  static const GameItem choppedTomato = GameItem(
    id: 'chopped_tomato',
    code: 'chopped_tomato',
    name: 'Doğranmış Domates',
    emoji: '🥫',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFE53935),
    accentColor: Color(0xFFFF8A80),
    description: 'Özenle küp küp doğranmış sulu domatesler.',
    imageAsset: 'assets/items/chopped_tomato.png',
  );

  static const GameItem tomatoSoup = GameItem(
    id: 'tomato_soup',
    code: 'tomato_soup',
    name: 'Domates Çorbası',
    emoji: '🍲',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD32F2F),
    accentColor: Color(0xFFFF5252),
    description: 'Sıcak, fesleğenli nefis domates çorbası!',
    imageAsset: 'assets/items/tomato_soup.png',
  );

  static const GameItem creamySoup = GameItem(
    id: 'creamy_soup',
    code: 'creamy_soup',
    name: 'Kremalı Çorba',
    emoji: '🫕',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF7043),
    accentColor: Color(0xFFFFCCBC),
    description: 'Süt kremasıyla yumuşatılmış gurme domates çorbası!',
    imageAsset: 'assets/items/creamy_soup.png',
  );

  static const GameItem onionSoup = GameItem(
    id: 'onion_soup',
    code: 'onion_soup',
    name: 'Karamelize Soğan Çorbası',
    emoji: '🥣',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFD7CCC8),
    description: 'Karamelize soğanlar ve et suyuyla pişmiş nefis Fransız çorbası!',
    imageAsset: 'assets/items/onion_soup.png',
  );

  static const GameItem carrot = GameItem(
    id: 'carrot',
    code: 'carrot',
    name: 'Taze Havuç',
    emoji: '🥕',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFF9800),
    accentColor: Color(0xFFFFE0B2),
    description: 'Kıtır kıtır taze tarla havucu.',
    imageAsset: 'assets/items/carrot.png',
  );

  static const GameItem carrotSoup = GameItem(
    id: 'carrot_soup',
    code: 'carrot_soup',
    name: 'Havuç Çorbası',
    emoji: '🥘',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFB8C00),
    accentColor: Color(0xFFFFCC80),
    description: 'Taze havuç püresi ve tereyağıyla zenginleştirilmiş nefis sıcak çorba!',
    imageAsset: 'assets/items/carrot_soup.png',
  );

  static const GameItem mushroomSoup = GameItem(
    id: 'mushroom_soup',
    code: 'mushroom_soup',
    name: 'Mantar Çorbası',
    emoji: '🍵',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFD7CCC8),
    description: 'Taze mantarlarla hazırlanmış nefis sıcak mantar çorbası!',
    imageAsset: 'assets/items/mushroom_soup.png',
  );

  static const GameItem gardenSoup = GameItem(
    id: 'garden_soup',
    code: 'garden_soup',
    name: 'Şefin Zengin Bahçe Çorbası',
    emoji: '🥗',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF43A047),
    accentColor: Color(0xFFC8E6C9),
    description: 'Domates, havuç, mantar ve soğanın buluştuğu şifa deposu sebze çorbası!',
    imageAsset: 'assets/items/garden_soup.png',
  );

  static const GameItem clubSandwich = GameItem(
    id: 'club_sandwich',
    code: 'club_sandwich',
    name: '3 Katlı Kulüp Sandviç',
    emoji: '🥪',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF8F00),
    accentColor: Color(0xFFFFE082),
    description: '3 kat kızarmış ekmek, kaşar, sucuk, yumurta ve avokadolu dev sandviç!',
    imageAsset: 'assets/items/club_sandwich.png',
  );

  static const GameItem veggiePilaf = GameItem(
    id: 'veggie_pilaf',
    code: 'veggie_pilaf',
    name: 'Renkli Sebzeli Pilav',
    emoji: '🍛',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF7CB342),
    accentColor: Color(0xFFDCEDC8),
    description: 'Havuç, biber ve tereyağı ile kavrulmuş nefis tane tane sebzeli pilav!',
    imageAsset: 'assets/items/veggie_pilaf.png',
  );

  // =================== 12. İTALYAN MAKARNA & LAZANYA SERİSİ ===================
  static const GameItem pastaDough = GameItem(
    id: 'pasta_dough',
    code: 'pasta_dough',
    name: 'Taze Makarna Hamuru',
    emoji: '🥢',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFD54F),
    accentColor: Color(0xFFFFF9C4),
    description: 'İrmik ve yumurtayla yoğrulmuş taze İtalyan makarna hamuru.',
    imageAsset: 'assets/items/pasta_dough.png',
  );

  static const GameItem spaghetti = GameItem(
    id: 'spaghetti',
    code: 'spaghetti',
    name: 'Taze Spagetti',
    emoji: '🍝',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFFCA28),
    accentColor: Color(0xFFFFF8E1),
    description: 'Haşlanmış al dente taze İtalyan spagettisi.',
    imageAsset: 'assets/items/spaghetti.png',
  );

  static const GameItem napoliPasta = GameItem(
    id: 'napoli_pasta',
    code: 'napoli_pasta',
    name: 'Napoliten Soslu Makarna',
    emoji: '🌿',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD32F2F),
    accentColor: Color(0xFFFFCDD2),
    description: 'Taze domates ve fesleğen soslu klasik Napoli makarnası!',
    imageAsset: 'assets/items/napoli_pasta.png',
  );

  static const GameItem bolognesePasta = GameItem(
    id: 'bolognese_pasta',
    code: 'bolognese_pasta',
    name: 'Bolonez Soslu Spagetti',
    emoji: '🥘',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFFAB91),
    description: 'Kıymalı zengin Bolonez sosu ve parmesanlı nefis spagetti!',
    imageAsset: 'assets/items/bolognese_pasta.png',
  );

  static const GameItem lasagna = GameItem(
    id: 'lasagna',
    code: 'lasagna',
    name: 'Fırında Bolonez Lazanya',
    emoji: '🥮',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF880E4F),
    accentColor: Color(0xFFFFD54F),
    description: 'Kat kat makarna yaprakları, bolonez sos ve fırınlanmış eritme peynir!',
    imageAsset: 'assets/items/lasagna.png',
  );

  // =================== 13. SİMİT, LAHMACUN & PİDE SERİSİ ===================
  static const GameItem sesame = GameItem(
    id: 'sesame',
    code: 'sesame',
    name: 'Kavrulmuş Susam',
    emoji: '🌱',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFFFF8E1),
    description: 'Altın sarısı kavrulmuş mis kokulu sokak susamı.',
    imageAsset: 'assets/items/sesame.png',
  );

  static const GameItem simit = GameItem(
    id: 'simit',
    code: 'simit',
    name: 'Çıtır Sokak Simidi',
    emoji: '🥨',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    description: 'Taş fırından yeni çıkmış, bol susamlı çıtır sokak simidi!',
    imageAsset: 'assets/items/simit.png',
  );

  static const GameItem cheeseSimit = GameItem(
    id: 'cheese_simit',
    code: 'cheese_simit',
    name: 'Kaşarlı Fırın Simidi',
    emoji: '🥯',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57C00),
    accentColor: Color(0xFFFFE082),
    description: 'Ortasında erimiş taze kaşar peyniriyle sıcacık simit!',
    imageAsset: 'assets/items/cheese_simit.png',
  );

  static const GameItem lahmacun = GameItem(
    id: 'lahmacun',
    code: 'lahmacun',
    name: 'Taş Fırın Lahmacun',
    emoji: '🫓',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFAB91),
    description: 'İncecik çıtır hamur üzerinde baharatlı kıymalı harç ve maydanoz!',
    imageAsset: 'assets/items/lahmacun.png',
  );

  static const GameItem pide = GameItem(
    id: 'pide',
    code: 'pide',
    name: 'Kıymalı Kaşarlı Pide',
    emoji: '🥖',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFBF360C),
    accentColor: Color(0xFFFFD54F),
    description: 'Odun ateşinde pişmiş tereyağlı Karadeniz pidesi!',
    imageAsset: 'assets/items/pide.png',
  );

  static const GameItem baklava = GameItem(
    id: 'baklava',
    code: 'baklava',
    name: 'Fıstıklı Antep Baklavası',
    emoji: '🍯',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF689F38),
    accentColor: Color(0xFFFFD54F),
    description: '40 kat ince yufka, bol Antep fıstığı ve hakiki tereyağlı şerbetli saray baklavası!',
    imageAsset: 'assets/items/baklava.png',
  );

  // =================== 14. ÇITIR TAVUK & WINGS SERİSİ ===================
  static const GameItem rawChicken = GameItem(
    id: 'raw_chicken',
    code: 'raw_chicken',
    name: 'Taze Tavuk Göğsü',
    emoji: '🍗',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFB74D),
    accentColor: Color(0xFFFFF3E0),
    description: 'Özel baharatlarla marine edilmiş taze tavuk eti.',
    imageAsset: 'assets/items/raw_chicken.png',
  );

  static const GameItem chickenNugget = GameItem(
    id: 'chicken_nugget',
    code: 'chicken_nugget',
    name: 'Altın Çıtır Nugget',
    emoji: '🧆',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFA000),
    accentColor: Color(0xFFFFECB3),
    description: 'Dışı çıtır paneli, içi yumuşacık altın tavuk nugget!',
    imageAsset: 'assets/items/chicken_nugget.png',
  );

  static const GameItem chickenBucket = GameItem(
    id: 'chicken_bucket',
    code: 'chicken_bucket',
    name: 'Çıtır Tavuk Kovası & Patates',
    emoji: '🍿',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    description: 'Bol nugget ve çıtır patatesli büyük boy kova menüsü!',
    imageAsset: 'assets/items/chicken_bucket.png',
  );

  static const GameItem crispyChickenBurger = GameItem(
    id: 'crispy_chicken_burger',
    code: 'crispy_chicken_burger',
    name: 'Zinger Çıtır Tavuk Burger',
    emoji: '🍔',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFD54F),
    description: 'Çıtır tavuk fileto, cheddar ve mayonezli nefis tavuk burger!',
    imageAsset: 'assets/items/crispy_chicken_burger.png',
  );

  static const GameItem buffaloWings = GameItem(
    id: 'buffalo_wings',
    code: 'buffalo_wings',
    name: 'Buffalo Soslu Acılı Kanatlar',
    emoji: '🔥',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC62828),
    accentColor: Color(0xFFFF8A80),
    description: 'Acı tatlı barbekü sosuna bulanmış çıtır fırın tavuk kanatları!',
    imageAsset: 'assets/items/buffalo_wings.png',
  );

  // =================== 15. KUMPİR & HOT DOG SERİSİ ===================
  static const GameItem sausage = GameItem(
    id: 'sausage',
    code: 'sausage',
    name: 'Dana Sosis',
    emoji: '🌭',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFD32F2F),
    accentColor: Color(0xFFFFCDD2),
    description: 'Fırınlanmış lezzetli dana sosis.',
    imageAsset: 'assets/items/sausage.png',
  );

  static const GameItem hotDog = GameItem(
    id: 'hot_dog',
    code: 'hot_dog',
    name: 'Klasik Hot Dog',
    emoji: '🥪',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE64A19),
    accentColor: Color(0xFFFFCCBC),
    description: 'Yumuşak sandviç ekmeğinde hardallı klasik sosisli sandviç!',
    imageAsset: 'assets/items/cheddar_hot_dog.png',
  );

  static const GameItem kumpirBase = GameItem(
    id: 'kumpir_base',
    code: 'kumpir_base',
    name: 'Kaşarlı Kumpir Tabanı',
    emoji: '🍠',
    level: 3,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFBC02D),
    accentColor: Color(0xFFFFF9C4),
    description: 'Közde pişmiş dev patatesin tereyağı ve kaşarla ezilmiş tabanı.',
    imageAsset: 'assets/items/kumpir_base.png',
  );

  static const GameItem ortakoyKumpir = GameItem(
    id: 'ortakoy_kumpir',
    code: 'ortakoy_kumpir',
    name: 'Ortaköy Dev Karışık Kumpir',
    emoji: '🥔',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF6F00),
    accentColor: Color(0xFFFFD54F),
    description: 'Sosis, mısır, zeytin ve soslarla tepeleme dolu Ortaköy kumpiri!',
    imageAsset: 'assets/items/ortakoy_kumpir.png',
  );

  // =================== 16. KÜNEFE & SÜTLAÇ SERİSİ ===================
  static const GameItem ricePudding = GameItem(
    id: 'rice_pudding',
    code: 'rice_pudding',
    name: 'Fırın Sütlaç',
    emoji: '🍮',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFFFF8E1),
    description: 'Üzeri nar gibi kızarmış geleneksel fırın sütlacı.',
    imageAsset: 'assets/items/rice_pudding.png',
  );

  static const GameItem kunefe = GameItem(
    id: 'kunefe',
    code: 'kunefe',
    name: 'Sıcak Peynirli Künefe',
    emoji: '🥧',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFE082),
    description: 'Tereyağlı tel kadayıf arasında uzayan Hatay peyniri ve şerbet!',
    imageAsset: 'assets/items/kunefe.png',
  );

  static const GameItem dondurmaliKunefe = GameItem(
    id: 'dondurmali_kunefe',
    code: 'dondurmali_kunefe',
    name: 'Dondurmalı Saray Künefesi',
    emoji: '🍨',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFAD1457),
    accentColor: Color(0xFFFFD54F),
    description: 'Cızırdayan sıcak künefe üzerinde kesme Maraş dondurması ve Antep fıstığı!',
    imageAsset: 'assets/items/kunefe.png',
  );

  // =================== 17. AKDENİZ & EGE ÇITIR MEZE SOFRASI ===================
  static const GameItem calamari = GameItem(
    id: 'calamari',
    code: 'calamari',
    name: 'Taze Kalamar',
    emoji: '🦑',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFE040FB),
    accentColor: Color(0xFFF8BBD0),
    description: 'Ege denizinden taptaze temizlenmiş kalamar halkaları.',
    imageAsset: 'assets/items/calamari.png',
  );

  static const GameItem tarator = GameItem(
    id: 'tarator',
    code: 'tarator',
    name: 'Sarımsaklı Tarator Sosu',
    emoji: '🧄',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFF9C4),
    accentColor: Color(0xFFFFFDE7),
    description: 'Ceviz, sarımsak ve süzme yoğurtla çırpılmış efsane Ege tarator sosu.',
    imageAsset: 'assets/items/tarator.png',
  );

  static const GameItem calamariFritti = GameItem(
    id: 'calamari_fritti',
    code: 'calamari_fritti',
    name: 'Çıtır Kalamar Tava',
    emoji: '🍤',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFB300),
    accentColor: Color(0xFFFFF59D),
    description: 'Altın sarısı çıtır kızarmış kalamar halkaları ve tarator sos!',
    imageAsset: 'assets/items/calamari_fritti.png',
  );

  static const GameItem eggplant = GameItem(
    id: 'eggplant',
    code: 'eggplant',
    name: 'Kemer Patlıcan',
    emoji: '🍆',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF4A148C),
    accentColor: Color(0xFFE1BEE7),
    description: 'Közlemelik ve kızartmalık taze kemer patlıcan.',
    imageAsset: 'assets/items/eggplant.png',
  );

  static const GameItem saksuka = GameItem(
    id: 'saksuka',
    code: 'saksuka',
    name: 'Zeytinyağlı Şakşuka',
    emoji: '🫑',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD32F2F),
    accentColor: Color(0xFFFFCDD2),
    description: 'Kızarmış patlıcan, biber ve sarımsaklı domates soslu Ege mezesi!',
    imageAsset: 'assets/items/saksuka.png',
  );

  static const GameItem garlicShrimp = GameItem(
    id: 'garlic_shrimp',
    code: 'garlic_shrimp',
    name: 'Güveçte Tereyağlı Karides',
    emoji: '🦐',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF6F00),
    accentColor: Color(0xFFFFE082),
    description: 'Toprak güveçte cızırdayan sarımsaklı tereyağlı çıtır karides!',
    imageAsset: 'assets/items/garlic_shrimp.png',
  );

  static const GameItem aegeanMezzePlatter = GameItem(
    id: 'aegean_mezze_platter',
    code: 'aegean_mezze_platter',
    name: 'Ege Kıyıları Meze Şöleni',
    emoji: '🦀',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF00897B),
    accentColor: Color(0xFF80CBC4),
    description: 'Kalamar tava, şakşuka, tereyağlı karides ve taze otlarla krallara layık meze sofrası!',
    imageAsset: 'assets/items/aegean_mezze.png',
  );

  // =================== 18. GELENEKSEL TENCERE & SARAY YEMEKLERİ ===================
  static const GameItem sauteedMeat = GameItem(
    id: 'sauteed_meat',
    code: 'sauteed_meat',
    name: 'Lokum Dana Et Sote',
    emoji: '🍖',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFD7CCC8),
    description: 'Kendi suyunda ağır ağır pişmiş yumuşacık lokum et sote.',
    imageAsset: 'assets/items/sauteed_meat.png',
  );

  static const GameItem begendiPuree = GameItem(
    id: 'begendi_puree',
    code: 'begendi_puree',
    name: 'Köz Patlıcan Beğendi',
    emoji: '🥣',
    level: 3,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFFCA28),
    accentColor: Color(0xFFFFF8E1),
    description: 'Közlenmiş patlıcan, tereyağı, süt ve kaşarla ezilmiş ipeksi beğendi püresi.',
    imageAsset: 'assets/items/begendi_puree.png',
  );

  static const GameItem hunkarBegendi = GameItem(
    id: 'hunkar_begendi',
    code: 'hunkar_begendi',
    name: 'Hünkar Beğendi',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF880E4F),
    accentColor: Color(0xFFFFD54F),
    description: 'İpeksi köz patlıcan beğendi yatağında lokum dana et sote şöleni!',
    imageAsset: 'assets/items/hunkar_begendi.png',
  );

  static const GameItem aliNazik = GameItem(
    id: 'ali_nazik',
    code: 'ali_nazik',
    name: 'Sarımsaklı Ali Nazik Kebabı',
    emoji: '🍲',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC62828),
    accentColor: Color(0xFFFFEBEE),
    description: 'Sarımsaklı süzme yoğurtlu köz patlıcan üzerinde tereyağlı et sote!',
    imageAsset: 'assets/items/ali_nazik.png',
  );

  static const GameItem ormanKebabi = GameItem(
    id: 'orman_kebabi',
    code: 'orman_kebabi',
    name: 'Geleneksel Orman Kebabı',
    emoji: '🥘',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    description: 'Kuşbaşı et, bezelye, havuç ve patatesle fırınlanmış sulu orman kebabı!',
    imageAsset: 'assets/items/orman_kebabi.png',
  );

  // =================== 2. EKMEK / TOST / PİZZA SERİSİ ===================
  static const GameItem rawBread = GameItem(
    id: 'raw_bread',
    code: 'raw_bread',
    name: 'Hamur',
    emoji: '🌾',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFB74D),
    accentColor: Color(0xFFFFE0B2),
    description: 'Taptaze mayalanmış hamur.',
    imageAsset: 'assets/items/raw_bread.png',
  );

  static const GameItem bakedBread = GameItem(
    id: 'baked_bread',
    code: 'baked_bread',
    name: 'Fırın Ekmeği',
    emoji: '🍞',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFFA726),
    accentColor: Color(0xFFFFCC80),
    description: 'Altın sarısı pişmiş çıtır fırın ekmeği.',
    imageAsset: 'assets/items/baked_bread.png',
  );

  static const GameItem cheese = GameItem(
    id: 'cheese',
    code: 'cheese',
    name: 'Kaşar Peyniri',
    emoji: '🧀',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFD54F),
    accentColor: Color(0xFFFFF9C4),
    description: 'Eritmelik taze kaşar peyniri dilimi.',
    imageAsset: 'assets/items/cheese.png',
  );

  static const GameItem toast = GameItem(
    id: 'toast',
    code: 'toast',
    name: 'Kaşarlı Tost',
    emoji: '🥪',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF9800),
    accentColor: Color(0xFFFFE082),
    description: 'Dışı çıtır, içi uzayan sıcacık kaşarlı tost!',
    imageAsset: 'assets/items/toast.png',
  );

  static const GameItem sucukToast = GameItem(
    id: 'sucuk_toast',
    code: 'sucuk_toast',
    name: 'Sucuklu Karışık Tost',
    emoji: '🥓',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFAB91),
    description: 'Bol sucuklu ve kaşarlı nefis büfe tostu!',
    imageAsset: 'assets/items/sucuk_toast.png',
  );

  static const GameItem pizzaBase = GameItem(
    id: 'pizza_base',
    code: 'pizza_base',
    name: 'Pizza Tabanı',
    emoji: '🫓',
    level: 3,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFF8A65),
    accentColor: Color(0xFFFFCCBC),
    description: 'Soslanmış nefis ince hamur pizza tabanı.',
    imageAsset: 'assets/items/pizza_base.png',
  );

  static const GameItem pizza = GameItem(
    id: 'pizza',
    code: 'pizza',
    name: 'Margherita Pizza',
    emoji: '🍕',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE64A19),
    accentColor: Color(0xFFFF8A80),
    description: 'Taş fırında pişmiş bol peynirli klasik Margherita pizza!',
    imageAsset: 'assets/items/pizza.png',
  );

  static const GameItem pepperoniPizza = GameItem(
    id: 'pepperoni_pizza',
    code: 'pepperoni_pizza',
    name: 'Sucuklu Pizza',
    emoji: '🥓',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC62828),
    accentColor: Color(0xFFFF8A80),
    description: 'Bol dilim sucuklu ve kaşarlı çıtır İtalyan pizzası!',
    imageAsset: 'assets/items/pepperoni_pizza.png',
  );

  static const GameItem mushroomPizza = GameItem(
    id: 'mushroom_pizza',
    code: 'mushroom_pizza',
    name: 'Mantarlı Pizza',
    emoji: '🍄',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFD7CCC8),
    description: 'Taze mantar ve kekikli nefis fırın pizzası!',
    imageAsset: 'assets/items/mushroom_pizza.png',
  );

  static const GameItem mediterraneanPizza = GameItem(
    id: 'mediterranean_pizza',
    code: 'mediterranean_pizza',
    name: 'Akdeniz Pizzası',
    emoji: '🫒',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF2E7D32),
    accentColor: Color(0xFFA5D6A7),
    description: 'Siyah zeytin, biber ve taze peynirli Akdeniz lezzeti!',
    imageAsset: 'assets/items/mediterranean_pizza.png',
  );

  static const GameItem fourCheesePizza = GameItem(
    id: 'four_cheese_pizza',
    code: 'four_cheese_pizza',
    name: 'Dört Peynirli Pizza',
    emoji: '🧀',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFFFF59D),
    description: 'Mozzarella, parmesan, gorgonzola ve kaşar harmanı gurme pizza!',
    imageAsset: 'assets/items/four_cheese_pizza.png',
  );

  static const GameItem supremePizza = GameItem(
    id: 'supreme_pizza',
    code: 'supreme_pizza',
    name: 'Mega Şef Pizzası',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFBF360C),
    accentColor: Color(0xFFFFAB91),
    description: 'Sucuk, mantar, zeytin, biber ve duble peynirli dev şef pizzası!',
    imageAsset: 'assets/items/supreme_pizza.png',
  );

  // =================== 3. YENİ HAMMADDELER (SEBZE, BAHARAT, MEYVE) ===================
  static const GameItem sucuk = GameItem(
    id: 'sucuk',
    code: 'sucuk',
    name: 'Kangal Sucuk',
    emoji: '🥓',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFFCDD2),
    description: 'Baharatlı geleneksel dana sucuk.',
    imageAsset: 'assets/items/sucuk.png',
  );

  static const GameItem mushroom = GameItem(
    id: 'mushroom',
    code: 'mushroom',
    name: 'Taze Mantar',
    emoji: '🍄',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFD7CCC8),
    description: 'Doğal orman mantarı.',
    imageAsset: 'assets/items/mushroom.png',
  );

  static const GameItem olive = GameItem(
    id: 'olive',
    code: 'olive',
    name: 'Siyah Zeytin',
    emoji: '🫒',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF37474F),
    accentColor: Color(0xFFCFD8DC),
    description: 'Ege usulü salamura siyah zeytin.',
    imageAsset: 'assets/items/olive.png',
  );

  static const GameItem pepper = GameItem(
    id: 'pepper',
    code: 'pepper',
    name: 'Köy Biberi',
    emoji: '🫑',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF388E3C),
    accentColor: Color(0xFFC8E6C9),
    description: 'Çıtır çıtır taze yeşil biber.',
    imageAsset: 'assets/items/pepper.png',
  );

  static const GameItem banana = GameItem(
    id: 'banana',
    code: 'banana',
    name: 'Muz',
    emoji: '🍌',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFBC02D),
    accentColor: Color(0xFFFFF9C4),
    description: 'Tatlı ve aromatik yerli muz.',
    imageAsset: 'assets/items/banana.png',
  );

  static const GameItem honey = GameItem(
    id: 'honey',
    code: 'honey',
    name: 'Süzme Çiçek Balı',
    emoji: '🍯',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFA000),
    accentColor: Color(0xFFFFECB3),
    description: 'Altın renkli saf doğal bal.',
    imageAsset: 'assets/items/honey.png',
  );

  static const GameItem nuts = GameItem(
    id: 'nuts',
    code: 'nuts',
    name: 'Antep Fıstığı & Fındık',
    emoji: '🥜',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF689F38),
    accentColor: Color(0xFFDCEDC8),
    description: 'Kavrulmuş çıtır fıstık ve fındık parçaları.',
    imageAsset: 'assets/items/nuts.png',
  );

  static const GameItem onion = GameItem(
    id: 'onion',
    code: 'onion',
    name: 'Kırmızı Soğan',
    emoji: '🧅',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF8E24AA),
    accentColor: Color(0xFFE1BEE7),
    description: 'Karamelize etmelik tatlı kırmızı soğan.',
    imageAsset: 'assets/items/onion.png',
  );

  static const GameItem potato = GameItem(
    id: 'potato',
    code: 'potato',
    name: 'Taze Patates',
    emoji: '🥔',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFEFEBE9),
    description: 'Kızartmalık sarı patates.',
    imageAsset: 'assets/items/potato.png',
  );

  static const GameItem frenchFries = GameItem(
    id: 'french_fries',
    code: 'french_fries',
    name: 'Çıtır Patates Kızartması',
    emoji: '🍟',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFBC02D),
    accentColor: Color(0xFFFFF59D),
    description: 'Altın renginde kızarmış çıtır patates porsiyonu!',
    imageAsset: 'assets/items/french_fries.png',
  );

  static const GameItem donutDough = GameItem(
    id: 'donut_dough',
    code: 'donut_dough',
    name: 'Donut Hamuru',
    emoji: '🥯',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFF8A65),
    accentColor: Color(0xFFFFCCBC),
    description: 'Hafif ve pofuduk donut hamur halkası.',
    imageAsset: 'assets/items/donut_dough.png',
  );

  static const GameItem caramel = GameItem(
    id: 'caramel',
    code: 'caramel',
    name: 'Karamel Sosu',
    emoji: '🫗',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    description: 'Akışkan tereyağlı sıcak karamel sosu.',
    imageAsset: 'assets/items/caramel.png',
  );

  // =================== 4. KAHVE SERİSİ ===================
  static const GameItem rawCoffee = GameItem(
    id: 'raw_coffee',
    code: 'raw_coffee',
    name: 'Kahve Çekirdeği',
    emoji: '🫘',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFD7CCC8),
    description: 'Kavrulmuş aromatik Arabica kahve çekirdekleri.',
    imageAsset: 'assets/items/raw_coffee.png',
  );

  static const GameItem groundCoffee = GameItem(
    id: 'ground_coffee',
    code: 'ground_coffee',
    name: 'Öğütülmüş Kahve',
    emoji: '🫙',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFBCAAA4),
    description: 'İncecik taze çekilmiş kahve tozu.',
    imageAsset: 'assets/items/ground_coffee.png',
  );

  static const GameItem espresso = GameItem(
    id: 'espresso',
    code: 'espresso',
    name: 'Espresso',
    emoji: '☕',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF3E2723),
    accentColor: Color(0xFFA1887F),
    description: 'Koyu kıvamlı, zengin kremalı sert espresso shot.',
    imageAsset: 'assets/items/espresso.png',
  );

  static const GameItem americano = GameItem(
    id: 'americano',
    code: 'americano',
    name: 'Americano',
    emoji: '💧',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFBCAAA4),
    description: 'Sıcak su ile dengelenmiş taze filtre lezzeti.',
    imageAsset: 'assets/items/americano.png',
  );

  static const GameItem milk = GameItem(
    id: 'milk',
    code: 'milk',
    name: 'Taze Süt',
    emoji: '🥛',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF90CAF9),
    accentColor: Color(0xFFE3F2FD),
    description: 'Soğuk, tam yağlı taze çiftlik sütü.',
    imageAsset: 'assets/items/milk.png',
  );

  static const GameItem steamedMilk = GameItem(
    id: 'steamed_milk',
    code: 'steamed_milk',
    name: 'Köpürtülmüş Süt',
    emoji: '🍶',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF81D4FA),
    accentColor: Color(0xFFE1F5FE),
    description: 'Buharla ipeksi kıvama getirilmiş sıcak süt köpüğü.',
    imageAsset: 'assets/items/steamed_milk.png',
  );

  static const GameItem latte = GameItem(
    id: 'latte',
    code: 'latte',
    name: 'Latte',
    emoji: '☕',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFEFEBE9),
    description: 'Kadifemsi süt köpüğü ve espressonun kusursuz dansı!',
    imageAsset: 'assets/items/latte.png',
  );

  static const GameItem chocolate = GameItem(
    id: 'chocolate',
    code: 'chocolate',
    name: 'Belçika Çikolatası',
    emoji: '🍫',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFD7CCC8),
    description: 'Bitter Belçika çikolatası blokları.',
    imageAsset: 'assets/items/chocolate.png',
  );

  static const GameItem mocha = GameItem(
    id: 'mocha',
    code: 'mocha',
    name: 'Caffe Mocha',
    emoji: '🍫',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFFFCCBC),
    description: 'Çikolata sosu, espresso ve sütün büyüleyici uyumu!',
    imageAsset: 'assets/items/mocha.png',
  );

  static const GameItem caramelMacchiato = GameItem(
    id: 'caramel_macchiato',
    code: 'caramel_macchiato',
    name: 'Caramel Macchiato',
    emoji: '🍮',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFE0B2),
    description: 'Vanilyalı süt, espresso ve karamel ızgaralı nefis kahve!',
    imageAsset: 'assets/items/caramel_macchiato.png',
  );

  static const GameItem frappuccino = GameItem(
    id: 'frappuccino',
    code: 'frappuccino',
    name: 'Buzlu Frappe',
    emoji: '🍸',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFD7CCC8),
    description: 'Buz, kahve ve krema ile çalkalanmış ferahlatıcı frappe!',
    imageAsset: 'assets/items/frappuccino.png',
  );

  static const GameItem royalBarista = GameItem(
    id: 'royal_barista',
    code: 'royal_barista',
    name: 'Royal Barista Spesiyali',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF3E2723),
    accentColor: Color(0xFFFFD54F),
    description: 'Mocha, fındık karameli ve altın kremalı zirve kahve!',
    imageAsset: 'assets/items/royal_barista.png',
  );

  // =================== 5. KRUVASAN SERİSİ ===================
  static const GameItem croissantDough = GameItem(
    id: 'croissant_dough',
    code: 'croissant_dough',
    name: 'Kruvasan Hamuru',
    emoji: '🥟',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFCC80),
    accentColor: Color(0xFFFFF3E0),
    description: 'Kat kat açılmış Fransız milföy hamuru.',
    imageAsset: 'assets/items/croissant_dough.png',
  );

  static const GameItem butter = GameItem(
    id: 'butter',
    code: 'butter',
    name: 'Köy Tereyağı',
    emoji: '🧈',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFF176),
    accentColor: Color(0xFFFFFDE7),
    description: 'Halis yayık tereyağı.',
    imageAsset: 'assets/items/butter.png',
  );

  static const GameItem plainCroissant = GameItem(
    id: 'plain_croissant',
    code: 'plain_croissant',
    name: 'Tereyağlı Kruvasan',
    emoji: '🥐',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFA726),
    accentColor: Color(0xFFFFE0B2),
    description: 'Fırından yeni çıkmış, çıtır çıtır Fransız tereyağlı kruvasanı!',
    imageAsset: 'assets/items/plain_croissant.png',
  );

  static const GameItem chocoCroissant = GameItem(
    id: 'choco_croissant',
    code: 'choco_croissant',
    name: 'Çikolatalı Kruvasan',
    emoji: '🍫',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFFFCC80),
    description: 'İçi bol erimiş çikolata dolgulu gurme kruvasan!',
    imageAsset: 'assets/items/choco_croissant.png',
  );

  static const GameItem strawberry = GameItem(
    id: 'strawberry',
    code: 'strawberry',
    name: 'Taze Çilek',
    emoji: '🍓',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFE91E63),
    accentColor: Color(0xFFF8BBD0),
    description: 'Kokulu, tatlı bahçe çileği.',
    imageAsset: 'assets/items/strawberry.png',
  );

  static const GameItem strawberryCroissant = GameItem(
    id: 'strawberry_croissant',
    code: 'strawberry_croissant',
    name: 'Çilekli Kruvasan',
    emoji: '🍓',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFAD1457),
    accentColor: Color(0xFFFF80AB),
    description: 'Vanilya kreması ve taze çileklerle süslenmiş şef kruvasanı!',
    imageAsset: 'assets/items/strawberry_croissant.png',
  );

  // =================== 6. MEKSİKA SERİSİ ===================
  static const GameItem tortilla = GameItem(
    id: 'tortilla',
    code: 'tortilla',
    name: 'Tortilla Lavaş',
    emoji: '🫓',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFE082),
    accentColor: Color(0xFFFFF8E1),
    description: 'Mısır unundan yapılmış esnek Meksika lavaşı.',
    imageAsset: 'assets/items/tortilla.png',
  );

  static const GameItem avocado = GameItem(
    id: 'avocado',
    code: 'avocado',
    name: 'Avokado',
    emoji: '🥑',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF558B2F),
    accentColor: Color(0xFFDCEDC8),
    description: 'Olgun, kremamsı taze avokado.',
    imageAsset: 'assets/items/avocado.png',
  );

  static const GameItem taco = GameItem(
    id: 'taco',
    code: 'taco',
    name: 'Çıtır Taco',
    emoji: '🌮',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFA000),
    accentColor: Color(0xFFFFECB3),
    description: 'Kıymalı, sebzeli ve soslu çıtır Meksika tacosu!',
    imageAsset: 'assets/items/taco.png',
  );

  static const GameItem burrito = GameItem(
    id: 'burrito',
    code: 'burrito',
    name: 'Dev Burrito',
    emoji: '🌯',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    description: 'Et, peynir ve sosla sıkıca sarılmış doyurucu burrito!',
    imageAsset: 'assets/items/burrito.png',
  );

  static const GameItem quesadilla = GameItem(
    id: 'quesadilla',
    code: 'quesadilla',
    name: 'Peynirli Quesadilla',
    emoji: '🧀',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFFFF59D),
    description: 'Tavada eritilmiş çift kaşarlı çıtır quesadilla!',
    imageAsset: 'assets/items/quesadilla.png',
  );

  static const GameItem guacamole = GameItem(
    id: 'guacamole',
    code: 'guacamole',
    name: 'Guacamole Sos',
    emoji: '🥣',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF689F38),
    accentColor: Color(0xFFDCEDC8),
    description: 'Avokado, domates ve limonla ezilmiş efsane sos!',
    imageAsset: 'assets/items/guacamole.png',
  );

  static const GameItem nachos = GameItem(
    id: 'nachos',
    code: 'nachos',
    name: 'Eritme Nachos',
    emoji: '🍿',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFB300),
    accentColor: Color(0xFFFFF3E0),
    description: 'Üzeri eritme cheddar ve soslarla kaplı çıtır mısır cipsi!',
    imageAsset: 'assets/items/nachos_supreme.png',
  );

  static const GameItem nachosSupreme = GameItem(
    id: 'nachos_supreme',
    code: 'nachos_supreme',
    name: 'Nachos Supreme',
    emoji: '🍲',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFD54F),
    description: 'Kıymalı, guacamoleli ve cheddar soslu dev nachos tabağı!',
    imageAsset: 'assets/items/nachos_supreme.png',
  );

  static const GameItem fiestaGrande = GameItem(
    id: 'fiesta_grande',
    code: 'fiesta_grande',
    name: 'Fiesta El Grande',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFFD54F),
    description: 'Burrito, nachos ve guacamole soslu Meksika şöleni!',
    imageAsset: 'assets/items/fiesta_grande.png',
  );

  // =================== 7. DONDURMA & TATLI SERİSİ ===================
  static const GameItem iceCreamCone = GameItem(
    id: 'ice_cream_cone',
    code: 'ice_cream_cone',
    name: 'Dondurma Külahı',
    emoji: '🍦',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFB74D),
    accentColor: Color(0xFFFFF3E0),
    description: 'Çıtır gofret dondurma külahı.',
    imageAsset: 'assets/items/ice_cream_cone.png',
  );

  static const GameItem vanillaIceCream = GameItem(
    id: 'vanilla_ice_cream',
    code: 'vanilla_ice_cream',
    name: 'Vanilyalı Dondurma',
    emoji: '🍨',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFF9C4),
    accentColor: Color(0xFFFFFDE7),
    description: 'Gerçek vanilya çubuklarıyla yapılmış taze dondurma!',
    imageAsset: 'assets/items/vanilla_ice_cream.png',
  );

  static const GameItem strawberryIceCream = GameItem(
    id: 'strawberry_ice_cream',
    code: 'strawberry_ice_cream',
    name: 'Çilekli Dondurma',
    emoji: '🍓',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE91E63),
    accentColor: Color(0xFFF8BBD0),
    description: 'Taze bahçe çilekleriyle hazırlanmış pembe dondurma!',
    imageAsset: 'assets/items/strawberry_ice_cream.png',
  );

  static const GameItem chocoIceCream = GameItem(
    id: 'choco_ice_cream',
    code: 'choco_ice_cream',
    name: 'Çikolatalı Dondurma',
    emoji: '🍫',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFD7CCC8),
    description: 'Yoğun Belçika çikolatalı nefis dondurma!',
    imageAsset: 'assets/items/choco_ice_cream.png',
  );

  static const GameItem bananaIceCream = GameItem(
    id: 'banana_ice_cream',
    code: 'banana_ice_cream',
    name: 'Muzlu Dondurma',
    emoji: '🍌',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFBC02D),
    accentColor: Color(0xFFFFF9C4),
    description: 'Kremamsı ve aromatik taze muzlu dondurma!',
    imageAsset: 'assets/items/banana_ice_cream.png',
  );

  static const GameItem dualIceCream = GameItem(
    id: 'dual_ice_cream',
    code: 'dual_ice_cream',
    name: 'İkili Gurme Külah',
    emoji: '🍧',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFAD1457),
    accentColor: Color(0xFFFF80AB),
    description: 'Çilek ve çikolatanın buluştuğu duble külah!',
    imageAsset: 'assets/items/dual_ice_cream.png',
  );

  static const GameItem sundae = GameItem(
    id: 'sundae',
    code: 'sundae',
    name: 'Çilekli Sundae',
    emoji: '🍒',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD81B60),
    accentColor: Color(0xFFFF80AB),
    description: 'Çilek sosu ve krema ile süslenmiş gurme kupa dondurma!',
    imageAsset: 'assets/items/sundae.png',
  );

  static const GameItem bananaSplit = GameItem(
    id: 'banana_split',
    code: 'banana_split',
    name: 'Banana Split Ziyafeti',
    emoji: '🍌',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFFFF59D),
    description: 'Muz, 3 top dondurma, çikolata sosu ve fıstıklı dev tatlı!',
    imageAsset: 'assets/items/banana_split.png',
  );

  static const GameItem magnumTower = GameItem(
    id: 'magnum_tower',
    code: 'magnum_tower',
    name: 'Magnum Karamel Kulesi',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFFFD54F),
    description: 'Fıstık, karamel ve çıtır çikolata kaplı efsane dondurma kulesi!',
    imageAsset: 'assets/items/magnum_tower.png',
  );

  static const GameItem waffle = GameItem(
    id: 'waffle',
    code: 'waffle',
    name: 'Çikolatalı Waffle',
    emoji: '🧇',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFFFB74D),
    description: 'Çıtır waffle üzerine akışkan çikolata ve meyve şöleni!',
    imageAsset: 'assets/items/mega_waffle.png',
  );

  static const GameItem nuttyWaffle = GameItem(
    id: 'nutty_waffle',
    code: 'nutty_waffle',
    name: 'Fıstıklı Karamel Waffle',
    emoji: '🥜',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFD54F),
    description: 'Bol Antep fıstığı ve karamel soslu gurme waffle!',
    imageAsset: 'assets/items/nutty_waffle.png',
  );

  static const GameItem megaWaffle = GameItem(
    id: 'mega_waffle',
    code: 'mega_waffle',
    name: 'Mega Waffle Ziyafeti',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF880E4F),
    accentColor: Color(0xFFFF80AB),
    description: 'Çilek, muz, çikolata, fıstık ve dondurmalı şef waffle’ı!',
    imageAsset: 'assets/items/mega_waffle.png',
  );

  static const GameItem chocoCrepe = GameItem(
    id: 'choco_crepe',
    code: 'choco_crepe',
    name: 'Muzlu Çikolatalı Krep',
    emoji: '🥞',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFFFE082),
    description: 'İncecik Fransız krepi içinde muz dilimleri ve çikolata!',
    imageAsset: 'assets/items/choco_crepe.png',
  );

  static const GameItem milkshake = GameItem(
    id: 'milkshake',
    code: 'milkshake',
    name: 'Çilekli Milkshake',
    emoji: '🍧',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF06292),
    accentColor: Color(0xFFFCE4EC),
    description: 'Soğuk süt, çilek ve dondurmanın buz gibi lezzeti!',
    imageAsset: 'assets/items/milkshake.png',
  );

  // =================== 8. ASYA SERİSİ (RAMEN & SUŞİ) ===================
  static const GameItem rawRice = GameItem(
    id: 'raw_rice',
    code: 'raw_rice',
    name: 'Pirinç',
    emoji: '🌾',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFECEFF1),
    accentColor: Color(0xFFFFFFFF),
    description: 'Tane tane kaliteli pirinç.',
    imageAsset: 'assets/items/raw_rice.png',
  );

  static const GameItem sushiRice = GameItem(
    id: 'sushi_rice',
    code: 'sushi_rice',
    name: 'Suşi Pirinci Lapası',
    emoji: '🍙',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFCFD8DC),
    accentColor: Color(0xFFECEFF1),
    description: 'Sirkeyle tatlandırılmış yapışkan suşi pirinci.',
    imageAsset: 'assets/items/sushi_rice.png',
  );

  static const GameItem rawSalmon = GameItem(
    id: 'raw_salmon',
    code: 'raw_salmon',
    name: 'Taze Somon',
    emoji: '🐟',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFF8A65),
    accentColor: Color(0xFFFFCCBC),
    description: 'Norveç denizinden taptaze somon balığı.',
    imageAsset: 'assets/items/raw_salmon.png',
  );

  static const GameItem slicedSalmon = GameItem(
    id: 'sliced_salmon',
    code: 'sliced_salmon',
    name: 'Somon Fileto',
    emoji: '🍥',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFF7043),
    accentColor: Color(0xFFFFAB91),
    description: 'Usta şef bıçağıyla incecik dilimlenmiş somon eti.',
    imageAsset: 'assets/items/sliced_salmon.png',
  );

  static const GameItem salmonNigiri = GameItem(
    id: 'salmon_nigiri',
    code: 'salmon_nigiri',
    name: 'Somon Nigiri',
    emoji: '🍣',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF5722),
    accentColor: Color(0xFFFFCCBC),
    description: 'Pirinç yastığı üzerinde taze somon fileto!',
    imageAsset: 'assets/items/salmon_nigiri.png',
  );

  static const GameItem sushiRoll = GameItem(
    id: 'sushi_roll',
    code: 'sushi_roll',
    name: 'Somon Maki Roll',
    emoji: '🍱',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF263238),
    accentColor: Color(0xFFFF8A65),
    description: 'Nori yosununa sarılmış nefis somonlu maki suşi!',
    imageAsset: 'assets/items/sushi_roll.png',
  );

  static const GameItem californiaRoll = GameItem(
    id: 'california_roll',
    code: 'california_roll',
    name: 'California Roll',
    emoji: '🥑',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF388E3C),
    accentColor: Color(0xFFFFAB91),
    description: 'Somon, avokado ve pirincin enfes California sarması!',
    imageAsset: 'assets/items/california_roll.png',
  );

  static const GameItem dragonRoll = GameItem(
    id: 'dragon_roll',
    code: 'dragon_roll',
    name: 'Spesiyal Dragon Roll',
    emoji: '🐉',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF2E7D32),
    accentColor: Color(0xFFFFF176),
    description: 'Avokado pulları ve özel sosla kaplı gurme Dragon Roll!',
    imageAsset: 'assets/items/dragon_roll.png',
  );

  static const GameItem goldenDragonRoll = GameItem(
    id: 'golden_dragon_roll',
    code: 'golden_dragon_roll',
    name: 'Altın Dragon Roll',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFDCEDC8),
    description: 'Somon kaplama, avokado ve trüf mayonezli zirve suşi!',
    imageAsset: 'assets/items/dragon_roll.png',
  );

  static const GameItem dimSum = GameItem(
    id: 'dim_sum',
    code: 'dim_sum',
    name: 'Buharda Dim Sum',
    emoji: '🥟',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFCC80),
    accentColor: Color(0xFFFFF3E0),
    description: 'Bambu sepetinde buharda pişmiş etli Asya mantısı!',
    imageAsset: 'assets/items/dim_sum.png',
  );

  static const GameItem ramenNoodles = GameItem(
    id: 'ramen_noodles',
    code: 'ramen_noodles',
    name: 'El Yapımı Erişte',
    emoji: '🥢',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFFE082),
    accentColor: Color(0xFFFFF8E1),
    description: 'Taze açılmış geleneksel ramen eriştesi.',
    imageAsset: 'assets/items/ramen_noodles.png',
  );

  static const GameItem chefRamen = GameItem(
    id: 'chef_ramen',
    code: 'chef_ramen',
    name: 'Usta Rameni',
    emoji: '🍜',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFAB91),
    description: 'Zengin et suyu, ızgara et ve taze soğanlı sıcak ramen kasesi!',
    imageAsset: 'assets/items/chef_ramen.png',
  );

  // =================== 9. TÜRK OCAKBAŞI & DÖNER SERİSİ ===================
  static const GameItem rawMeat = GameItem(
    id: 'raw_meat',
    code: 'raw_meat',
    name: 'Kıyma & Et',
    emoji: '🥩',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFD32F2F),
    accentColor: Color(0xFFFFCDD2),
    description: 'Taze çekilmiş dana kıyması ve kuşbaşı et.',
    imageAsset: 'assets/items/raw_meat.png',
  );

  static const GameItem cookedPatty = GameItem(
    id: 'cooked_patty',
    code: 'cooked_patty',
    name: 'Izgara Köfte',
    emoji: '🍘',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFBCAAA4),
    description: 'Cızbız ızgarada nar gibi pişmiş sulu dana köfte.',
    imageAsset: 'assets/items/cooked_patty.png',
  );

  static const GameItem donerMeat = GameItem(
    id: 'doner_meat',
    code: 'doner_meat',
    name: 'Yaprak Döner',
    emoji: '🍖',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFD7CCC8),
    description: 'Odun ateşinde nar gibi kızarmış yaprak döner dilimleri.',
    imageAsset: 'assets/items/doner_meat.png',
  );

  static const GameItem tombikDoner = GameItem(
    id: 'tombik_doner',
    code: 'tombik_doner',
    name: 'Tombik Döner',
    emoji: '🥙',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    description: 'Tombik fırın ekmeği arasında yaprak döner ziyafeti!',
    imageAsset: 'assets/items/tombik_doner.png',
  );

  static const GameItem durumDoner = GameItem(
    id: 'durum_doner',
    code: 'durum_doner',
    name: 'Dürüm Döner',
    emoji: '🌯',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFBF360C),
    accentColor: Color(0xFFFFAB91),
    description: 'İncecik lavaşa sarılmış sıcak soslu dürüm döner!',
    imageAsset: 'assets/items/durum_doner.png',
  );

  static const GameItem cheeseDurum = GameItem(
    id: 'cheese_durum',
    code: 'cheese_durum',
    name: 'Kaşarlı Hatay Dürüm',
    emoji: '🧀',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFD54F),
    description: 'Eritme kaşarlı ve özel salçalı soslu sıcak dürüm!',
    imageAsset: 'assets/items/cheese_durum.png',
  );

  static const GameItem iskender = GameItem(
    id: 'iskender',
    code: 'iskender',
    name: 'İskender Kebap',
    emoji: '🍽️',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFF8A80),
    description: 'Pide üzerinde yaprak döner, domates sosu ve kızgın tereyağı!',
    imageAsset: 'assets/items/iskender.png',
  );

  static const GameItem padisahTray = GameItem(
    id: 'padisah_tray',
    code: 'padisah_tray',
    name: 'Padişah Saray Tepsisi',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF880E4F),
    accentColor: Color(0xFFFFD54F),
    description: 'İskender kebap, kaşar, tereyağlı pilav ve ızgara köfte tepsisi!',
    imageAsset: 'assets/items/padisah_tray.png',
  );

  static const GameItem plainPilaf = GameItem(
    id: 'plain_pilaf',
    code: 'plain_pilaf',
    name: 'Tereyağlı Pilav',
    emoji: '🍚',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFE082),
    accentColor: Color(0xFFFFF8E1),
    description: 'Tane tane dökülen tereyağlı geleneksel pirinç pilavı.',
    imageAsset: 'assets/items/plain_pilaf.png',
  );

  static const GameItem meatPilaf = GameItem(
    id: 'meat_pilaf',
    code: 'meat_pilaf',
    name: 'Etli Pilav',
    emoji: '🥘',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFFFCC80),
    description: 'Tereyağlı pilav üzerinde lokum gibi kavrulmuş et parçaları!',
    imageAsset: 'assets/items/meat_pilaf.png',
  );

  static const GameItem royalPilaf = GameItem(
    id: 'royal_pilaf',
    code: 'royal_pilaf',
    name: 'Saray Ziyafet Pilavı',
    emoji: '👑',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF8F00),
    accentColor: Color(0xFFFFE082),
    description: 'Et, tereyağı ve domates soslu saray pilavı!',
    imageAsset: 'assets/items/royal_pilaf.png',
  );

  // =================== 10. BURGER SERİSİ ===================
  static const GameItem burger = GameItem(
    id: 'burger',
    code: 'burger',
    name: 'Klasik Burger',
    emoji: '🍔',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFFFB74D),
    description: 'Sulu ızgara köfte, marul ve soslu nefis klasik burger!',
    imageAsset: 'assets/items/burger.png',
  );

  static const GameItem cheeseBurger = GameItem(
    id: 'cheese_burger',
    code: 'cheese_burger',
    name: 'Cheeseburger',
    emoji: '🧀',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFD54F),
    description: 'Eritilmiş nefis kaşar peynirli ve sulu köfteli doyurucu cheeseburger!',
    imageAsset: 'assets/items/cheese_burger.png',
  );

  static const GameItem baconBurger = GameItem(
    id: 'bacon_burger',
    code: 'bacon_burger',
    name: 'Sucuklu Smokey Burger',
    emoji: '🥓',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFFCC80),
    description: 'Izgara köfte, çıtır sucuk dilimleri ve eritme kaşarlı burger!',
    imageAsset: 'assets/items/bacon_burger.png',
  );

  static const GameItem mushroomSwissBurger = GameItem(
    id: 'mushroom_swiss_burger',
    code: 'mushroom_swiss_burger',
    name: 'Mantarlı Swiss Burger',
    emoji: '🍄',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFD7CCC8),
    description: 'Karamelize mantar sosu ve İsviçre peynirli gurme burger!',
    imageAsset: 'assets/items/mushroom_swiss_burger.png',
  );

  static const GameItem tripleMonsterBurger = GameItem(
    id: 'triple_monster_burger',
    code: 'triple_monster_burger',
    name: 'Monster Triple Burger',
    emoji: '👑',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF3E2723),
    accentColor: Color(0xFFFFD54F),
    description: '3 kat ızgara köfte, sucuk, mantar ve duble peynirli dev canavar!',
    imageAsset: 'assets/items/triple_monster_burger.png',
  );

  // =================== 11. KAHVALTI, DENİZ & PASTANE SERİSİ ===================
  static const GameItem egg = GameItem(
    id: 'egg',
    code: 'egg',
    name: 'Taze Yumurta',
    emoji: '🥚',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFFF59D),
    accentColor: Color(0xFFFFFDE7),
    description: 'Organik köy yumurtası.',
    imageAsset: 'assets/items/egg.png',
  );

  static const GameItem friedEgg = GameItem(
    id: 'fried_egg',
    code: 'fried_egg',
    name: 'Sahanda Göz Yumurta',
    emoji: '🍳',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFB300),
    accentColor: Color(0xFFFFF9C4),
    description: 'Tereyağında cızırdayan sarısı akışkan sahanda yumurta!',
    imageAsset: 'assets/items/fried_egg.png',
  );

  static const GameItem sucukFriedEgg = GameItem(
    id: 'sucuk_fried_egg',
    code: 'sucuk_fried_egg',
    name: 'Sucuklu Yumurta',
    emoji: '🍳',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC62828),
    accentColor: Color(0xFFFFD54F),
    description: 'Kızarmış sucuk dilimleriyle sahanda sıcak köy yumurtası!',
    imageAsset: 'assets/items/sucuk_fried_egg.png',
  );

  static const GameItem englishBreakfast = GameItem(
    id: 'english_breakfast',
    code: 'english_breakfast',
    name: 'Kral Kahvaltı Tabağı',
    emoji: '🍽️',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    description: 'Yumurta, sucuk, fırın ekmeği ve peynirle zengin kahvaltı tabağı!',
    imageAsset: 'assets/items/english_breakfast.png',
  );

  static const GameItem pancake = GameItem(
    id: 'pancake',
    code: 'pancake',
    name: 'Ballı Pofuduk Pankek',
    emoji: '🥞',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFB74D),
    accentColor: Color(0xFFFFF3E0),
    description: 'Üzerine süzme bal ve tereyağı gezdirilmiş yumuşacık pankek!',
    imageAsset: 'assets/items/pancake.png',
  );

  static const GameItem strawberryPancake = GameItem(
    id: 'strawberry_pancake',
    code: 'strawberry_pancake',
    name: 'Çilekli Pankek Kulesi',
    emoji: '🍓',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE91E63),
    accentColor: Color(0xFFFFE082),
    description: 'Kat kat pankekler arasında taze çilekler ve akışkan bal!',
    imageAsset: 'assets/items/strawberry_pancake.png',
  );

  static const GameItem fishBread = GameItem(
    id: 'fish_bread',
    code: 'fish_bread',
    name: 'Çıtır Balık Ekmek',
    emoji: '🥪',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF0288D1),
    accentColor: Color(0xFFB3E5FC),
    description: 'Taze somon ızgara ve çıtır fırın ekmeğiyle Eminönü usulü lezzet!',
    imageAsset: 'assets/items/fish_bread.png',
  );

  static const GameItem seafoodPan = GameItem(
    id: 'seafood_pan',
    code: 'seafood_pan',
    name: 'Tereyağlı Deniz Tavası',
    emoji: '🥘',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF0097A7),
    accentColor: Color(0xFFB2EBF2),
    description: 'Tereyağı ve limonla sotelenmiş sıcak somon tavası!',
    imageAsset: 'assets/items/seafood_pan.png',
  );

  static const GameItem cookie = GameItem(
    id: 'cookie',
    code: 'cookie',
    name: 'Fırın Kurabiye',
    emoji: '🍪',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFB74D),
    accentColor: Color(0xFFFFF3E0),
    description: 'Ağızda dağılan çıtır tereyağlı kurabiye.',
    imageAsset: 'assets/items/cookie.png',
  );

  static const GameItem chocoCookie = GameItem(
    id: 'choco_cookie',
    code: 'choco_cookie',
    name: 'Çikolatalı Cookie',
    emoji: '🍫',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFD7CCC8),
    description: 'Bol damla çikolatalı fırın kurabiyesi!',
    imageAsset: 'assets/items/choco_cookie.png',
  );

  static const GameItem chocoDonut = GameItem(
    id: 'choco_donut',
    code: 'choco_donut',
    name: 'Çikolatalı Donut',
    emoji: '🍩',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFFFCC80),
    description: 'Koyu Belçika çikolatası kaplı pofuduk donut!',
    imageAsset: 'assets/items/choco_donut.png',
  );

  static const GameItem strawberryDonut = GameItem(
    id: 'strawberry_donut',
    code: 'strawberry_donut',
    name: 'Çilekli Pembe Donut',
    emoji: '🍥',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE91E63),
    accentColor: Color(0xFFF8BBD0),
    description: 'Pembe çilek glazürü ve renkli şekerlemeli donut!',
    imageAsset: 'assets/items/strawberry_donut.png',
  );

  static const GameItem strawberryCake = GameItem(
    id: 'strawberry_cake',
    code: 'strawberry_cake',
    name: 'Çilekli Yaş Pasta',
    emoji: '🍰',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE91E63),
    accentColor: Color(0xFFF8BBD0),
    description: 'Kremalı pandispanya ve taze çileklerle süslenmiş yaş pasta!',
    imageAsset: 'assets/items/strawberry_cake.png',
  );

  static const GameItem chocoGrandCake = GameItem(
    id: 'choco_grand_cake',
    code: 'choco_grand_cake',
    name: 'Çikolata Şelaleli Katlı Pasta',
    emoji: '🎂',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF3E2723),
    accentColor: Color(0xFFFFD54F),
    description: 'Akışkan çikolata şelalesi, fıstıklar ve kurabiyeli dev kutlama pastası!',
    imageAsset: 'assets/items/choco_grand_cake.png',
  );

  static const GameItem lemon = GameItem(
    id: 'lemon',
    code: 'lemon',
    name: 'Sulu Limon',
    emoji: '🍋',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFFFDD835),
    accentColor: Color(0xFFFFF9C4),
    description: 'Taze ekşi Akdeniz limonu.',
    imageAsset: 'assets/items/lemon.png',
  );

  static const GameItem lemonade = GameItem(
    id: 'lemonade',
    code: 'lemonade',
    name: 'Buzlu Limonata',
    emoji: '🍹',
    level: 2,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFEE58),
    accentColor: Color(0xFFFFFDE7),
    description: 'Taze nane yaprakları ve buzla sunulan serinletici limonata!',
    imageAsset: 'assets/items/lemonade.png',
  );

  static const GameItem smoothie = GameItem(
    id: 'smoothie',
    code: 'smoothie',
    name: 'Çilekli Smoothie',
    emoji: '🥤',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFEC407A),
    accentColor: Color(0xFFFCE4EC),
    description: 'Taze çilek, süt ve buz harmanı ferahlatıcı smoothie!',
    imageAsset: 'assets/items/smoothie.png',
  );

  static const GameItem bubbleTea = GameItem(
    id: 'bubble_tea',
    code: 'bubble_tea',
    name: 'Baloncuklu Çay (Boba)',
    emoji: '🧃',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFAB47BC),
    accentColor: Color(0xFFF3E5F5),
    description: 'Sütlü çay ve tapiyoka incili eğlenceli bubble tea!',
    imageAsset: 'assets/items/bubble_tea.png',
  );

  // =================== 23. GİZLİ SİMYA & FÜZYON TARİFLERİ ===================
  static const GameItem friedIceCream = GameItem(
    id: 'fried_ice_cream',
    code: 'fried_ice_cream',
    name: 'Kızarmış Dondurma',
    emoji: '🍨',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFB300),
    accentColor: Color(0xFFFFF8E1),
    description: 'Dışı çıtır sıcak kızarmış ekmek kabuğu, içi buz gibi vanilyalı dondurma!',
    imageAsset: 'assets/items/fried_ice_cream.png',
  );

  static const GameItem affogato = GameItem(
    id: 'affogato',
    code: 'affogato',
    name: 'İtalyan Affogato',
    emoji: '☕',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFD7CCC8),
    description: 'Sıcak koyu espresso üzerine eritilen nefis vanilyalı dondurma!',
    imageAsset: 'assets/items/affogato.png',
  );

  static const GameItem chocolatePizza = GameItem(
    id: 'chocolate_pizza',
    code: 'chocolate_pizza',
    name: 'Nutella Tatlı Pizza',
    emoji: '🍫',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFFFD180),
    description: 'Fırından yeni çıkmış sıcak hamur üzerine bol fındık kreması ve muz dilimleri!',
    imageAsset: 'assets/items/chocolate_pizza.png',
  );

  static const GameItem avocadoToast = GameItem(
    id: 'avocado_toast',
    code: 'avocado_toast',
    name: 'Gurme Avokado Tost',
    emoji: '🥪',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF558B2F),
    accentColor: Color(0xFFDCEDC8),
    description: 'Kızarmış ekşi mayalı ekmek üzerinde limonlu avokado ezmesi ve çörek otu!',
      imageAsset: 'assets/items/avocado_toast.png',
  );

  static const GameItem truffleFries = GameItem(
    id: 'truffle_fries',
    code: 'truffle_fries',
    name: 'Trüf Mantarlı Çıtır Patates',
    emoji: '🍟',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFFFF9C4),
    description: 'Özel trüf yağı, rendelenmiş parmesan ve taze kekikle harmanlanmış gurme patates!',
      imageAsset: 'assets/items/truffle_fries.png',
  );

  static const GameItem honeyMustardBurger = GameItem(
    id: 'honey_mustard_burger',
    code: 'honey_mustard_burger',
    name: 'Ballı Gurme Burger',
    emoji: '🍯',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFA000),
    accentColor: Color(0xFFFFECB3),
    description: 'Sulu ızgara köfte, çıtır soğan ve özel ballı hardal sosuyla taçlandırılmış burger!',
      imageAsset: 'assets/items/honey_mustard_burger.png',
  );

  static const GameItem bananaSplitDeluxe = GameItem(
    id: 'banana_split_deluxe',
    code: 'banana_split_deluxe',
    name: 'Karamelize Banana Split',
    emoji: '🍌',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFBC02D),
    accentColor: Color(0xFFFFF59D),
    description: 'Karamelize edilmiş muz, üç top dondurma, fıstık ve çikolata şelalesi!',
    imageAsset: 'assets/items/banana_split_deluxe.png',
  );

  static const GameItem mexicanHotChocolate = GameItem(
    id: 'mexican_hot_chocolate',
    code: 'mexican_hot_chocolate',
    name: 'Aztek Acı Çikolatası',
    emoji: '☕',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFCCBC),
    description: 'Eski Aztek tarifi: Tarçın ve acı köy biberiyle demlenmiş yoğun sıcak çikolata!',
      imageAsset: 'assets/items/mexican_hot_chocolate.png',
  );

  static const GameItem sweetChiliWings = GameItem(
    id: 'sweet_chili_wings',
    code: 'sweet_chili_wings',
    name: 'Ballı Sweet Chili Tavuk',
    emoji: '🍗',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE64A19),
    accentColor: Color(0xFFFFCC80),
    description: 'Çıtır panelenmiş tavuk kanatları üzerinde tatlı ballı acı sos glazürü!',
      imageAsset: 'assets/items/sweet_chili_wings.png',
  );

  static const GameItem truffleCappuccinoSoup = GameItem(
    id: 'truffle_cappuccino_soup',
    code: 'truffle_cappuccino_soup',
    name: 'Trüf Mantarı Köpüğü',
    emoji: '🫕',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFEFEBE9),
    description: 'Kadife kıvamında trüf mantarı özü ve süt köpüğüyle sunulan gurme lezzet!',
      imageAsset: 'assets/items/truffle_cappuccino_soup.png',
  );

  static const GameItem nutellaDonut = GameItem(
    id: 'nutella_donut',
    code: 'nutella_donut',
    name: 'Çikolatalı Bomboloni Donut',
    emoji: '🌰',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFFFD180),
    description: 'İçi bol fındıklı çikolata kreması dolgulu İtalyan usulü sıcak donut!',
      imageAsset: 'assets/items/nutella_donut.png',
  );

  static const GameItem matchaIceCream = GameItem(
    id: 'matcha_ice_cream',
    code: 'matcha_ice_cream',
    name: 'Matcha Dondurması',
    emoji: '🍵',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF33691E),
    accentColor: Color(0xFFDCEDC8),
    description: 'Geleneksel Japon yeşil çay yapraklarından üretilmiş tazeleyici gurme dondurma!',
      imageAsset: 'assets/items/matcha_ice_cream.png',
  );

  static const GameItem caramelPopcornShake = GameItem(
    id: 'caramel_popcorn_shake',
    code: 'caramel_popcorn_shake',
    name: 'Ballı Karamel Milkshake',
    emoji: '🍮',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFE082),
    description: 'Doğal bal, akışkan karamel ve soğuk sütün muhteşem buluşması!',
    imageAsset: 'assets/items/caramel_popcorn_shake.png',
  );

  static const GameItem cheesyFriesSupreme = GameItem(
    id: 'cheesy_fries_supreme',
    code: 'cheesy_fries_supreme',
    name: 'Eritme Peynirli Çıtır Patates',
    emoji: '🧀',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFFFF59D),
    description: 'Sıcak çıtır patates üzerinde eriyen bol kaşar ve çedar peynir sosu!',
      imageAsset: 'assets/items/cheesy_fries_supreme.png',
  );

  static const GameItem oliveFocaccia = GameItem(
    id: 'olive_focaccia',
    code: 'olive_focaccia',
    name: 'Zeytinli İtalyan Focaccia',
    emoji: '🥖',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF37474F),
    accentColor: Color(0xFFFFE082),
    description: 'Zeytinyağı, biberiye ve siyah zeytin taneleriyle taş fırında pişen İtalyan ekmeği!',
    imageAsset: 'assets/items/olive_focaccia.png',
  );

  static const GameItem sucukluYumurtaliPizza = GameItem(
    id: 'sucuklu_yumurtali_pizza',
    code: 'sucuklu_yumurtali_pizza',
    name: 'Sahanda Sucuklu Kahvaltı Pizzası',
    emoji: '🍳',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC62828),
    accentColor: Color(0xFFFFE082),
    description: 'İncecik çıtır hamur üzerinde bol sucuk dilimleri ve göz yumurtalı fırın şöleni!',
    imageAsset: 'assets/items/sucuklu_yumurtali_pizza.png',
  );

  static const GameItem ramenCarbonara = GameItem(
    id: 'ramen_carbonara',
    code: 'ramen_carbonara',
    name: 'Peynirli Ramen Carbonara',
    emoji: '🍜',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFFFF9C4),
    description: 'Japon ramen eriştelerinin İtalyan kremalı peynir sosuyla muazzam füzyonu!',
      imageAsset: 'assets/items/ramen_carbonara.png',
  );

  static const GameItem honeyGlazeDonut = GameItem(
    id: 'honey_glaze_donut',
    code: 'honey_glaze_donut',
    name: 'Ballı Glaze Çıtır Donut',
    emoji: '🍯',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF8F00),
    accentColor: Color(0xFFFFF8E1),
    description: 'Taze çiçek balı ve vanilya şurubu kaplamalı puf puf çıtır donut!',
      imageAsset: 'assets/items/honey_glaze_donut.png',
  );

  static const GameItem nutBananaWaffle = GameItem(
    id: 'nut_banana_waffle',
    code: 'nut_banana_waffle',
    name: 'Fındıklı Muzlu Kral Waffle',
    emoji: '🍌',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF5D4037),
    accentColor: Color(0xFFFFE082),
    description: 'Bol fındık parçaları, taze muz dilimleri ve çikolata dolgulu altın waffle!',
      imageAsset: 'assets/items/nut_banana_waffle.png',
  );

  static const GameItem onionRingsDeluxe = GameItem(
    id: 'onion_rings_deluxe',
    code: 'onion_rings_deluxe',
    name: 'Çıtır Soğan Halkası Sepeti',
    emoji: '🥨',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF7B1FA2),
    accentColor: Color(0xFFFFF9C4),
    description: 'Karamelize soğan halkalarının özel çıtır harçla altın sarısı kızartılmış hali!',
    imageAsset: 'assets/items/onion_rings_deluxe.png',
  );

  static const GameItem tacoSupremeHot = GameItem(
    id: 'taco_supreme_hot',
    code: 'taco_supreme_hot',
    name: 'Alevli Supreme Taco',
    emoji: '🌮',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFCC80),
    description: 'Köy biberi, baharatlı kıyma, guacamole ve alevli salsa soslu dev taco!',
    imageAsset: 'assets/items/taco_supreme_hot.png',
  );

  static const GameItem volcanoBurger = GameItem(
    id: 'volcano_burger',
    code: 'volcano_burger',
    name: 'Yanardağ Biberli Burger',
    emoji: '🌶️',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC62828),
    accentColor: Color(0xFFFF8A80),
    description: 'Közlenmiş acı biberler, acı sos ve eritme kaşarlı dev yanardağ burgeri!',
    imageAsset: 'assets/items/volcano_burger.png',
  );

  static const GameItem icedLatteHazelnut = GameItem(
    id: 'iced_latte_hazelnut',
    code: 'iced_latte_hazelnut',
    name: 'Fındık Şuruplu Buzlu Latte',
    emoji: '🧊',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFD7CCC8),
    description: 'Kavrulmuş fındık şurubu, soğuk süt ve duble espresso ile hazırlanan buzlu latte!',
    imageAsset: 'assets/items/iced_latte_hazelnut.png',
  );

  static const GameItem strawberryMatcha = GameItem(
    id: 'strawberry_matcha',
    code: 'strawberry_matcha',
    name: 'Çilekli Buzlu Matcha',
    emoji: '🍵',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF2E7D32),
    accentColor: Color(0xFFF8BBD0),
    description: 'Taze çilek püresi ve yeşil Japon matcha çayının iki katmanlı serinletici lezzeti!',
      imageAsset: 'assets/items/strawberry_matcha.png',
  );

  static const GameItem goldenMilkTea = GameItem(
    id: 'golden_milk_tea',
    code: 'golden_milk_tea',
    name: 'Ballı Kraliyet Boba Tea',
    emoji: '🍯',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFF8F00),
    accentColor: Color(0xFFF3E5F5),
    description: 'Saf çiçek balı, kremalı sütlü çay ve altın rengi tapiyoka incileri!',
      imageAsset: 'assets/items/golden_milk_tea.png',
  );

  static const GameItem gourmetMushroomKebab = GameItem(
    id: 'gourmet_mushroom_kebab',
    code: 'gourmet_mushroom_kebab',
    name: 'Mantarlı Sultan Kebabı',
    emoji: '🥘',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFFFFD54F),
    imageAsset: 'assets/items/gourmet_mushroom_kebab.png',
    description: 'Tırnak pide üzerinde tereyağlı et döner, sote orman mantarları ve yoğurt sosu!',
  );

  static const GameItem creamyTrufflePasta = GameItem(
    id: 'creamy_truffle_pasta',
    code: 'creamy_truffle_pasta',
    name: 'Trüf Mantarlı Kremalı Pasta',
    emoji: '🍝',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6D4C41),
    accentColor: Color(0xFFFFF9C4),
    imageAsset: 'assets/items/creamy_truffle_pasta.png',
    description: 'Kremalı taze mantar sosu ve trüf aromasıyla buluşan İtalyan makarna şöleni!',
  );

  static const GameItem pepperoniCalzone = GameItem(
    id: 'pepperoni_calzone',
    code: 'pepperoni_calzone',
    name: 'Sucuklu Kapalı Calzone',
    emoji: '🥮',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFBF360C),
    accentColor: Color(0xFFFFCC80),
    imageAsset: 'assets/items/pepperoni_calzone.png',
    description: 'İçi bol sucuk, erimiş kaşar ve domates sosuyla doldurulup kapatılmış İtalyan pidesi!',
  );

  static const GameItem donerDurumSpecial = GameItem(
    id: 'doner_durum_special',
    code: 'doner_durum_special',
    name: 'Kaşarlı Fırın Dürüm Döner',
    emoji: '🌯',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFE082),
    imageAsset: 'assets/items/doner_durum_special.png',
    description: 'Lavaş içinde et döner ve kaşar sarılarak fırında üzeri kızartılan özel dürüm!',
  );

  static const GameItem pistachioCroissant = GameItem(
    id: 'pistachio_croissant',
    code: 'pistachio_croissant',
    name: 'Fıstık Dolgulu Çıtır Kruvasan',
    emoji: '🥐',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF558B2F),
    accentColor: Color(0xFFDCEDC8),
    description: 'Fransız tereyağlı kruvasan içinde akışkan Antep fıstığı kreması ve fıstık parçaları!',
    imageAsset: 'assets/items/pistachio_croissant.png',
  );

  static const GameItem chocolateFondue = GameItem(
    id: 'chocolate_fondue',
    code: 'chocolate_fondue',
    name: 'Muzlu Çikolata Şelalesi',
    emoji: '🫕',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF3E2723),
    accentColor: Color(0xFFFFF59D),
    imageAsset: 'assets/items/chocolate_fondue.png',
    description: 'Sıcak Belçika çikolatasına batırılan taze muz dilimleri ve çıtır fıstıklar!',
  );

  static const GameItem caramelMacchiatoSpecial = GameItem(
    id: 'caramel_macchiato_special',
    code: 'caramel_macchiato_special',
    name: 'Ballı Karamel Macchiato',
    emoji: '☕',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFD54F),
    description: 'Katmanlı vanilyalı süt, yoğun espresso ve üzerinde altın rengi karamel & bal deseni!',
    imageAsset: 'assets/items/caramel_macchiato.png',
  );

  static const GameItem cheddarHotDog = GameItem(
    id: 'cheddar_hot_dog',
    code: 'cheddar_hot_dog',
    name: 'Çedar Soslu Gurme Sosisli',
    emoji: '🌭',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFFFCC80),
    description: 'Yumuşak sandviç ekmeğinde ızgara sosis, bol sıcak çedar sosu ve çıtır soğanlar!',
    imageAsset: 'assets/items/cheddar_hot_dog.png',
  );

  static const GameItem crispyOnionBurger = GameItem(
    id: 'crispy_onion_burger',
    code: 'crispy_onion_burger',
    name: 'Çıtır Karamelize Soğan Burgeri',
    emoji: '🧅',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6A1B9A),
    accentColor: Color(0xFFFFE082),
    imageAsset: 'assets/items/crispy_onion_burger.png',
    description: 'Duble dana köfte üzerinde saatlerce sotelenmiş tatlı karamelize soğan tepesi!',
  );

  static const GameItem potatoKumpirRoyal = GameItem(
    id: 'potato_kumpir_royal',
    code: 'potato_kumpir_royal',
    name: 'Kaşarlı Tereyağlı Kral Kumpir',
    emoji: '🍠',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFFFF176),
    description: 'Dev fırın patatesi içinde tereyağı, bol kaşar, mısır ve özel garnitürler!',
    imageAsset: 'assets/items/potato_kumpir_royal.png',
  );

  static const GameItem sweetPotatoFries = GameItem(
    id: 'sweet_potato_fries',
    code: 'sweet_potato_fries',
    name: 'Ballı Çıtır Tatlı Patates',
    emoji: '🍠',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFD84315),
    accentColor: Color(0xFFFFE082),
    imageAsset: 'assets/items/sweet_potato_fries.png',
    description: 'Çıtır kızartılmış tatlı patates çubukları ve yanında ballı hardal daldırma sosu!',
  );

  static const GameItem sucukluMenemen = GameItem(
    id: 'sucuklu_menemen',
    code: 'sucuklu_menemen',
    name: 'Sucuklu Biberli Sıcak Menemen',
    emoji: '🥘',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC62828),
    accentColor: Color(0xFFC8E6C9),
    description: 'Bakır tavada köy biberi, domates, bol sucuk ve tereyağında pişmiş sıcak menemen!',
    imageAsset: 'assets/items/sucuklu_menemen.png',
  );

  static const GameItem mediterraneanSalad = GameItem(
    id: 'mediterranean_salad',
    code: 'mediterranean_salad',
    name: 'Zeytinli Akdeniz Salatası',
    emoji: '🥗',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF2E7D32),
    accentColor: Color(0xFFCFD8DC),
    imageAsset: 'assets/items/mediterranean_salad.png',
    description: 'Gevrek marul, siyah zeytinler, fesleğen, domates ve sızma zeytinyağlı taze salata!',
  );

  static const GameItem bananaNutSmoothie = GameItem(
    id: 'banana_nut_smoothie',
    code: 'banana_nut_smoothie',
    name: 'Fıstıklı Muzlu Enerji Smoothie',
    emoji: '🍌',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFBC02D),
    accentColor: Color(0xFFDCEDC8),
    description: 'Taze muz, fıstık ezmesi, bal ve soğuk sütün blenderda çekilmiş güç içeceği!',
    imageAsset: 'assets/items/banana_nut_smoothie.png',
  );

  static const GameItem strawberryCrepe = GameItem(
    id: 'strawberry_crepe',
    code: 'strawberry_crepe',
    name: 'Çilekli Fransız Çıtır Krep',
    emoji: '🥞',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFAD1457),
    accentColor: Color(0xFFF8BBD0),
    imageAsset: 'assets/items/strawberry_crepe.png',
    description: 'İncecik tereyağlı krep içine sarılmış taze çilekler ve vanilyalı pastacı kreması!',
  );

  static const GameItem nuttyChocolateBrownie = GameItem(
    id: 'nutty_chocolate_brownie',
    code: 'nutty_chocolate_brownie',
    name: 'Fındıklı Sıcak Çikolatalı Sufle',
    emoji: '🧁',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF3E2723),
    accentColor: Color(0xFFFFD54F),
    imageAsset: 'assets/items/nutty_chocolate_brownie.png',
    description: 'İçi akışkan sıcak çikolata lavı, üstü çıtır kavrulmuş fındık taneleriyle bezeli sufle!',
  );

  static const GameItem honeyLimeTea = GameItem(
    id: 'honey_lime_tea',
    code: 'honey_lime_tea',
    name: 'Ballı Nane Limon Çayı',
    emoji: '🫖',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFF57F17),
    accentColor: Color(0xFFFFF9C4),
    description: 'Sıcak demlenmiş bitki çayı, taze sıkılmış limon suyu ve saf çiçek balı şifası!',
    imageAsset: 'assets/items/honey_lime_tea.png',
  );

  static const GameItem chiliCheeseNachos = GameItem(
    id: 'chili_cheese_nachos',
    code: 'chili_cheese_nachos',
    name: 'Eritme Peynirli Alevli Nachos',
    emoji: '🌶️',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFFCC80),
    imageAsset: 'assets/items/chili_cheese_nachos.png',
    description: 'Çıtır mısır cipsleri üzerinde acı biber halkaları, eritilmiş çedar ve guacamole sos!',
  );

  static const GameItem bbqBaconBurger = GameItem(
    id: 'bbq_bacon_burger',
    code: 'bbq_bacon_burger',
    name: 'Füme Sucuklu BBQ Burger',
    emoji: '🍔',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFFAB91),
    imageAsset: 'assets/items/bbq_bacon_burger.png',
    description: 'Tütsülenmiş sucuk dilimleri, barbekü sos, eritme peynir ve ızgara dana köftesi!',
  );

  static const GameItem mozzarellaSticks = GameItem(
    id: 'mozzarella_sticks',
    code: 'mozzarella_sticks',
    name: 'Çıtır Altın Mozzarella Çubukları',
    emoji: '🥖',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFA000),
    accentColor: Color(0xFFFFF59D),
    imageAsset: 'assets/items/mozzarella_sticks.png',
    description: 'Ekmek kırıntısıyla kaplanıp nar gibi kızartılmış, uzayan sıcak mozzarella çubukları!',
  );

  static const GameItem berryDonutSplit = GameItem(
    id: 'berry_donut_split',
    code: 'berry_donut_split',
    name: 'Orman Meyveli Dolgulu Donut',
    emoji: '🫐',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF880E4F),
    accentColor: Color(0xFFF48FB1),
    imageAsset: 'assets/items/berry_donut_split.png',
    description: 'Taze çilek ve böğürtlen marmelatı dolgulu, pudra şekeri serpilmiş dev donut!',
  );

  static const GameItem turkishCoffeeDelight = GameItem(
    id: 'turkish_coffee_delight',
    code: 'turkish_coffee_delight',
    name: 'Çikolatalı Sultan Türk Kahvesi',
    emoji: '☕',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF3E2723),
    accentColor: Color(0xFFBCAAA4),
    imageAsset: 'assets/items/turkish_coffee_delight.png',
    description: 'Közde pişmiş bol köpüklü Türk kahvesi, yanında çikolata ve lokum ikramıyla!',
  );

  static const GameItem garlicHerbBread = GameItem(
    id: 'garlic_herb_bread',
    code: 'garlic_herb_bread',
    name: 'Karamelize Soğanlı Çıtır Ekmek',
    emoji: '🥖',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF6A1B9A),
    accentColor: Color(0xFFFFE082),
    imageAsset: 'assets/items/garlic_herb_bread.png',
    description: 'Fırından yeni çıkmış sıcak baget ekmeği üzerinde kekikli karamelize tatlı soğanlar!',
  );

  static const GameItem spicyRamenFire = GameItem(
    id: 'spicy_ramen_fire',
    code: 'spicy_ramen_fire',
    name: 'Yanardağ Acılı Gurme Ramen',
    emoji: '🍜',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFF8A80),
    imageAsset: 'assets/items/spicy_ramen_fire.png',
    description: 'Kırmızı acı biber yağı, yumurta ve dana etiyle kaynayan süper alevli Japon rameni!',
  );

  static const GameItem dragonFruitTea = GameItem(
    id: 'dragon_fruit_tea',
    code: 'dragon_fruit_tea',
    name: 'Çilekli Tropikal Boba Tea',
    emoji: '🌺',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFC2185B),
    accentColor: Color(0xFFFCE4EC),
    imageAsset: 'assets/items/dragon_fruit_tea.png',
    description: 'Taze çilek taneleri, tropikal meyve aroması ve patlayan meyveli boba incileri!',
  );

  static const GameItem honeyGlazedKebab = GameItem(
    id: 'honey_glazed_kebab',
    code: 'honey_glazed_kebab',
    name: 'Ballı Nar Ekşili Zırh Kebabı',
    emoji: '🍢',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFB71C1C),
    accentColor: Color(0xFFFFD54F),
    imageAsset: 'assets/items/honey_glazed_kebab.png',
    description: 'Zırhtan geçmiş kuzu eti, közlenmiş biber ve ballı nar ekşisi sosuyla mangal şaheseri!',
  );

  static const GameItem oliveTapenadeToast = GameItem(
    id: 'olive_tapenade_toast',
    code: 'olive_tapenade_toast',
    name: 'Zeytin Ezmeli İtalyan Bruschetta',
    emoji: '🥪',
    level: 5,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF263238),
    accentColor: Color(0xFFFFE082),
    imageAsset: 'assets/items/olive_tapenade_toast.png',
    description: 'Kızarmış sarımsaklı ekmek dilimleri üzerinde fesleğenli zeytin ezmesi ve peynir!',
  );

  
  // =================== YENİ EKLENEN TARİF & MALZEMELER ===================
  static const GameItem lettuce = GameItem(
    id: 'lettuce',
    code: 'lettuce',
    name: 'Taze Marul',
    emoji: '🥬',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF4CAF50),
    accentColor: Color(0xFFC8E6C9),
    imageAsset: 'assets/items/lettuce.png',
    description: 'Kıtır kıtır taze bahçe marulu.',
  );

  static const GameItem lettuceToast = GameItem(
    id: 'lettuce_toast',
    code: 'lettuce_toast',
    name: 'Marullu Sandviç',
    emoji: '🥪',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF689F38),
    accentColor: Color(0xFFDCEDC8),
    imageAsset: 'assets/items/lettuce_toast.png',
    description: 'Kıtır marul ve peynirle hazırlanmış hafif sandviç.',
  );

  static const GameItem crepeBatter = GameItem(
    id: 'crepe_batter',
    code: 'crepe_batter',
    name: 'Krep Hamuru',
    emoji: '🥣',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFFF9C4),
    accentColor: Color(0xFFFFF59D),
    imageAsset: 'assets/items/crepe_batter.png',
    description: 'Yumurta ve taze sütle çırpılmış pürüzsüz krep harcı.',
  );

  static const GameItem honeyCrepe = GameItem(
    id: 'honey_crepe',
    code: 'honey_crepe',
    name: 'Ballı Fransız Krepi',
    emoji: '🥞',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFFFFA000),
    accentColor: Color(0xFFFFECB3),
    imageAsset: 'assets/items/honey_crepe.png',
    description: 'İncecik açılmış, tereyağlı ve süzme çiçek ballı nefis Fransız krepi!',
  );

  static const GameItem grapeLeaves = GameItem(
    id: 'grape_leaves',
    code: 'grape_leaves',
    name: 'Asma Yaprağı',
    emoji: '🍃',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF388E3C),
    accentColor: Color(0xFFA5D6A7),
    imageAsset: 'assets/items/grape_leaves.png',
    description: 'Taze toplanmış salamura asma yaprağı.',
  );

  static const GameItem stuffedGrapeLeaves = GameItem(
    id: 'stuffed_grape_leaves',
    code: 'stuffed_grape_leaves',
    name: 'Zeytinyağlı Yaprak Sarma',
    emoji: '🫔',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF2E7D32),
    accentColor: Color(0xFFC8E6C9),
    imageAsset: 'assets/items/stuffed_grape_leaves.png',
    description: 'Pirinç, baharatlar ve zeytinyağıyla sarılmış anne usulü yaprak sarma!',
  );

  static const GameItem lavash = GameItem(
    id: 'lavash',
    code: 'lavash',
    name: 'Lavaş Ekmek',
    emoji: '🫓',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFFE082),
    accentColor: Color(0xFFFFF8E1),
    imageAsset: 'assets/items/lavash.png',
    description: 'Sac üzerinde incecik pişirilmiş yumuşacık lavaş.',
  );

  static const GameItem pideBread = GameItem(
    id: 'pide_bread',
    code: 'pide_bread',
    name: 'Tırnak Pide',
    emoji: '🍞',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFFFFB74D),
    accentColor: Color(0xFFFFF3E0),
    imageAsset: 'assets/items/pide_bread.png',
    description: 'Taş fırında nar gibi pişmiş sıcak tırnak pide.',
  );

  static const GameItem cucumber = GameItem(
    id: 'cucumber',
    code: 'cucumber',
    name: 'Taze Salatalık',
    emoji: '🥒',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF43A047),
    accentColor: Color(0xFFC8E6C9),
    imageAsset: 'assets/items/cucumber.png',
    description: 'Kütür kütür sulu tarla salatalığı.',
  );

  static const GameItem cucumberMaki = GameItem(
    id: 'cucumber_maki',
    code: 'cucumber_maki',
    name: 'Salatalıklı Maki',
    emoji: '🍙',
    level: 3,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF2E7D32),
    accentColor: Color(0xFFA5D6A7),
    imageAsset: 'assets/items/cucumber_maki.png',
    description: 'Çıtır salatalık ve suşi pirincinin ferahlatıcı rulosu.',
  );

  static const GameItem peas = GameItem(
    id: 'peas',
    code: 'peas',
    name: 'Taze Bezelye',
    emoji: '🫛',
    level: 1,
    category: ItemCategory.raw,
    primaryColor: Color(0xFF66BB6A),
    accentColor: Color(0xFFDCEDC8),
    imageAsset: 'assets/items/peas.png',
    description: 'Tatlı taneli taze yeşil bezelye.',
  );

  static const GameItem veggieGarnish = GameItem(
    id: 'veggie_garnish',
    code: 'veggie_garnish',
    name: 'Sebzeli Garnitür',
    emoji: '🥗',
    level: 2,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF7CB342),
    accentColor: Color(0xFFDCEDC8),
    imageAsset: 'assets/items/veggie_garnish.png',
    description: 'Küp patates ve bezelyelerin haşlanmış uyumu.',
  );

    static const GameItem creamyMushroomSoup = GameItem(
    id: 'creamy_mushroom_soup',
    code: 'creamy_mushroom_soup',
    name: 'Kremalı Mantar Çorbası',
    emoji: '🥣',
    level: 4,
    category: ItemCategory.meal,
    primaryColor: Color(0xFF8D6E63),
    accentColor: Color(0xFFD7CCC8),
    imageAsset: 'assets/items/creamy_mushroom_soup.png',
    description: 'Süt kremasıyla yumuşatılmış gurme mantar çorbası!',
  );

  static const GameItem ruinedFood = GameItem(
    id: 'ruined_food',
    code: 'ruined_food',
    name: 'Hatalı Karışım',
    emoji: '🗑️',
    level: 1,
    category: ItemCategory.processed,
    primaryColor: Color(0xFF4E342E),
    accentColor: Color(0xFF8D6E63),
    imageAsset: 'assets/items/ruined_food.png',
    description: 'Uyumsuz malzemelerin birleşmesiyle yandı! Çöp kovasına atılmalı.',
  );

  static const List<GameItem> allItems = [
    rawTomato,
    choppedTomato,
    tomatoSoup,
    creamySoup,
    rawBread,
    bakedBread,
    cheese,
    toast,
    sucukToast,
    pizzaBase,
    pizza,
    pepperoniPizza,
    mushroomPizza,
    mediterraneanPizza,
    fourCheesePizza,
    supremePizza,
    sucuk,
    mushroom,
    olive,
    pepper,
    banana,
    honey,
    nuts,
    onion,
    potato,
    frenchFries,
    donutDough,
    caramel,
    rawCoffee,
    groundCoffee,
    espresso,
    americano,
    milk,
    steamedMilk,
    latte,
    chocolate,
    mocha,
    caramelMacchiato,
    frappuccino,
    royalBarista,
    croissantDough,
    butter,
    plainCroissant,
    chocoCroissant,
    strawberry,
    strawberryCroissant,
    tortilla,
    avocado,
    taco,
    burrito,
    quesadilla,
    guacamole,
    nachos,
    nachosSupreme,
    fiestaGrande,
    iceCreamCone,
    vanillaIceCream,
    strawberryIceCream,
    chocoIceCream,
    bananaIceCream,
    dualIceCream,
    sundae,
    bananaSplit,
    magnumTower,
    waffle,
    nuttyWaffle,
    megaWaffle,
    chocoCrepe,
    milkshake,
    rawRice,
    sushiRice,
    rawSalmon,
    slicedSalmon,
    salmonNigiri,
    sushiRoll,
    californiaRoll,
    dragonRoll,
    goldenDragonRoll,
    dimSum,
    ramenNoodles,
    chefRamen,
    rawMeat,
    cookedPatty,
    donerMeat,
    tombikDoner,
    durumDoner,
    cheeseDurum,
    iskender,
    padisahTray,
    plainPilaf,
    meatPilaf,
    royalPilaf,
    burger,
    cheeseBurger,
    baconBurger,
    mushroomSwissBurger,
    tripleMonsterBurger,
    egg,
    friedEgg,
    sucukFriedEgg,
    englishBreakfast,
    pancake,
    strawberryPancake,
    fishBread,
    seafoodPan,
    cookie,
    chocoCookie,
    chocoDonut,
    strawberryDonut,
    strawberryCake,
    chocoGrandCake,
    lemon,
    lemonade,
    smoothie,
    bubbleTea,
    onionSoup,
    carrot,
    carrotSoup,
    mushroomSoup,
    gardenSoup,
    clubSandwich,
    veggiePilaf,
    pastaDough,
    spaghetti,
    napoliPasta,
    bolognesePasta,
    lasagna,
    sesame,
    simit,
    cheeseSimit,
    lahmacun,
    pide,
    baklava,
    rawChicken,
    chickenNugget,
    chickenBucket,
    crispyChickenBurger,
    buffaloWings,
    sausage,
    hotDog,
    kumpirBase,
    ortakoyKumpir,
    ricePudding,
    kunefe,
    dondurmaliKunefe,
    calamari,
    tarator,
    calamariFritti,
    eggplant,
    saksuka,
    garlicShrimp,
    aegeanMezzePlatter,
    sauteedMeat,
    begendiPuree,
    hunkarBegendi,
    aliNazik,
    ormanKebabi,
    // --- 52 GİZLİ SİMYA LEZZETİ ---
    friedIceCream,
    affogato,
    chocolatePizza,
    avocadoToast,
    truffleFries,
    honeyMustardBurger,
    bananaSplitDeluxe,
    mexicanHotChocolate,
    sweetChiliWings,
    truffleCappuccinoSoup,
    nutellaDonut,
    matchaIceCream,
    caramelPopcornShake,
    cheesyFriesSupreme,
    oliveFocaccia,
    sucukluYumurtaliPizza,
    ramenCarbonara,
    honeyGlazeDonut,
    nutBananaWaffle,
    onionRingsDeluxe,
    tacoSupremeHot,
    volcanoBurger,
    icedLatteHazelnut,
    strawberryMatcha,
    goldenMilkTea,
    gourmetMushroomKebab,
    creamyTrufflePasta,
    pepperoniCalzone,
    donerDurumSpecial,
    pistachioCroissant,
    chocolateFondue,
    caramelMacchiatoSpecial,
    cheddarHotDog,
    crispyOnionBurger,
    potatoKumpirRoyal,
    sweetPotatoFries,
    sucukluMenemen,
    mediterraneanSalad,
    bananaNutSmoothie,
    strawberryCrepe,
    nuttyChocolateBrownie,
    honeyLimeTea,
    chiliCheeseNachos,
    bbqBaconBurger,
    mozzarellaSticks,
    berryDonutSplit,
    turkishCoffeeDelight,
    garlicHerbBread,
    spicyRamenFire,
    dragonFruitTea,
    honeyGlazedKebab,
    oliveTapenadeToast,
        lettuce,
    lettuceToast,
    crepeBatter,
    honeyCrepe,
    grapeLeaves,
    stuffedGrapeLeaves,
    lavash,
    pideBread,
    cucumber,
    cucumberMaki,
    peas,
    veggieGarnish,
    creamyMushroomSoup,
    ruinedFood,
  ];

  static List<GameItem> get rawPool =>
      allItems.where((i) => i.category == ItemCategory.raw).toList();

  static List<GameItem> get orderPool => allItems
      .where((i) => i.category == ItemCategory.meal || i.category == ItemCategory.processed)
      .toList();

  static GameItem? findByCode(String code) {
    try {
      return allItems.firstWhere((item) => item.code == code);
    } catch (_) {
      return null;
    }
  }
}
