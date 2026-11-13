import 'package:flutter/material.dart';

/// The Arabic face, bundled under assets/fonts (SIL Open Font License).
const String arabicFont = 'Amiri';

// A printed page: off-white paper, deep ink, and the red used for headings
// in printed mushafs (the rubric). No gradients, no tints.
ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final paper = dark ? const Color(0xFF17140F) : const Color(0xFFFAF6EC);
  final block = dark ? const Color(0xFF201C16) : const Color(0xFFFFFDF7);
  final shade = dark ? const Color(0xFF2B261E) : const Color(0xFFEFE9D9);
  final ink = dark ? const Color(0xFFEDE6D6) : const Color(0xFF1F1B16);
  final faded = dark ? const Color(0xFFBDB4A2) : const Color(0xFF574F44);
  final rule = dark ? const Color(0xFF4A4335) : const Color(0xFFD2C8B2);
  final rubric = dark ? const Color(0xFFEC9282) : const Color(0xFF9B1C1C);

  final scheme = ColorScheme(
    brightness: brightness,
    primary: ink,
    onPrimary: paper,
    secondary: rubric,
    onSecondary: paper,
    error: rubric,
    onError: paper,
    surface: paper,
    onSurface: ink,
    onSurfaceVariant: faded,
    outline: faded,
    outlineVariant: rule,
    surfaceTint: Colors.transparent,
    surfaceContainerLowest: block,
    surfaceContainerLow: block,
    surfaceContainer: block,
    surfaceContainerHigh: block,
    surfaceContainerHighest: shade,
    secondaryContainer: shade,
    onSecondaryContainer: ink,
    inverseSurface: ink,
    onInverseSurface: paper,
  );

  const corner = BorderRadius.all(Radius.circular(4));
  const shape = RoundedRectangleBorder(borderRadius: corner);
  final outlined = RoundedRectangleBorder(
    borderRadius: corner,
    side: BorderSide(color: rule),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: paper,
    dividerTheme: DividerThemeData(color: rule, thickness: 1, space: 1),
    appBarTheme: AppBarTheme(
      backgroundColor: paper,
      foregroundColor: ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: Border(bottom: BorderSide(color: rule)),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: block,
      elevation: 0,
      shape: outlined,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: paper,
      side: BorderSide(color: rule),
      shape: shape,
      labelStyle: TextStyle(color: ink),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: block,
      hintStyle: TextStyle(color: faded),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: corner,
        borderSide: BorderSide(color: rule),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: corner,
        borderSide: BorderSide(color: rule),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: corner,
        borderSide: BorderSide(color: ink, width: 1.5),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(shape: shape),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(shape: shape),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: shape,
      elevation: 0,
    ),
  );
}
