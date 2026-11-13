import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The chosen theme, saved on the device.
class ThemeService {
  static const String _key = 'theme_mode';

  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.system);

  static Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_key);
      mode.value = ThemeMode.values.firstWhere(
        (m) => m.name == saved,
        orElse: () => ThemeMode.system,
      );
    } catch (e) {
      // Storage unavailable: keep following the system setting.
    }
  }

  static Future<void> setMode(ThemeMode value) async {
    mode.value = value;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, value.name);
    } catch (e) {
      // The theme still changes for this run; it is just not saved.
    }
  }
}
