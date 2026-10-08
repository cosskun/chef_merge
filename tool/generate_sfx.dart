import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

void main() {
  final outputDir = Directory('assets/sounds');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // 1. Delivery Sound: Crisp Restaurant Service Bell / Chime (Ding-Ding)
  final deliveryWav = generateDeliveryBell();
  File('assets/sounds/sfx_delivery.wav').writeAsBytesSync(deliveryWav);
  print('Generated: assets/sounds/sfx_delivery.wav (${deliveryWav.length} bytes)');

  // 2. Fast Delivery / VIP Sound: Sparkling Ascending Fanfare
  final fastDeliveryWav = generateFastDeliveryChime();
  File('assets/sounds/sfx_fast_delivery.wav').writeAsBytesSync(fastDeliveryWav);
  print('Generated: assets/sounds/sfx_fast_delivery.wav (${fastDeliveryWav.length} bytes)');

  // 3. Merge Pop Sound
  final mergeWav = generateMergePop();
  File('assets/sounds/sfx_merge.wav').writeAsBytesSync(mergeWav);
  print('Generated: assets/sounds/sfx_merge.wav (${mergeWav.length} bytes)');

  // 4. Trash / Swoosh Sound
  final trashWav = generateTrashSwoosh();
  File('assets/sounds/sfx_trash.wav').writeAsBytesSync(trashWav);
  print('Generated: assets/sounds/sfx_trash.wav (${trashWav.length} bytes)');

  // 5. Timeout Alert Sound
  final timeoutWav = generateTimeoutBuzz();
  File('assets/sounds/sfx_timeout.wav').writeAsBytesSync(timeoutWav);
  print('Generated: assets/sounds/sfx_timeout.wav (${timeoutWav.length} bytes)');
}

Uint8List createWav(List<double> samples, int sampleRate) {
  final byteRate = sampleRate * 2; // 16-bit mono = 2 bytes per sample
  final dataSize = samples.length * 2;
  final totalSize = 36 + dataSize;

  final buffer = ByteData(44 + dataSize);

  // RIFF Header
  buffer.setUint8(0, 0x52); // R
  buffer.setUint8(1, 0x49); // I
  buffer.setUint8(2, 0x46); // F
  buffer.setUint8(3, 0x46); // F
  buffer.setUint32(4, totalSize, Endian.little);
  buffer.setUint8(8, 0x57);  // W
  buffer.setUint8(9, 0x41);  // A
  buffer.setUint8(10, 0x56); // V
  buffer.setUint8(11, 0x45); // E

  // fmt chunk
  buffer.setUint8(12, 0x66); // f
  buffer.setUint8(13, 0x6D); // m
  buffer.setUint8(14, 0x74); // t
  buffer.setUint8(15, 0x20); // ' '
  buffer.setUint32(16, 16, Endian.little); // Chunk size
  buffer.setUint16(20, 1, Endian.little);  // PCM format
  buffer.setUint16(22, 1, Endian.little);  // Mono (1 channel)
  buffer.setUint32(24, sampleRate, Endian.little);
  buffer.setUint32(28, byteRate, Endian.little);
  buffer.setUint16(32, 2, Endian.little);  // Block align
  buffer.setUint16(34, 16, Endian.little); // 16 bits per sample

  // data chunk
  buffer.setUint8(36, 0x64); // d
  buffer.setUint8(37, 0x61); // a
  buffer.setUint8(38, 0x74); // t
  buffer.setUint8(39, 0x61); // a
  buffer.setUint32(40, dataSize, Endian.little);

  int offset = 44;
  for (final s in samples) {
    final clamped = s.clamp(-1.0, 1.0);
    final sampleInt = (clamped * 32767).toInt();
    buffer.setInt16(offset, sampleInt, Endian.little);
    offset += 2;
  }

  return buffer.buffer.asUint8List();
}

