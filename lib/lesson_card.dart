import 'package:flutter/material.dart';

/// ============================================================
/// LECCIÓN REUTILIZABLE (patrón DemoCard)
///
/// Cada lección de una etapa es una tarjeta que muestra:
///   - Un ejemplo VIVO e interactivo arriba (el demo)
///   - El nombre técnico, para qué sirve, cómo se usa
///   - Un snippet de código para copiar y estudiar
///
/// Se usa en TODAS las etapas para mantener el mismo look.
/// ============================================================
class LessonCard extends StatelessWidget {
  const LessonCard({
    super.key,
    required this.technicalName,
    required this.purpose,
    required this.how,
    required this.snippet,
    required this.demo,
  });

  final String technicalName;
  final String purpose;
  final String how;
  final String snippet;
  final Widget demo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 170,
            color: const Color(0xFF1E1E2E),
            child: Center(child: demo),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  technicalName,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                _LessonLabel('NOMBRE TÉCNICO', theme),
                Text(technicalName, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 8),
                _LessonLabel('PARA QUÉ SIRVE', theme),
                Text(purpose, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                _LessonLabel('CÓMO SE USA', theme),
                Text(how, style: theme.textTheme.bodySmall),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D0D14),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    snippet,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFF9CDCFE),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonLabel extends StatelessWidget {
  const _LessonLabel(this.text, this.theme);
  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: theme.textTheme.labelSmall
          ?.copyWith(color: theme.colorScheme.primary),
    );
  }
}