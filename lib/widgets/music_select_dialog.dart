import 'package:flutter/material.dart';
import '../services/sound_service.dart';
import '../services/save_service.dart';

class MusicSelectDialog extends StatefulWidget {
  const MusicSelectDialog({super.key});

  @override
  State<MusicSelectDialog> createState() => _MusicSelectDialogState();
}

class _MusicSelectDialogState extends State<MusicSelectDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: const Color(0xFFFFFDF9),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 440),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  child: const Text('🎵', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oyun Müziği & Ses Ayarları',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      Text(
                        'Süre azaldıkça hızlanan 3 özel oyun müziği',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.brown.shade600,
                        ),
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
            const Divider(height: 18),

            // Music Toggle Switch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.shade50.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        SoundService.musicEnabled
                            ? Icons.music_note_rounded
                            : Icons.music_off_rounded,
                        color: Colors.deepOrange,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Arka Plan Müziği',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade900,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: SoundService.musicEnabled,
                    activeTrackColor: Colors.deepOrange,
                    onChanged: (val) {
                      setState(() {
                        SoundService.musicEnabled = val;
                      });
                      SaveService.saveMusicEnabled(val);
                      if (val) {
                        SoundService.playBgm();
                      } else {
                        SoundService.stopBgm();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Track Options List
            Text(
              'Çalacak Müziği Seçin:',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
            ),
            const SizedBox(height: 8),

            ...SoundService.tracks.map((track) {
              final isSelected = SoundService.selectedTrackIndex == track.id;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      SoundService.selectTrack(track.id);
                    });
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.orange.shade100.withValues(alpha: 0.7)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? Colors.deepOrange
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.deepOrange.withValues(alpha: 0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Track Icon
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.deepOrange.withValues(alpha: 0.2)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(track.icon, style: const TextStyle(fontSize: 22)),
                        ),
                        const SizedBox(width: 10),

                        // Track Title & Description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    track.title,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.brown.shade900
                                          : Colors.grey.shade800,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 1.5),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        'Seçili',
                                        style: TextStyle(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                track.subtitle,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.brown.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Checkmark
                        Icon(
                          isSelected
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          color: isSelected ? Colors.deepOrange : Colors.grey.shade400,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 6),
            // Info footnote
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: const Row(
                children: [
                  Text('⚡', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Son 45 saniyede tempo 1.15x, son 20 saniyede 1.35x hızlanarak heyecan katar!',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown,
                      ),
                    ),
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
