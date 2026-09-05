import 'package:flutter/material.dart';

import '../theme/app_style.dart';
import '../theme/custom_widgets.dart';
import '../theme/style_scope.dart';
import '../theme/styled_scaffold.dart';

/// Screen where the user picks the global [AppStyle].
///
/// Every tap applies the chosen style immediately (live preview) and the
/// selection persists for the next launch.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.currentStyle,
    required this.onStyleChanged,
  });

  /// The active style at the moment the screen was pushed. The live value
  /// read in build() keeps the checkmark in sync while this route is open.
  final AppStyle currentStyle;

  /// Callback invoked when the user selects a style.
  final ValueChanged<AppStyle> onStyleChanged;

  @override
  Widget build(BuildContext context) {
    // Read from the scope so the checkmark follows the current style even
    // after the style changes while this route stays on screen.
    final liveStyle = StyleScope.of(context);
    final theme = Theme.of(context);
    return StyledScaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Estilos de la aplicación', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'El estilo se aplica a toda la app y se guarda automáticamente en el dispositivo.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          for (final style in AppStyle.values)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: StyleCard(
                onTap: () => onStyleChanged(style),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: Icon(style.icon, color: theme.colorScheme.primary),
                  title: Text(style.label),
                  subtitle: Text(style.description),
                  trailing: liveStyle == style
                      ? Icon(Icons.check, color: theme.colorScheme.primary)
                      : null,
                ),
              ),
            ),
        ],
      ),
    );
  }
}