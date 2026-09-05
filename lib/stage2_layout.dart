import 'package:flutter/material.dart';

import 'lesson_card.dart';
import 'theme/styled_scaffold.dart';

/// ============================================================
/// ETAPA 2 · LAYOUT & STYLES
///
/// Cómo acomodar y estilizar los widgets en pantalla.
/// Cada lección es un ejemplo vivo.
/// ============================================================

class Stage2Screen extends StatelessWidget {
  const Stage2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      appBar: AppBar(
        title: const Text('Etapa 2 · Layout & Styles'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: const [
          LessonCard(
            technicalName: 'Row & Column (Flex)',
            purpose:
                'La forma de acomodar widgets: Row los pone en HORIZONTAL, Column en VERTICAL. Son la base del layout — el "display: flex" de Flutter.',
            how: 'Usá Column para apilar hacia abajo y Row para alinear hacia el costado. mainAxisAlignment controla el eje principal (el de la hilera); crossAxisAlignment el perpendicular. Tocá los botones para cambiar la alineación.',
            snippet:
                "Row(\n  mainAxisAlignment: MainAxisAlignment.spaceBetween,\n  children: [Text('A'), Text('B')],\n)\n\nColumn(\n  mainAxisAlignment: MainAxisAlignment.center,\n  children: [...],\n)",
            demo: RowColumnDemo(),
          ),
          LessonCard(
            technicalName: 'Container box model',
            purpose:
                'La caja que le da tamaño y estilo a su hijo: padding (adentro), margin (afuera), ancho/alto, fondo y bordes. Tu <div> con estilos en un solo widget.',
            how: 'Container tiene 3 frentes: padding separa al hijo del borde interno, margin lo aleja de sus vecinos, y decoration pinta fondo/bordes/sombra. El contador muestra cómo box-shadow y border-radius transforman una caja.',
            snippet:
                "Container(\n  width: 120, height: 120,\n  padding: EdgeInsets.all(12),\n  margin: EdgeInsets.all(8),\n  decoration: BoxDecoration(\n    color: Colors.teal,\n    borderRadius: BorderRadius.circular(16),\n    boxShadow: [BoxShadow(blurRadius: 10)],\n  ),\n  child: Text('box'),\n)",
            demo: ContainerDemo(),
          ),
          LessonCard(
            technicalName: 'SizedBox (espacio controlado)',
            purpose:
                'El widget más simple y usado: genera ESPACIO fijo. Sirve para separar elementos con un tamaño exacto, sin necesidad de un Container con margin.',
            how: 'SizedBox(height: X) mete un hueco vertical de X píxeles; SizedBox(width: X) uno horizontal. También sirve de caja de tamaño fijo. Acá separamos y dimensionamos bloques con SizedBox.',
            snippet:
                "Column(\n  children: [\n    Text('A'),\n    SizedBox(height: 24),  // hueco de 24px\n    Text('B'),\n    SizedBox(\n      width: 80, height: 80,\n      child: ...\n    ),\n  ],\n)",
            demo: SizedBoxDemo(),
          ),
          LessonCard(
            technicalName: 'Center & Spacer (alineación)',
            purpose:
                'Center centra un widget en el espacio que tiene; Spacer empuja elementos hacia los extremos repartiendo el hueco sobrante. Dos aliados del layout limpio.',
            how: 'Espacer ocupa todo el espacio libre que pueda y lo usa para separar hijos. Center llena el espacio del padre y centra a su hijo. Mirá cómo el Spacer reparte: tocá para alternar.',
            snippet:
                "Row(\n  children: [\n    Spacer(),          // empuja todo a la derecha\n    Text('final'),\n  ],\n)\n\nCenter(child: Text('centrado'))",
            demo: SpacerCenterDemo(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 1 · Row & Column
// ============================================================
class RowColumnDemo extends StatefulWidget {
  const RowColumnDemo({super.key});

  @override
  State<RowColumnDemo> createState() => _RowColumnDemoState();
}

class _RowColumnDemoState extends State<RowColumnDemo> {
  String _align = 'spaceBetween'; // cuál alineación está activa

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'mainAxisAlignment: $_align',
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(height: 10),
        // Cada filita usa una alineación distinta: 3 confetti.
        _alignRow(MainAxisAlignment.start, 'start'),
        const SizedBox(height: 6),
        _alignRow(MainAxisAlignment.center, 'center'),
        const SizedBox(height: 6),
        _alignRow(MainAxisAlignment.spaceBetween, 'spaceBetween'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: ['start', 'center', 'spaceBetween']
              .map((a) => ChoiceChip(
                    label: Text(a),
                    selected: _align == a,
                    selectedColor: const Color(0xFF2E7D32),
                    onSelected: (_) => setState(() => _align = a),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _alignRow(MainAxisAlignment align, String label) {
    return SizedBox(
      width: 270,
      child: Row(
        mainAxisAlignment: align,
        children: [
          _dot(),
          const SizedBox(width: 4),
          _dot(),
          const SizedBox(width: 4),
          _dot(),
        ],
      ),
    );
  }

  Widget _dot() => Container(
        width: 14,
        height: 14,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      );
}

// ============================================================
// LECCIÓN 2 · Container box model
// ============================================================
class ContainerDemo extends StatelessWidget {
  const ContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x662E7D32),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'padding',
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          Text(
            'box',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 3 · SizedBox
// ============================================================
class SizedBoxDemo extends StatelessWidget {
  const SizedBoxDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _block(const Color(0xFFFF6B6B), 24),
            const SizedBox(width: 12), // hueco horizontal
            _block(const Color(0xFF4ECDC4), 24),
            const SizedBox(width: 12),
            _block(const Color(0xFFFFD93D), 24),
          ],
        ),
        const SizedBox(height: 18), // hueco vertical
        const Text(
          'Separados por el hueco',
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }

  Widget _block(Color color, double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      );
}

// ============================================================
// LECCIÓN 4 · Center & Spacer
// ============================================================
class SpacerCenterDemo extends StatefulWidget {
  const SpacerCenterDemo({super.key});

  @override
  State<SpacerCenterDemo> createState() => _SpacerCenterDemoState();
}

class _SpacerCenterDemoState extends State<SpacerCenterDemo> {
  bool _spacer = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 270,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: const Color(0x223F51B5),
            child: _spacer
                ? const Row(
                    children: [
                      Text('A', style: TextStyle(color: Colors.white)),
                      Spacer(), // empuja el resto al final
                      Text('B', style: TextStyle(color: Colors.white)),
                    ],
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('A', style: TextStyle(color: Colors.white)),
                      Text('B', style: TextStyle(color: Colors.white)),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() => _spacer = !_spacer),
          child: Text(_spacer ? 'Con Spacer' : 'Centrado'),
        ),
      ],
    );
  }
}