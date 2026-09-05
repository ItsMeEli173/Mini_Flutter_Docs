import 'package:flutter/material.dart';

/// The visual styles the app can switch between.
///
/// Each style is a full [ThemeData] (see `buildTheme`) plus a matching card
/// treatment (see [StyleCard]). The demos inside the lessons always keep
/// their dark "embedded IDE" look regardless of the active style.
enum AppStyle { light, dark, minimal, maximal, neumorph, glass }

/// Convenience metadata used to render the style picker UI.
extension AppStyleInfo on AppStyle {
  /// Short Spanish label shown in the picker.
  String get label => switch (this) {
        AppStyle.light => 'Claro',
        AppStyle.dark => 'Oscuro',
        AppStyle.minimal => 'Minimalismo',
        AppStyle.maximal => 'Maximalismo',
        AppStyle.neumorph => 'Neumorfismo',
        AppStyle.glass => 'Glassmorfismo',
      };

  /// Short Spanish description shown under the label.
  String get description => switch (this) {
        AppStyle.light => 'Tema de Material 3 con aire y simplicidad.',
        AppStyle.dark => 'Tema oscuro, cómodo para estudiar de noche.',
        AppStyle.minimal => 'Superficies planas, sin sombras ni ruido visual.',
        AppStyle.maximal => 'Colores vivos, gradientes y sombras con carácter.',
        AppStyle.neumorph => 'Relieves suaves con sombras claras y oscuras.',
        AppStyle.glass => 'Paneles translúcidos sobre un fondo colorido.',
      };

  /// Material icon that represents the style in the picker.
  IconData get icon => switch (this) {
        AppStyle.light => Icons.light_mode_outlined,
        AppStyle.dark => Icons.dark_mode_outlined,
        AppStyle.minimal => Icons.remove_circle_outline,
        AppStyle.maximal => Icons.auto_awesome_outlined,
        AppStyle.neumorph => Icons.layers_outlined,
        AppStyle.glass => Icons.water_drop_outlined,
      };
}