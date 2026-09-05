import 'package:flutter/material.dart';

/// ============================================================
/// FLUTTER DOCS — Aplicación de documentación resumida.
///
/// Objetivo: aprender Flutter CON Flutter. Cada etapa de
/// aprendizaje trae sus propias lecciones, y cada lección es
/// su propio ejemplo vivo (misma técnica que el Visual Playground).
///
/// Estructura:
///   main.dart            -> la app + el "escritorio" de etapas
///   stage1_fundamentals.dart -> Etapa 1: Fundamentos
/// ============================================================

import 'stage1_fundamentals.dart';
import 'stage2_layout.dart';
import 'stage3_state.dart';
import 'stage4_visual.dart';
import 'stage5_persistence.dart';
import 'stage6_data.dart';
import 'stage7_packages.dart';

void main() {
  runApp(const FlutterDocs());
}

class FlutterDocs extends StatelessWidget {
  const FlutterDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Docs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

/// ============================================================
/// PANTALLA PRINCIPAL (el "escritorio" de etapas)
/// ============================================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Docs')),
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
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
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
        onTap: locked
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => screen!),
                ),
      ),
    );
  }
}