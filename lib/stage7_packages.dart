import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'lesson_card.dart';

/// ============================================================
/// ETAPA 7 · PAQUETES (el "npm" de Flutter)
///
/// Cómo funcionan las dependencias detrás de escena y
/// CUÁNDO conviene sumar un paquete (decisión de líder).
/// Cada lección es un ejemplo vivo.
/// ============================================================

class Stage7Screen extends StatelessWidget {
  const Stage7Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 7 · Paquetes'),
        backgroundColor: const Color(0xFF6A1B9A),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: const [
          LessonCard(
            technicalName: 'intl (formato de fechas y números)',
            purpose:
                'Un paquete real de uso cotidiano: formatea fechas, números y moneda según el idioma/país. Sin él, formatear a mano es frágil.',
            how: 'Agregás intl al pubspec, hacés flutter pub get, importás package:intl/intl.dart, y usás DateFormat / NumberFormat. Son funciones estáticas, listas para usar. Este demo muestra la fecha y un precio actuales.',
            snippet:
                "import 'package:intl/intl.dart';\n\nfinal hoy = DateFormat('dd/MM/yyyy').format(DateTime.now());\nfinal precio = NumberFormat.currency(\n  locale: 'es_AR', symbol: r'\$').format(1999.99);",
            demo: IntlDemo(),
          ),
          LessonCard(
            technicalName: 'Versionado de paquetes (^ y rangos)',
            purpose:
                'Entender qué versiones aceptás cuando ponés ^2.3.2 en pubspec. Es la decisión de riesgo que tomás como líder CADA vez que sumás algo.',
            how: 'El caret (^) significa "compatible": acepta desde la versión que pusiste hasta antes del próximo cambio MAYOR (el primer número). El 2.x.y se actualiza a 2.9 pero no a 3.0. Tocá las opciones para ver qué permite cada sintaxis.',
            snippet:
                "^2.3.2   → >=2.3.2 y <3.0.0 (compatible)\n2.3.2    → exactamente esa (fija)\n>=1.0.0 <2.0.0 → rango manual",
            demo: VersioningDemo(),
          ),
          LessonCard(
            technicalName: 'Checklist de líder: ¿sumo este paquete?',
            purpose:
                'Sumar una dependencia es adquirir una DEUDA a futuro (actualizaciones, bugs, compatibilidad). Esta checklist es la decisión técnica que vos vas a tomar cuando dirijas.',
            how: 'Tocá cada criterio y sumá puntos. Si el paquete resuelve algo real, está mantenido y es popular, ganaste. Si no, mejor escribirlo a mano. Es la misma lógica que un arquitecto usa ANTES de instalar cualquier librería.',
            snippet:
                "// Regla de líder\n// 5+ puntos  → sumalo con confianza\n// 3-4 puntos → investigá más\n// 0-2 puntos → escribilo vos",
            demo: PackageChecklistDemo(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 1 · intl
// ============================================================
class IntlDemo extends StatelessWidget {
  const IntlDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final hoy = DateFormat('EEEE, dd/MM/yyyy').format(DateTime.now());
    final precio = NumberFormat.currency(locale: 'es_AR', symbol: r'$')
        .format(1999.99);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 260,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A3A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Text(
                'Fecha formateada:',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Text(
                hoy,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(height: 8),
              const Text(
                'Moneda (es_AR):',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Text(
                precio,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Muestra los datos REALES de hoy',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 2 · Versionado
// ============================================================
class VersioningDemo extends StatefulWidget {
  const VersioningDemo({super.key});

  @override
  State<VersioningDemo> createState() => _VersioningDemoState();
}

class _VersioningDemoState extends State<VersioningDemo> {
  final _opts = [
    ('^2.3.2', '>=2.3.2 y <3.0.0 (caret: compatible)'),
    ('2.3.2', 'Exactamente 2.3.2 (fija, sin actualizar)'),
    ('>=1.0.0 <2.0.0', 'Rango manual de 1.x'),
  ];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _opts[_selected].$2,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(_opts.length, (i) {
            return ChoiceChip(
              label: Text(_opts[i].$1),
              selected: _selected == i,
              selectedColor: const Color(0xFF6A1B9A),
              onSelected: (_) => setState(() => _selected = i),
            );
          }),
        ),
        const SizedBox(height: 6),
        const Text(
          'El ^ es la opción normal: seguridad + actualizaciones',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 3 · Checklist de líder
// ============================================================
class PackageChecklistDemo extends StatefulWidget {
  const PackageChecklistDemo({super.key});

  @override
  State<PackageChecklistDemo> createState() => _PackageChecklistDemoState();
}

class _PackageChecklistDemoState extends State<PackageChecklistDemo> {
  static const _items = [
    ('Resuelve un problema real (+2)', 2),
    ('Mantenido: actualizaciones recientes (+2)', 2),
    ('Popular: +1000 likes en pub.dev (+1)', 1),
    ('API chica y estable (+1)', 1),
    ('No duplica algo nativo de Flutter (+1)', 1),
  ];

  final _checked = List<bool>.filled(_items.length, false);

  int get _score {
    var total = 0;
    for (var i = 0; i < _items.length; i++) {
      if (_checked[i]) total += _items[i].$2;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final verdict = _score >= 5
        ? 'Sumalo con confianza'
        : _score >= 3
            ? 'Investigá más antes de decidir'
            : 'Mejor escribílo vos';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(_items.length, (i) {
          return CheckboxListTile(
            value: _checked[i],
            onChanged: (v) => setState(() => _checked[i] = v ?? false),
            title: Text(
              _items[i].$1,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            activeColor: const Color(0xFF6A1B9A),
          );
        }),
        const SizedBox(height: 8),
        Text(
          'Puntaje: $_score → $verdict',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Tocá los criterios y mirá el veredicto',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}