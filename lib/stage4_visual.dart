import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'lesson_card.dart';
import 'theme/styled_scaffold.dart';

/// ============================================================
/// ETAPA 4 · ADVANCED VISUAL
///
/// Las ilusiones ópticas y efectos visuales (el nivel Geometry Dash).
/// Cada lección es un ejemplo vivo.
/// ============================================================

class Stage4Screen extends StatelessWidget {
  const Stage4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      appBar: AppBar(
        title: const Text('Etapa 4 · Advanced Visual'),
        backgroundColor: const Color(0xFFC62828),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: const [
          LessonCard(
            technicalName: 'AnimatedContainer (animación implícita)',
            purpose:
                'Animación SIN esfuerzo: cambiás una propiedad (tamaño, color, radio) y Flutter interpola el cambio solo, con transición suave.',
            how: 'Usá AnimatedContainer en vez de Container y definí duration + curve. Cuando cualquier propiedad cambia, arranca la animación. Tocá y mirá cómo crece, cambia de color y se redondea.',
            snippet:
                "AnimatedContainer(\n  duration: Duration(milliseconds: 400),\n  curve: Curves.easeInOut,\n  width: _big ? 130 : 70,\n  decoration: BoxDecoration(\n    color: _big ? red : teal,\n    borderRadius: BorderRadius.circular(_big ? 20 : 38),\n  ),\n)",
            demo: AnimatedContainerDemo(),
          ),
          LessonCard(
            technicalName: 'BackdropFilter (glassmorphism)',
            purpose:
                'El vidrio esmerilado: desenfoca lo que hay DETRÁS del contenedor. Da profundidad y un look moderno de móviles.',
            how: 'Envolvé un Container semitransparente con BackdropFilter + ImageFilter.blur. Lo de atrás se ve borroso a través del vidrio.',
            snippet:
                "BackdropFilter(\n  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),\n  child: Container(\n    color: Colors.white.withValues(alpha: 0.3),\n    child: Text('glass'),\n  ),\n)",
            demo: GlassDemo(),
          ),
          LessonCard(
            technicalName: 'Transform (3D con perspectiva)',
            purpose:
                'La ilusión óptica 3D estilo Geometry Dash: rotás un widget 2D con una matriz y una pizca de perspectiva para simular profundidad.',
            how: 'Transform + Matrix4. La línea setEntry(3, 2, 0.0015) aporta la "cámara" (profundidad). rotateY gira sobre el eje vertical. Mové el slider.',
            snippet:
                "Transform(\n  transform: Matrix4.identity()\n    ..setEntry(3, 2, 0.0015)\n    ..rotateY(_angulo),\n  child: Container(...),\n)",
            demo: Transform3DDemo(),
          ),
          LessonCard(
            technicalName: 'CustomPainter (dibujar a mano)',
            purpose:
                'El "<canvas> de Flutter": dibujás lo que quieras (formas, curvas, gráficos) con la API de pintura directo sobre la pantalla.',
            how: 'Creá una clase que extiende CustomPainter, implementá paint(Canvas, Size), y mostrala con CustomPaint. Acá dibujamos un personaje; vos podés dibujar lo que sea.',
            snippet:
                "class SmileyPainter extends CustomPainter {\n  void paint(Canvas c, Size s) {\n    c.drawCircle(center, radio, paint);\n    c.drawArc(rect, ini, barrido, false, paint);\n  }\n}\nCustomPaint(painter: SmileyPainter())",
            demo: PainterDemo(),
          ),
          LessonCard(
            technicalName: 'ShaderMask (texto con gradiente)',
            purpose:
                'Pintar texto (o cualquier widget) con un degradado en vez de color sólido. Tipografía con look premium.',
            how: 'ShaderMask aplica un shader (LinearGradient) sobre el hijo con BlendMode.srcIn. Cambiá los colores y el texto se repinta.',
            snippet:
                "ShaderMask(\n  shaderCallback: (b) =>\n    LinearGradient(colors: [...]).createShader(b),\n  blendMode: BlendMode.srcIn,\n  child: Text('GRADIENTE'),\n)",
            demo: GradientTextDemo(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 1 · AnimatedContainer
// ============================================================
class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({super.key});

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _big = !_big),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: _big ? 130 : 70,
        height: _big ? 130 : 70,
        decoration: BoxDecoration(
          color: _big ? const Color(0xFFFF6B6B) : const Color(0xFF4ECDC4),
          borderRadius: BorderRadius.circular(_big ? 20 : 38),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.touch_app, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}

// ============================================================
// LECCIÓN 2 · BackdropFilter
// ============================================================
class GlassDemo extends StatelessWidget {
  const GlassDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 130,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFB83280), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 14,
            top: 16,
            child: CircleAvatar(radius: 14, backgroundColor: Colors.white54),
          ),
          const Positioned(
            right: 16,
            bottom: 12,
            child: CircleAvatar(radius: 20, backgroundColor: Colors.yellowAccent),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  width: 140,
                  height: 62,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'glass',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 3 · Transform 3D
// ============================================================
class Transform3DDemo extends StatefulWidget {
  const Transform3DDemo({super.key});

  @override
  State<Transform3DDemo> createState() => _Transform3DDemoState();
}

class _Transform3DDemoState extends State<Transform3DDemo> {
  double _angle = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015) // perspectiva
            ..rotateY(_angle),
          child: Container(
            width: 90,
            height: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '3D',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 200,
          child: Slider(
            value: _angle,
            min: -1.2,
            max: 1.2,
            onChanged: (value) => setState(() => _angle = value),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 4 · CustomPainter
// ============================================================
class PainterDemo extends StatelessWidget {
  const PainterDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(painter: _SmileyPainter()),
    );
  }
}

class _SmileyPainter extends CustomPainter {
  const _SmileyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.34;

    final facePaint = Paint()..color = const Color(0xFFFFD54F);
    final strokePaint = Paint()
      ..color = const Color(0xFF5D4037)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, radius, facePaint);
    canvas.drawCircle(center, radius, strokePaint);

    final eyePaint = Paint()..color = const Color(0xFF5D4037);
    canvas.drawCircle(Offset(size.width * 0.40, size.height * 0.42), 5, eyePaint);
    canvas.drawCircle(Offset(size.width * 0.60, size.height * 0.42), 5, eyePaint);

    final smileRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height * 0.58),
      radius: size.width * 0.16,
    );
    canvas.drawArc(smileRect, 0.15 * pi, 0.7 * pi, false, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================
// LECCIÓN 5 · ShaderMask
// ============================================================
class GradientTextDemo extends StatelessWidget {
  const GradientTextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFFF6B6B), Color(0xFFFFD93D), Color(0xFF6BCB77)],
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: const Text(
        'GRADIENTE',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
    );
  }
}