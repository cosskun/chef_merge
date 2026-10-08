import 'package:flutter/material.dart';

class BoardSkin {
  final String id;
  final String name;
  final String icon;
  final int requiredStars;
  final Color backgroundColor;
  final Color borderColor;
  final Color tileColor;
  final Color tileHoverColor;
  final String description;

  const BoardSkin({
    required this.id,
    required this.name,
    required this.icon,
    required this.requiredStars,
    required this.backgroundColor,
    required this.borderColor,
    required this.tileColor,
    required this.tileHoverColor,
    required this.description,
  });

  static const List<BoardSkin> allSkins = [
    BoardSkin(
      id: 'classic',
      name: 'Klasik Ahşap Bistro',
      icon: '🥖',
      requiredStars: 0,
      backgroundColor: Color(0x145D4037),
      borderColor: Color(0x4D8D6E63),
      tileColor: Color(0xB3FFFFFF),
      tileHoverColor: Color(0x99FFE082),
      description: 'Sıcak İtalyan taş fırın ve meşe ağacı tezgahı.',
    ),
    BoardSkin(
      id: 'marble',
      name: 'Paris Mermer & Altın',
      icon: '🗼',
      requiredStars: 15,
      backgroundColor: Color(0x18004D40),
      borderColor: Color(0x66FFB300),
      tileColor: Color(0xE6FFFFFF),
      tileHoverColor: Color(0xB3FFF8E1),
      description: 'Zarif beyaz mermer ve altın varak işlemeli lüks kafe tezgahı.',
    ),
    BoardSkin(
      id: 'tokyo',
      name: 'Tokyo Neon & Bambu',
      icon: '🍣',
      requiredStars: 35,
      backgroundColor: Color(0x2200838F),
      borderColor: Color(0x8800E5FF),
      tileColor: Color(0xCCF1F8E9),
      tileHoverColor: Color(0x9980DEEA),
      description: 'Modern Shinjuku siber ışıkları ve organik bambu tezgah.',
    ),
    BoardSkin(
      id: 'retro',
      name: 'Retro 80\'ler Arcade',
      icon: '👾',
      requiredStars: 60,
      backgroundColor: Color(0x284A148C),
      borderColor: Color(0xAAFF4081),
      tileColor: Color(0xDDEDE7F6),
      tileHoverColor: Color(0x99F48FB1),
      description: 'Pikselli nostalji, neon fuşya ve 80\'ler synthwave mutfağı!',
    ),
  ];

  static BoardSkin getById(String id) {
    return allSkins.firstWhere((s) => s.id == id, orElse: () => allSkins.first);
  }
}

class ChefAvatarInfo {
  final String avatar;
  final String title;
  final int requiredStars;
  final String description;

  const ChefAvatarInfo({
    required this.avatar,
    required this.title,
    required this.requiredStars,
    required this.description,
  });

  static const List<ChefAvatarInfo> allAvatars = [
    ChefAvatarInfo(
      avatar: '👨‍🍳',
      title: 'Usta Şef',
      requiredStars: 0,
      description: 'Mutfakların vazgeçilmez klasik şefi.',
    ),
    ChefAvatarInfo(
      avatar: '👑',
      title: 'Kraliyet Aşçıbaşısı',
      requiredStars: 20,
      description: 'Saray ziyafetlerinin altın taçlı büyük şefi.',
    ),
    ChefAvatarInfo(
      avatar: '🎩',
      title: 'Centilmen Gurme',
      requiredStars: 40,
      description: 'Smokinli ve silindir şapkalı Michelin uzmanı.',
    ),
    ChefAvatarInfo(
      avatar: '🐱',
      title: 'Sevimli Şef Kedi',
      requiredStars: 65,
      description: 'Pofuduk patileriyle en hızlı yemek birleştiren şef!',
    ),
    ChefAvatarInfo(
      avatar: '🐼',
      title: 'Kung-Fu Master Panda',
      requiredStars: 90,
      description: 'Bambu ormanlarından gelen efsanevi noodle ve suşi ustası!',
    ),
  ];
}
