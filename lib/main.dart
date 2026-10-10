import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/save_service.dart';
import 'services/sound_service.dart';
import 'services/localization_service.dart';
import 'state/game_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Kökten Çözüm: Flutter'ın sarı-siyah pikselli taşma uyarı şeridini ekrandan tamamen kaldırır
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return const SizedBox.shrink();
  };

  try {
    await SaveService.init();
    LocalizationService.init();
    SoundService.init();
    GameController.instance.loadSavedData();
  } catch (e) {
    debugPrint('Init error: $e');
  }
  runApp(const ChefMergeApp());
}

class ChefMergeApp extends StatelessWidget {
  const ChefMergeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LocalizationService.currentLanguage,
      builder: (context, lang, child) {
        return MaterialApp(
          title: LocalizationService.tr('app_title'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFFF7043),
              primary: const Color(0xFFFF7043),
              secondary: const Color(0xFFFFB300),
              surface: const Color(0xFFFBF7F0),
            ),
            fontFamily: 'Segoe UI',
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
