import 'package:flutter/material.dart';
import '../models/skin_model.dart';
import '../state/game_controller.dart';

class CustomSkinDialog extends StatefulWidget {
  final GameController controller;

  const CustomSkinDialog({super.key, required this.controller});

  @override
  State<CustomSkinDialog> createState() => _CustomSkinDialogState();
}

class _CustomSkinDialogState extends State<CustomSkinDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final totalStars = controller.totalStarsEarned;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color(0xFFFFFDF9),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 460, maxHeight: 600),
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('🎨', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Şefin Yıldız Dükkanı & Temalar',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text('⭐ Toplam Yıldızın: ', style: TextStyle(fontSize: 11.5, color: Colors.brown)),
                          Text(
                            '$totalStars Yıldız',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFFF8F00),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Tab Bar (Mutfak Tezgâhları & Şef Avatarları)
            TabBar(
              controller: _tabController,
              labelColor: const Color(0xFFFF7043),
              unselectedLabelColor: Colors.brown.shade600,
              indicatorColor: const Color(0xFFFF7043),
              indicatorWeight: 3,
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              tabs: const [
                Tab(
                  icon: Icon(Icons.table_restaurant_rounded, size: 18),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Mutfak Tezgâhları', style: TextStyle(fontSize: 12.5)),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.face_rounded, size: 18),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Şef Maskotları', style: TextStyle(fontSize: 12.5)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tab View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // 1. Mutfak Tezgâhları Listesi
                  ListView.separated(
                    itemCount: BoardSkin.allSkins.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final skin = BoardSkin.allSkins[index];
                      final isUnlocked = totalStars >= skin.requiredStars;
                      final isSelected = controller.boardSkinId == skin.id;

                      return InkWell(
                        onTap: isUnlocked
                            ? () {
                                setState(() {
                                  controller.setBoardSkin(skin.id);
                                });
                              }
                            : null,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? skin.borderColor.withValues(alpha: 0.15)
                                : isUnlocked
                                    ? Colors.white
                                    : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFFF7043)
                                  : isUnlocked
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade200,
                              width: isSelected ? 2.2 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: skin.backgroundColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: skin.borderColor, width: 1.5),
                                ),
                                alignment: Alignment.center,
                                child: Text(skin.icon, style: const TextStyle(fontSize: 22)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            skin.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.bold,
                                              color: isUnlocked ? Colors.brown.shade900 : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        if (isSelected) ...[
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              'KULLANILIYOR',
                                              style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.green),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      skin.description,
                                      style: TextStyle(fontSize: 10.5, color: Colors.brown.shade600),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isUnlocked)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text('🔒 ', style: TextStyle(fontSize: 10)),
                                      Text(
                                        '${skin.requiredStars} ⭐',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // 2. Şef Maskotları Listesi
                  ListView.separated(
                    itemCount: ChefAvatarInfo.allAvatars.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final chef = ChefAvatarInfo.allAvatars[index];
                      final isUnlocked = totalStars >= chef.requiredStars;
                      final isSelected = controller.chefAvatar == chef.avatar;

                      return InkWell(
                        onTap: isUnlocked
                            ? () {
                                setState(() {
                                  controller.setChefAvatar(chef.avatar);
                                });
                              }
                            : null,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.orange.shade50
                                : isUnlocked
                                    ? Colors.white
                                    : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFFF7043)
                                  : isUnlocked
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade200,
                              width: isSelected ? 2.2 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(chef.avatar, style: const TextStyle(fontSize: 26)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            chef.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.bold,
                                              color: isUnlocked ? Colors.brown.shade900 : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        if (isSelected) ...[
                                          const SizedBox(width: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: const Text(
                                              'SEÇİLİ',
                                              style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold, color: Colors.green),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    Text(
                                      chef.description,
                                      style: TextStyle(fontSize: 10.5, color: Colors.brown.shade600),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isUnlocked)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text('🔒 ', style: TextStyle(fontSize: 10)),
                                      Text(
                                        '${chef.requiredStars} ⭐',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