/// Tatlı, berrak şef servis zili (Ding-Dong / Hotel Bell)
Uint8List generateDeliveryBell() {
  const sampleRate = 44100;
  const durationSec = 0.40;
  final totalSamples = (sampleRate * durationSec).toInt();
  final samples = List<double>.filled(totalSamples, 0.0);

  // 2 Harmonik ton: 1046.5 Hz (C6) + 1318.5 Hz (E6) + 2093 Hz (C7 harmonics)
  for (int i = 0; i < totalSamples; i++) {
    final t = i / sampleRate;
    final env1 = exp(-7.0 * t); // Çabuk vuruş ve berrak çınlama
    final env2 = exp(-9.0 * t);

    final tone1 = sin(2 * pi * 1046.50 * t);
    final tone2 = sin(2 * pi * 1318.51 * t);
    final tone3 = sin(2 * pi * 2093.00 * t) * 0.35; // Tatlı parlaklık
    final tone4 = sin(2 * pi * 2637.02 * t) * 0.15;

    samples[i] = (tone1 * 0.40 + tone2 * 0.35 + tone3 + tone4) * env1;
  }

  return createWav(samples, sampleRate);
}

/// Parlak, neşeli 3 notalı zafer tınısı (A -> C# -> E arpej & çınlama)
Uint8List generateFastDeliveryChime() {
  const sampleRate = 44100;
  const durationSec = 0.50;
  final totalSamples = (sampleRate * durationSec).toInt();
  final samples = List<double>.filled(totalSamples, 0.0);

  final notes = [880.0, 1108.73, 1318.51, 1760.0];
  final noteStartTimes = [0.0, 0.08, 0.16, 0.24];

  for (int i = 0; i < totalSamples; i++) {
    final t = i / sampleRate;
    double sample = 0.0;

    for (int n = 0; n < notes.length; n++) {
      final startTime = noteStartTimes[n];
      if (t >= startTime) {
        final noteT = t - startTime;
        final env = exp(-8.0 * noteT);
        final freq = notes[n];
        final tone = sin(2 * pi * freq * noteT) + 0.3 * sin(2 * pi * (freq * 2) * noteT);
        sample += tone * env * 0.28;
      }
    }

    samples[i] = sample;
  }

  return createWav(samples, sampleRate);
}

/// Buble merge pop sesi
Uint8List generateMergePop() {
  const sampleRate = 44100;
  const durationSec = 0.15;
  final totalSamples = (sampleRate * durationSec).toInt();
  final samples = List<double>.filled(totalSamples, 0.0);

  for (int i = 0; i < totalSamples; i++) {
    final t = i / sampleRate;
    final progress = t / durationSec;
    // Frekans 350 Hz'den 850 Hz'e tatlıca yükselir
    final freq = 350.0 + (500.0 * sin(progress * pi / 2));
    final env = sin(progress * pi) * exp(-4.0 * t);
    samples[i] = sin(2 * pi * freq * t) * env * 0.65;
  }

  return createWav(samples, sampleRate);
}

/// Çöp atma / süpürme efekti
Uint8List generateTrashSwoosh() {
  const sampleRate = 44100;
  const durationSec = 0.18;
  final totalSamples = (sampleRate * durationSec).toInt();
  final samples = List<double>.filled(totalSamples, 0.0);
  final rand = Random(42);

  for (int i = 0; i < totalSamples; i++) {
    final t = i / sampleRate;
    final progress = t / durationSec;
    final freq = 600.0 - (400.0 * progress);
    final env = sin(progress * pi) * exp(-5.0 * t);
    final noise = (rand.nextDouble() * 2 - 1) * 0.2;
    samples[i] = (sin(2 * pi * freq * t) * 0.5 + noise) * env * 0.55;
  }

  return createWav(samples, sampleRate);
}

/// Süre bitişi uyarısı
Uint8List generateTimeoutBuzz() {
  const sampleRate = 44100;
  const durationSec = 0.30;
  final totalSamples = (sampleRate * durationSec).toInt();
  final samples = List<double>.filled(totalSamples, 0.0);

  for (int i = 0; i < totalSamples; i++) {
    final t = i / sampleRate;
    final env = exp(-5.0 * t);
    final tone1 = sin(2 * pi * 330.0 * t);
    final tone2 = sin(2 * pi * 311.13 * t); // Hafif dissonant uyarı
    samples[i] = (tone1 * 0.5 + tone2 * 0.5) * env * 0.45;
  }

  return createWav(samples, sampleRate);
}
