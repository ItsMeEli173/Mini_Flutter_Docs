import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_routes.dart';
import 'settings/settings_screen.dart';
import 'stage1_fundamentals.dart';
import 'stage2_layout.dart';
import 'stage3_state.dart';
import 'stage4_visual.dart';
import 'stage5_persistence.dart';
import 'stage6_data.dart';
import 'stage7_packages.dart';
import 'theme/app_style.dart';
import 'theme/app_theme.dart';
import 'theme/custom_widgets.dart';
import 'theme/scroll_behavior.dart';
import 'theme/style_scope.dart';

/// ============================================================
/// FLUTTER DOCS — Aplicación de documentación resumida.
///
/// Objetivo: aprender Flutter CON Flutter. Cada etapa de
/// aprendizaje trae sus propias lecciones, y cada lección es
/// su propio ejemplo vivo (misma técnica que el Visual Playground).
///
/// Estructura:
///   main.dart                 -> la app + el "escritorio" de etapas
///   settings/settings_screen  -> selector de estilos de la app
///   theme/                    -> estilos, temas y widgets de tema
///   stage1_fundamentals.dart  -> Etapa 1: Fundamentos
/// ============================================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedStyle = prefs.getString('app_style');
  final initialStyle = AppStyle.values.firstWhere(
    (style) => style.name == savedStyle,
    orElse: () => AppStyle.light,
  );
  runApp(FlutterDocs(initialStyle: initialStyle));
}

class FlutterDocs extends StatefulWidget {
  const FlutterDocs({super.key, this.initialStyle = AppStyle.light});

  /// Style to start with; the persisted value when launched via main().
  final AppStyle initialStyle;

  @override
  State<FlutterDocs> createState() => _FlutterDocsState();
}

class _FlutterDocsState extends State<FlutterDocs> {
  late AppStyle _style;

  @override
  void initState() {
    super.initState();
    _style = widget.initialStyle;
  }

  /// Applies the selected style immediately and persists it for next launch.
  void _onStyleChanged(AppStyle style) {
    setState(() => _style = style);
    SharedPreferences.getInstance().then(
      (prefs) => prefs.setString('app_style', style.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StyleScope(
      style: _style,
      child: MaterialApp(
        title: 'Flutter Docs',
        // No darkTheme on purpose: "dark" is just another ThemeData, so the
        // selected style always renders exactly as chosen (themeMode light).
        theme: buildTheme(_style),
        scrollBehavior: const AppScrollBehavior(),
        builder: (context, child) => _StyleBackground(
          style: _style,
          child: child!,
        ),
        home: HomeScreen(
          currentStyle: _style,
          onStyleChanged: _onStyleChanged,
        ),
      ),
    );
  }
}

/// Paints the colorful gradient behind the app for styles that need one.
/// Plain styles simply return the child untouched.
class _StyleBackground extends StatelessWidget {
  const _StyleBackground({required this.style, required this.child});

  final AppStyle style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gradient = buildBackgroundGradient(style);
    if (gradient == null || gradient.isEmpty) {
      return child;
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      child: child,
    );
  }
}

/// ============================================================
/// PANTALLA PRINCIPAL (el "escritorio" de etapas)
/// ============================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.currentStyle,
    required this.onStyleChanged,
  });

  /// The active style, forwarded to the settings screen.
  final AppStyle currentStyle;

  /// Callback used to change the app style from the settings screen.
  final ValueChanged<AppStyle> onStyleChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Docs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configuración',
            onPressed: () => pushScreen(
              context,
              screen: SettingsScreen(
                currentStyle: currentStyle,
                onStyleChanged: onStyleChanged,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Aprendé Flutter con Flutter, en etapas.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          _StageCard(
            number: '1',
            title: 'Fundamentos',
            description:
                'Widgets, Stateless vs Stateful, y el árbol de widgets. La base de TODO.',
            icon: Icons.extension,
            color: Color(0xFF6750A4),
            locked: false,
            screen: Stage1Screen(),
          ),
          _StageCard(
            number: '2',
            title: 'Layout & Styles',
            description: 'Cómo acomodar y estilizar los widgets: Row, Column, Container, SizedBox.',
            icon: Icons.dashboard_customize_outlined,
            color: Color(0xFF2E7D32),
            locked: false,
            screen: Stage2Screen(),
          ),
          _StageCard(
            number: '3',
            title: 'State & Interaction',
            description: 'setState, campos de texto y navegación entre pantallas.',
            icon: Icons.touch_app_outlined,
            color: Color(0xFFEF6C00),
            locked: false,
            screen: Stage3Screen(),
          ),
          _StageCard(
            number: '4',
            title: 'Advanced Visual',
            description: 'Animación, glassmorphism y el 3D simulado.',
            icon: Icons.auto_awesome_outlined,
            color: Color(0xFFC62828),
            locked: false,
            screen: Stage4Screen(),
          ),
          _StageCard(
            number: '5',
            title: 'Persistence',
            description: 'Guardar datos en el dispositivo: shared_preferences y carga async.',
            icon: Icons.save_outlined,
            color: Color(0xFF1565C0),
            locked: false,
            screen: Stage5Screen(),
          ),
          _StageCard(
            number: '6',
            title: 'Data & APIs',
            description: 'JSON, HTTP real y modelos tipados: traer datos de internet.',
            icon: Icons.cloud_outlined,
            color: Color(0xFF00838F),
            locked: false,
            screen: Stage6Screen(),
          ),
          _StageCard(
            number: '7',
            title: 'Packages',
            description: 'El "npm" de Flutter: pub.dev, versionado y la checklist de líder.',
            icon: Icons.inventory_2_outlined,
            color: Color(0xFF6A1B9A),
            locked: false,
            screen: Stage7Screen(),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// TARJETA DE ETAPA (igual que el DemoCard, pero para etapas)
/// ============================================================
class _StageCard extends StatelessWidget {
  const _StageCard({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.locked,
    required this.screen,
  });

  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool locked;
  final Widget? screen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StyleCard(
      margin: const EdgeInsets.only(bottom: 12),
      onTap: locked
          ? null
          : () => pushScreen(context, screen: screen!),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(locked ? Icons.lock_outline : icon, color: color),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Etapa $number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(title, style: theme.textTheme.titleMedium),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(description, style: theme.textTheme.bodySmall),
        ),
        trailing: Icon(
          locked ? Icons.lock_outline : Icons.chevron_right,
          color: locked ? theme.disabledColor : theme.colorScheme.primary,
        ),
        enabled: !locked,
      ),
    );
  }
}