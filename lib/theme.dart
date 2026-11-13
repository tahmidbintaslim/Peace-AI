import 'package:flutter/material.dart';

/// The Arabic face, bundled under assets/fonts (SIL Open Font License).
const String arabicFont = 'Amiri';

/// The UI face, bundled under assets/fonts (SIL Open Font License).
const String uiFont = 'Anek Bangla';

/// A text style in the UI face. The font file is variable, so the weight and
/// the normal width are set on its axes as well as on [fontWeight].
TextStyle uiText(double size, double lineHeight, [int weight = 400]) {
  return TextStyle(
    fontFamily: uiFont,
    fontSize: size,
    height: lineHeight / size,
    fontWeight: FontWeight.values[weight ~/ 100 - 1],
    fontVariations: [
      FontVariation('wght', weight.toDouble()),
      const FontVariation('wdth', 100),
    ],
    letterSpacing: 0,
  );
}

// The Ramadan Planner design system (its "v4" tokens): a pale green-grey
// page, white cards, deep teal fills and ink; the night theme swaps the teal
// for mint on dark green.
ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final page = dark ? const Color(0xFF0B1A17) : const Color(0xFFF4F7F6);
  final card = dark ? const Color(0xFF12302A) : const Color(0xFFFFFFFF);
  final raised = dark ? const Color(0xFF163A33) : const Color(0xFFFFFFFF);
  final bar = dark ? const Color(0xFF0F2420) : const Color(0xFFFFFFFF);
  final tonal = dark ? const Color(0xFF17423A) : const Color(0xFFE3F1EE);
  final ink = dark ? const Color(0xFFE8F1EF) : const Color(0xFF10302B);
  final muted = dark ? const Color(0xFFCFE0DC) : const Color(0xFF3F5A54);
  final rule = dark ? const Color(0xFF1D3F38) : const Color(0xFFE3EAE8);
  final input = dark ? const Color(0xFF5F918B) : const Color(0xFF7A8F8A);
  final fill = dark ? const Color(0xFF6BD3C0) : const Color(0xFF0E7C6B);
  final onFill = dark ? const Color(0xFF06110F) : const Color(0xFFFFFFFF);
  final accent = dark ? const Color(0xFF6BD3C0) : const Color(0xFF0B6E5F);
  final danger = dark ? const Color(0xFFFFB4A9) : const Color(0xFFB42318);

  final scheme = ColorScheme(
    brightness: brightness,
    primary: fill,
    onPrimary: onFill,
    secondary: accent,
    onSecondary: onFill,
    error: danger,
    onError: dark ? const Color(0xFF06110F) : Colors.white,
    surface: page,
    onSurface: ink,
    onSurfaceVariant: muted,
    outline: input,
    outlineVariant: rule,
    surfaceTint: Colors.transparent,
    surfaceContainerLowest: card,
    surfaceContainerLow: card,
    surfaceContainer: bar,
    surfaceContainerHigh: raised,
    surfaceContainerHighest: tonal,
    secondaryContainer: tonal,
    onSecondaryContainer: accent,
    inverseSurface: ink,
    onInverseSurface: page,
  );

  final headline = uiText(17, 26, 600);
  final body = uiText(17, 26);
  final small = uiText(15, 22);
  final caption = uiText(13, 20, 500);
  final textTheme = TextTheme(
    displayLarge: uiText(48, 64, 600),
    displayMedium: uiText(34, 48, 600),
    displaySmall: uiText(34, 48, 600),
    headlineLarge: uiText(28, 40, 600),
    headlineMedium: uiText(28, 40, 600),
    headlineSmall: uiText(22, 32, 600),
    titleLarge: uiText(20, 30, 600),
    titleMedium: headline,
    titleSmall: uiText(15, 22, 600),
    bodyLarge: body,
    bodyMedium: small,
    bodySmall: caption,
    labelLarge: uiText(15, 22, 600),
    labelMedium: caption,
    labelSmall: caption,
  ).apply(bodyColor: ink, displayColor: ink);

  const control = BorderRadius.all(Radius.circular(12));
  const controlShape = RoundedRectangleBorder(borderRadius: control);
  const cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );
  OutlineInputBorder field(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: control,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: uiFont,
    textTheme: textTheme,
    scaffoldBackgroundColor: page,
    dividerTheme: DividerThemeData(color: rule, thickness: 1, space: 1),
    appBarTheme: AppBarTheme(
      backgroundColor: bar,
      foregroundColor: ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge,
      shape: Border(bottom: BorderSide(color: rule)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: bar,
      elevation: 0,
      height: 64,
      indicatorColor: tonal,
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected) ? accent : muted,
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => caption.copyWith(
          color: states.contains(WidgetState.selected) ? accent : muted,
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: raised,
      elevation: 0,
      shape: cardShape,
      titleTextStyle: textTheme.titleLarge,
      contentTextStyle: small.copyWith(color: ink),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: accent,
      titleTextStyle: body.copyWith(color: ink),
      subtitleTextStyle: small.copyWith(color: muted),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: tonal,
      side: BorderSide.none,
      shape: const StadiumBorder(),
      labelStyle: textTheme.labelLarge?.copyWith(color: accent),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: card,
      hoverColor: Colors.transparent,
      hintStyle: small.copyWith(color: muted),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      border: field(input),
      enabledBorder: field(input),
      focusedBorder: field(fill, 2),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(44, 44),
        shape: controlShape,
        textStyle: headline,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(44, 44),
        shape: controlShape,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accent,
        minimumSize: const Size(44, 44),
        shape: controlShape,
        textStyle: textTheme.labelLarge,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: controlShape,
      elevation: 0,
      contentTextStyle: small.copyWith(color: page),
    ),
  );
}
