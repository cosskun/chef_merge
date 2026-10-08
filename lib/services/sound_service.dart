import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

import 'save_service.dart';

class MusicTrackInfo {
  final int id;
  final String title;
  final String subtitle;
  final String icon;
  final String assetPath;

  const MusicTrackInfo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.assetPath,
  });
}

class SoundService {
  static bool soundEnabled = true;
  static bool musicEnabled = true;

  static final Map<String, Uint8List> _soundBytesCache = {};

  static final List<MusicTrackInfo> tracks = [
    const MusicTrackInfo(
      id: 0,
      title: 'Neşeli Şef Mutfağı',
      subtitle: 'Akustik ritimli ve marimba melodili çılgın mutfak havası',
      icon: '🍳',
      assetPath: 'sounds/music_kitchen.wav',
    ),
    const MusicTrackInfo(
      id: 1,
      title: 'Paris Cafe & Bistro',
      subtitle: 'Sıcak akordeon tınıları ve Fransız swing caz melodisi',
      icon: '🥐',
      assetPath: 'sounds/music_bistro.wav',
    ),
    const MusicTrackInfo(
      id: 2,
      title: 'Tokyo Arcade & Gece Pazarı',
      subtitle: 'Enerjik 16-bit synth melodisi ve hareketli sokak ritimleri',
      icon: '🍣',
      assetPath: 'sounds/music_arcade.wav',
    ),
  ];

  static int selectedTrackIndex = 0;
  static MusicTrackInfo get currentTrack => tracks[selectedTrackIndex];

  static AudioPlayer? _bgmPlayer;
  static AudioPlayer? _sfxPlayer;
  static double _currentPlaybackRate = 1.0;
  static bool _isPlayingBgm = false;
  static bool get isPlayingBgm => _isPlayingBgm;

  static Future<Uint8List?> _loadSoundBytes(String assetPath) async {
    if (_soundBytesCache.containsKey(assetPath)) {
      return _soundBytesCache[assetPath];
    }
    try {
      final fullPath = assetPath.startsWith('assets/') ? assetPath : 'assets/$assetPath';
      final byteData = await rootBundle.load(fullPath);
      final bytes = byteData.buffer.asUint8List();
      _soundBytesCache[assetPath] = bytes;
      return bytes;
    } catch (_) {
      return null;
    }
  }

  static void init() {
    selectedTrackIndex = SaveService.getSelectedMusicTrack().clamp(0, tracks.length - 1);
    soundEnabled = SaveService.getSoundEnabled();
    musicEnabled = SaveService.getMusicEnabled();

    try {
      AudioPlayer.global.setAudioContext(
        AudioContext(
          android: const AudioContextAndroid(
            isSpeakerphoneOn: false,
            stayAwake: false,
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.game,
            audioFocus: AndroidAudioFocus.none,
          ),
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.ambient,
            options: const {
              AVAudioSessionOptions.mixWithOthers,
              AVAudioSessionOptions.defaultToSpeaker,
            },
          ),
        ),
      );
    } catch (_) {}

    if (_bgmPlayer == null) {
      _bgmPlayer = AudioPlayer(playerId: 'chef_merge_bgm');
      _bgmPlayer?.setReleaseMode(ReleaseMode.loop);
      _bgmPlayer?.setVolume(0.55);
    }
    if (_sfxPlayer == null) {
      _sfxPlayer = AudioPlayer(playerId: 'chef_merge_sfx');
      _sfxPlayer?.setPlayerMode(PlayerMode.lowLatency);
    }

