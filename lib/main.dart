import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/chat_screen.dart';
import 'services/theme_service.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService.load();
  runApp(const PeaceAIApp());
}

class PeaceAIApp extends StatelessWidget {
  const PeaceAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.mode,
      builder: (context, mode, _) => MaterialApp(
        title: 'Peace AI',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        themeMode: mode,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/chat': (context) => const ChatScreen(),
        },
      ),
    );
  }
}
