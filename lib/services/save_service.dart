import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for persisting game progress, unlocked levels, stars, high score, booster inventory, and customization skins
class SaveService {
  static const String _keyLastLevel = 'chef_merge_last_level';
  static const String _keyUnlockedLevels = 'chef_merge_unlocked_levels';
  static const String _keyLevelStars = 'chef_merge_level_stars';
  static const String _keyHighScore = 'chef_merge_high_score';
  static const String _keyEndlessHighScore = 'chef_merge_endless_high_score';
  static const String _keyMusicTrack = 'chef_merge_music_track';
  static const String _keySoundEnabled = 'chef_merge_sound_enabled';
  static const String _keyMusicEnabled = 'chef_merge_music_enabled';
  static const String _keyLanguage = 'chef_merge_language';

  static const String _keyBoardSkin = 'chef_merge_board_skin';
  static const String _keyChefAvatar = 'chef_merge_chef_avatar';
  static const String _keyFreezeBoosters = 'chef_merge_freeze_boosters';
  static const String _keySpatulaBoosters = 'chef_merge_spatula_boosters';
  static const String _keyBroomBoosters = 'chef_merge_broom_boosters';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Last Played Level
  static int getLastLevel() {
    return _prefs?.getInt(_keyLastLevel) ?? 0;
  }

  static Future<void> saveLastLevel(int levelIndex) async {
    await _prefs?.setInt(_keyLastLevel, levelIndex);
  }

  // Unlocked Levels
  static Set<int> getUnlockedLevels() {
    final list = _prefs?.getStringList(_keyUnlockedLevels);
    if (list != null && list.isNotEmpty) {
      return list.map((e) => int.tryParse(e) ?? 0).toSet();
    }
    return {0};
  }

  static Future<void> saveUnlockedLevels(Set<int> unlocked) async {
    final list = unlocked.map((e) => e.toString()).toList();
    await _prefs?.setStringList(_keyUnlockedLevels, list);
  }