    // Preload SFX and BGM bytes in background so Web never issues direct media URLs
    for (final sfx in [
      'sounds/sfx_merge.wav',
      'sounds/sfx_delivery.wav',
      'sounds/sfx_fast_delivery.wav',
      'sounds/sfx_timeout.wav',
      'sounds/sfx_trash.wav',
    ]) {
      _loadSoundBytes(sfx);
    }
    for (final track in tracks) {
      _loadSoundBytes(track.assetPath);
    }
  }

  static Future<void> playBgm({bool forceRestart = false}) async {
    if (!musicEnabled) return;
    init();
    if (_isPlayingBgm && !forceRestart) return;

    try {
      final track = currentTrack;
      await _bgmPlayer?.stop();
      _currentPlaybackRate = 1.0;
      await _bgmPlayer?.setPlaybackRate(1.0);

      final bytes = await _loadSoundBytes(track.assetPath);
      if (bytes != null) {
        await _bgmPlayer?.play(BytesSource(bytes, mimeType: 'audio/wav'));
      } else {
        await _bgmPlayer?.play(AssetSource(track.assetPath));
      }
      _isPlayingBgm = true;
    } catch (_) {
      // Audio fallback
    }
  }

  static Future<void> stopBgm() async {
    try {
      await _bgmPlayer?.stop();
      _isPlayingBgm = false;
    } catch (_) {}
  }

  static Future<void> pauseBgm() async {
    try {
      await _bgmPlayer?.pause();
      _isPlayingBgm = false;
    } catch (_) {}
  }

  static Future<void> resumeBgm() async {
    if (!musicEnabled) return;
    try {
      await _bgmPlayer?.resume();
      _isPlayingBgm = true;
    } catch (_) {}
  }

  static Future<void> selectTrack(int index) async {
    if (index >= 0 && index < tracks.length) {
      selectedTrackIndex = index;
      await SaveService.saveSelectedMusicTrack(index);
      if (musicEnabled) {
        await playBgm(forceRestart: true);
      }
    }
  }

  static bool get isMuted => !soundEnabled && !musicEnabled;

  static Future<void> toggleMasterAudio() async {
    if (isMuted) {
      soundEnabled = true;
      musicEnabled = true;
      await SaveService.saveSoundEnabled(true);
      await SaveService.saveMusicEnabled(true);
      await playBgm(forceRestart: true);
    } else {
      soundEnabled = false;
      musicEnabled = false;
      await SaveService.saveSoundEnabled(false);
      await SaveService.saveMusicEnabled(false);
      await stopBgm();
      try {
        await _sfxPlayer?.stop();
      } catch (_) {}
    }
  }

  static Future<void> toggleSound() async {
    soundEnabled = !soundEnabled;
    await SaveService.saveSoundEnabled(soundEnabled);
    if (!soundEnabled) {
      try {
        await _sfxPlayer?.stop();
      } catch (_) {}
    }
  }

  static Future<void> toggleMusic() async {
    musicEnabled = !musicEnabled;
    await SaveService.saveMusicEnabled(musicEnabled);
    if (!musicEnabled) {
      await stopBgm();
    } else {
      await playBgm(forceRestart: true);
    }
  }

  /// Süre azaldıkça müziği dinamik olarak hızlandırır!
  /// Son 45 sn: 1.15x hız
  /// Son 20 sn: 1.35x telaşlı Mario hızı!
  static void updateTempoForRemainingSeconds(double remainingSeconds) {
    if (!musicEnabled || _bgmPlayer == null) return;

    double targetRate = 1.0;
    if (remainingSeconds <= 20.0 && remainingSeconds > 0) {
      targetRate = 1.35; // Süper heyecanlı son 20 saniye
    } else if (remainingSeconds <= 45.0 && remainingSeconds > 0) {
      targetRate = 1.15; // Hızlanmaya başlayan son 45 saniye
    } else {
      targetRate = 1.0;  // Normal rahat tempo
    }

    if ((targetRate - _currentPlaybackRate).abs() > 0.05) {
      _currentPlaybackRate = targetRate;
      try {
        _bgmPlayer?.setPlaybackRate(targetRate);
      } catch (_) {}
    }
  }

  static void _playSfx(String fileName) async {
    if (!soundEnabled) return;
    try {
      _sfxPlayer ??= AudioPlayer();
      _sfxPlayer?.stop().catchError((_) {});
      final assetPath = 'sounds/$fileName';
      final bytes = await _loadSoundBytes(assetPath);
      if (bytes != null) {
        _sfxPlayer?.play(BytesSource(bytes, mimeType: 'audio/wav'), volume: 0.9).catchError((_) {});
      } else {
        _sfxPlayer?.play(AssetSource(assetPath), volume: 0.9).catchError((_) {});
      }
    } catch (_) {
      // Graceful fallback for environments/tests without audio drivers
    }
  }

  // SFX Effect sounds
  static void playClick() {
    if (!soundEnabled) return;
    try {
      HapticFeedback.selectionClick();
      SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  static void playSpawn() {
    if (!soundEnabled) return;
    try {
      HapticFeedback.lightImpact();
      SystemSound.play(SystemSoundType.click);
    } catch (_) {}
  }

  static void playMerge() {
    if (!soundEnabled) return;
    try {
      HapticFeedback.mediumImpact();
      SystemSound.play(SystemSoundType.click);
    } catch (_) {}
    _playSfx('sfx_merge.wav');
  }

  static void playNormalDelivery() {
    if (!soundEnabled) return;
    try {
      HapticFeedback.heavyImpact();
      SystemSound.play(SystemSoundType.alert);
    } catch (_) {}
    _playSfx('sfx_delivery.wav');
  }

  static void playFastDelivery() {
    if (!soundEnabled) return;
    try {
      HapticFeedback.heavyImpact();
      SystemSound.play(SystemSoundType.alert);
    } catch (_) {}
    _playSfx('sfx_fast_delivery.wav');
  }

  static void playTimeout() {
    if (!soundEnabled) return;
    try {
      HapticFeedback.vibrate();
      SystemSound.play(SystemSoundType.alert);
    } catch (_) {}
    _playSfx('sfx_timeout.wav');
  }

  static void playTrash() {
    if (!soundEnabled) return;
    try {
      HapticFeedback.selectionClick();
      SystemSound.play(SystemSoundType.click);
    } catch (_) {}
    _playSfx('sfx_trash.wav');
  }
}
