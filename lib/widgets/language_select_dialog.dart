import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../services/sound_service.dart';

class LanguageSelectDialog extends StatefulWidget {
  const LanguageSelectDialog({super.key});

  @override
  State<LanguageSelectDialog> createState() => _LanguageSelectDialogState();
}

class _LanguageSelectDialogState extends State<LanguageSelectDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDF9),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: const Color(0xFFFFCC80), width: 2.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text('🌐', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          LocalizationService.tr('select_language'),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.brown.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    SoundService.playClick();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close_rounded),
                  color: Colors.brown.shade700,
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Language Buttons List
            ...LocalizationService.supportedLanguages.map((lang) {
              final isSelected = LocalizationService.lang == lang.code;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () async {
                    SoundService.playClick();
                    await LocalizationService.setLanguage(lang.code);
                    if (mounted) setState(() {});
                  },
                  borderRadius: BorderRadius.circular(18),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFFECB3)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFFF9800) : Colors.grey.shade300,
                        width: isSelected ? 2.5 : 1.2,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: Colors.orange.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(lang.flag, style: const TextStyle(fontSize: 26)),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  lang.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                                    color: isSelected ? Colors.brown.shade900 : Colors.brown.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Color(0xFFE65100),
                            size: 24,
                          )
                        else
                          Icon(
                            Icons.circle_outlined,
                            color: Colors.grey.shade400,
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 12),
            // Confirm / Close button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  SoundService.playClick();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF7043),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