  // Level Star Ratings
  static Map<int, int> getLevelStars() {
    final jsonStr = _prefs?.getString(_keyLevelStars);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final Map<String, dynamic> map = jsonDecode(jsonStr);
        return map.map((k, v) => MapEntry(int.parse(k), (v as num).toInt()));
      } catch (_) {}
    }
    return {};
  }

  static Future<void> saveLevelStars(Map<int, int> stars) async {
    final Map<String, int> stringKeyMap = stars.map((k, v) => MapEntry(k.toString(), v));
    await _prefs?.setString(_keyLevelStars, jsonEncode(stringKeyMap));
  }

  // High Scores (Campaign & Endless)
  static int getHighScore() {
    return _prefs?.getInt(_keyHighScore) ?? 0;
  }

  static Future<void> saveHighScore(int score) async {
    await _prefs?.setInt(_keyHighScore, score);
  }

  static int getEndlessHighScore() {
    return _prefs?.getInt(_keyEndlessHighScore) ?? 0;
  }

  static Future<void> saveEndlessHighScore(int score) async {
    await _prefs?.setInt(_keyEndlessHighScore, score);
  }

  // Audio Settings
  static int getSelectedMusicTrack() {
    return _prefs?.getInt(_keyMusicTrack) ?? 0;
  }

  static Future<void> saveSelectedMusicTrack(int index) async {
    await _prefs?.setInt(_keyMusicTrack, index);
  }

  static bool getSoundEnabled() {
    return _prefs?.getBool(_keySoundEnabled) ?? true;
  }

  static Future<void> saveSoundEnabled(bool enabled) async {
    await _prefs?.setBool(_keySoundEnabled, enabled);
  }

  static bool getMusicEnabled() {
    return _prefs?.getBool(_keyMusicEnabled) ?? true;
  }

  static Future<void> saveMusicEnabled(bool enabled) async {
    await _prefs?.setBool(_keyMusicEnabled, enabled);
  }

  // Customization Skins & Chef Avatars
  static String getBoardSkin() {
    return _prefs?.getString(_keyBoardSkin) ?? 'classic';
  }

  static Future<void> saveBoardSkin(String skin) async {
    await _prefs?.setString(_keyBoardSkin, skin);
  }

  static String getChefAvatar() {
    return _prefs?.getString(_keyChefAvatar) ?? '👨‍🍳';
  }

  static Future<void> saveChefAvatar(String avatar) async {
    await _prefs?.setString(_keyChefAvatar, avatar);
  }

  // Boosters Inventory
  static int getFreezeBoosters() {
    return _prefs?.getInt(_keyFreezeBoosters) ?? 3;
  }

  static Future<void> saveFreezeBoosters(int count) async {
    await _prefs?.setInt(_keyFreezeBoosters, count);
  }

  static int getSpatulaBoosters() {
    return _prefs?.getInt(_keySpatulaBoosters) ?? 3;
  }

  static Future<void> saveSpatulaBoosters(int count) async {
    await _prefs?.setInt(_keySpatulaBoosters, count);
  }

  static const String _keyDiscoveredSecretRecipes = 'chef_merge_discovered_secret_recipes';

  static int getBroomBoosters() {
    return _prefs?.getInt(_keyBroomBoosters) ?? 3;
  }

  static Future<void> saveBroomBoosters(int count) async {
    await _prefs?.setInt(_keyBroomBoosters, count);
  }

  // Discovered Secret Alchemy Recipes
  static Set<String> getDiscoveredSecretRecipes() {
    final list = _prefs?.getStringList(_keyDiscoveredSecretRecipes);
    if (list != null && list.isNotEmpty) {
      return list.toSet();
    }
    return {};
  }

  static Future<void> saveDiscoveredSecretRecipes(Set<String> secrets) async {
    await _prefs?.setStringList(_keyDiscoveredSecretRecipes, secrets.toList());
  }

  // Daily Lucky Wheel
  static const String _keyLastDailySpinDate = 'chef_merge_last_daily_spin_date';

  static String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  static bool canSpinDailyWheel() {
    final lastDate = _prefs?.getString(_keyLastDailySpinDate);
    final today = _getTodayDateString();
    return lastDate != today;
  }

  static Future<void> markDailyWheelSpun() async {
    final today = _getTodayDateString();
    await _prefs?.setString(_keyLastDailySpinDate, today);
  }

  static String? getLastDailySpinDate() {
    return _prefs?.getString(_keyLastDailySpinDate);
  }

  // Language Preference
  static String getLanguage() {
    return _prefs?.getString(_keyLanguage) ?? 'tr';
  }

  static Future<void> saveLanguage(String langCode) async {
    await _prefs?.setString(_keyLanguage, langCode);
  }

  /// Clears all stored game progress, stars, scores, boosters, and cosmetic customizations.
  /// If [keepSettings] is true, language and audio preferences are preserved.
  static Future<void> resetAllData({bool keepSettings = true}) async {
    await _prefs?.remove(_keyLastLevel);
    await _prefs?.remove(_keyUnlockedLevels);
    await _prefs?.remove(_keyLevelStars);
    await _prefs?.remove(_keyHighScore);
    await _prefs?.remove(_keyEndlessHighScore);
    await _prefs?.remove(_keyBoardSkin);
    await _prefs?.remove(_keyChefAvatar);
    await _prefs?.remove(_keyFreezeBoosters);
    await _prefs?.remove(_keySpatulaBoosters);
    await _prefs?.remove(_keyBroomBoosters);
    await _prefs?.remove(_keyDiscoveredSecretRecipes);
    await _prefs?.remove(_keyLastDailySpinDate);

    if (!keepSettings) {
      await _prefs?.remove(_keyLanguage);
      await _prefs?.remove(_keySoundEnabled);
      await _prefs?.remove(_keyMusicEnabled);
      await _prefs?.remove(_keyMusicTrack);
    }
  }
}
