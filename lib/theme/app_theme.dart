import 'package:flutter/material.dart';

import 'app_style.dart';

/// Surface color shared by the neumorphism style: a soft, neutral gray
/// that lets the light and dark side shadows read clearly.
const Color neumorphSurfaceColor = Color(0xFFE0E5EC);

/// Builds the complete [ThemeData] for the requested [AppStyle].
///
/// Every style is expressed with a [ColorScheme] plus a few knobs that
/// define its personality (shadows, radii, backgrounds). Cards themselves
/// are rendered by `StyleCard`; this factory only sets the global stage.
ThemeData buildTheme(AppStyle style) {
  switch (style) {
    case AppStyle.light:
      return _lightTheme();
    case AppStyle.dark:
      return _darkTheme();
    case AppStyle.minimal:
      return _minimalTheme();
    case AppStyle.maximal:
      return _maximalTheme();
    case AppStyle.neumorph:
      return _neumorphTheme();
    case AppStyle.glass:
      return _glassTheme();
  }
}

/// Gradient painted behind the app for styles that need a colorful scaffold.
///
/// Returns `null` for styles that paint a plain solid background. The app
/// root (`FlutterDocs`) applies it behind the [MaterialApp] Navigator so the
/// whole background is covered, and the selected style renders exactly.
List<Color>? buildBackgroundGradient(AppStyle style) {
  switch (style) {
    case AppStyle.maximal:
      // Soft sunset pastels: colorful, yet keeps dark text readable.
      return const [
        Color(0xFFFFE9F2),
        Color(0xFFF2E7FF),
        Color(0xFFE1F4F8),
      ];
    case AppStyle.glass:
      // Indigo -> purple -> pink tones that make the frosted blur pop.
      return const [
        Color(0xFF9FA8DA),
        Color(0xFFCE93D8),
        Color(0xFFF48FB1),
      ];
    default:
      return null;
  }
}

/// Light: the Material 3 baseline from the app seed. Airy and clean.
ThemeData _lightTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4));
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: const CardThemeData(elevation: 2),
  );
}

/// Dark: the same seed mapped to a dark color scheme. Comfortable at night.
ThemeData _darkTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.dark,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: const CardThemeData(elevation: 2),
  );
}

/// Minimal: neutral surfaces, flat cards, small radius, no shadows.
ThemeData _minimalTheme() {
  // A gray seed keeps the whole palette desaturated.
  final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF757575));
  const background = Color(0xFFF7F7F9);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: Color(0xFF212121),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    // Flat cards: nothing floating, nothing shadowed.
    cardTheme: const CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}

/// Maximal: saturated, vibrant surfaces, strong colored shadows.
ThemeData _maximalTheme() {
  // Vivid magenta seed; the vibrant variant pushes color saturation up.
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFD81B60),
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    // The real gradient lives in FlutterDocs.builder; a transparent
    // scaffold lets it show through.
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 12,
      shadowColor: scheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );
}

/// Neumorph: a soft gray world where the cards provide the relief.
ThemeData _neumorphTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF78909C));
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: neumorphSurfaceColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: neumorphSurfaceColor,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      color: neumorphSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );
}

/// Glass: transparent surfaces over a vivid gradient background.
ThemeData _glassTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0));
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    // The vibrant gradient is provided by FlutterDocs.builder.
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );
}