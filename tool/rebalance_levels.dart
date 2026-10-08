import 'dart:io';

void main() {
  final file = File('lib/models/level_model.dart');
  var content = file.readAsStringSync();

  // 1. Update durationSeconds getter (1 min to 5 mins)
  final durationGetterRegex = RegExp(
    r'int get durationSeconds \{[\s\S]*?return \(calculated ~\/ 5\) \* 5;\s*\}',
  );

  const newDurationGetter = '''int get durationSeconds {
    if (customDurationSeconds != null) return customDurationSeconds!;
    if (number <= 1) return 60; // 1. Bölüm: 60 sn (1 dakika)
    if (number >= 100) return 300; // 100. Bölüm: 300 sn (5 dakika)
    // 60 sn ile 300 sn arasında kademeli artış (5 saniyelik adımlarla yuvarlanmış)
    final calculated = 60 + ((number - 1) * 240 / 99).round();
    return (calculated ~/ 5) * 5;
  }''';

  if (content.contains(durationGetterRegex)) {
    content = content.replaceFirst(durationGetterRegex, newDurationGetter);
  }

  // 2. Update level targetScore, star1Score, star2Score, star3Score
  // Requirement: 1-Star barajı (star1Score) MINIMUM 1000 PUAN olmalı!
  // Level 1: star1Score = 1000, star2Score = 1650, star3Score = 2200
  // Level 100: star1Score = 7500, star2Score = 12500, star3Score = 16650
  final levelBlockRegex = RegExp(
    r'number:\s*(\d+),[\s\S]*?targetScore:\s*(\d+),\s*star1Score:\s*(\d+),\s*star2Score:\s*(\d+),\s*star3Score:\s*(\d+),',
  );

  content = content.replaceAllMapped(levelBlockRegex, (match) {
    final full = match.group(0)!;
    final num = int.parse(match.group(1)!);

    // 1-Yıldız barajı: 1. Bölümde 1000, 100. Bölümde 7500
    final star1 = 1000 + (((num - 1) * 6500) ~/ 99 ~/ 50) * 50;
    // 3-Yıldız hedefi (yaklaşık star1 / 0.45)
    final target = ((star1 / 0.45) ~/ 50) * 50;
    // 2-Yıldız hedefi (yaklaşık %75)
    final star2 = ((target * 0.75) ~/ 50) * 50;
    final star3 = target;

    var replaced = full.replaceFirst(RegExp(r'targetScore:\s*\d+'), 'targetScore: $target');
    replaced = replaced.replaceFirst(RegExp(r'star1Score:\s*\d+'), 'star1Score: $star1');
    replaced = replaced.replaceFirst(RegExp(r'star2Score:\s*\d+'), 'star2Score: $star2');
    replaced = replaced.replaceFirst(RegExp(r'star3Score:\s*\d+'), 'star3Score: $star3');
    return replaced;
  });

  file.writeAsStringSync(content);
  print('Successfully rebalanced all 100 levels with star1Score >= 1000!');
}
