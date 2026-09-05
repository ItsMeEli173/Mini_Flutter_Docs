import 'package:flutter/material.dart';

import 'lesson_card.dart';

/// ============================================================
/// ETAPA 1 · FUNDAMENTOS
///
/// La base de TODO en Flutter. Cada lección es un ejemplo vivo:
/// arriba ves cómo se ve, abajo aprendés el nombre técnico,
/// para qué sirve, cómo se usa y el código.
/// ============================================================

class Stage1Screen extends StatelessWidget {
  const Stage1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 1 · Fundamentos'),
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: const [
          LessonCard(
            technicalName: 'Widget',
            purpose:
                'TODO en Flutter es un widget. Un texto, un botón, toda una pantalla, hasta la app entera. Cada widget decide CÓMO se ve y CÓMO se comporta una parte de la interfaz.',
            how: 'Pensá un widget como un ladrillo LEGO con un solo puerto: recibe un child (hijo) y arma UI. Los widgets se componen anidándose: uno adentro de otro, hasta formar la pantalla completa.',
            snippet:
                "// Un Text es un widget.\n// Un Container que lo envuelve es otro widget.\n// Todo lo que ves aquí es un widget.\nText('Hola Flutter')",
            demo: WidgetDemo(),
          ),
          LessonCard(
            technicalName: 'StatelessWidget vs StatefulWidget',
            purpose:
                'Stateless = NO cambia con el tiempo (estático, como una etiqueta). Stateful = CAMBIA con el tiempo (como un contador). Esta es la decisión que elegís para CADA pantalla.',
            how: 'Si tu pantalla tiene datos que cambian y redibujan (setState), es StatefulWidget. Si es fija o recibe valores de afuera, StatelessWidget. Tocá el contador: eso es hidden del Stateful.',
            snippet:
                "class MiPantalla extends StatelessWidget  // NO cambia\nclass MiPantalla extends StatefulWidget   // cambia\n\n// El estado mutable con su setState()",
            demo: StatelessVsStatefulDemo(),
          ),
          LessonCard(
            technicalName: 'Widget Tree (árbol de widgets)',
            purpose:
                'La app es un ÁRBOL de widgets anidados. La raíz es la app entera; cada hijo cuelga de su padre. Esta estructura es el MAPA de cómo Flutter arma tu UI.',
            how: 'Fijate cómo este ejemplo es literalmente un árbol visible: un Container raíz contiene un Column que contiene dos Text. Flutter renderiza el árbol de arriba hacia abajo.',
            snippet:
                "Container(              // raíz\n  child: Column(          // 1er nivel\n    children: [\n      Text('Hola'),       // 2do nivel\n      Text('Mundo'),      // 2do nivel\n    ],\n  ),\n)",
            demo: WidgetTreeDemo(),
          ),
        ],
      ),
    );
  }
}

class WidgetDemo extends StatelessWidget {
  const WidgetDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Este "demo" ES el concepto: texto, caja, padding...
    // son todos widgets anidados entre sí.
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF6750A4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.widgets, color: Colors.white, size: 40),
          SizedBox(height: 8),
          Text(
            'Todo es un widget',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Container > Column > Icon + Textos',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 2 · Stateless vs Stateful (contador tocable)
// ============================================================
class StatelessVsStatefulDemo extends StatefulWidget {
  const StatelessVsStatefulDemo({super.key});

  @override
  State<StatelessVsStatefulDemo> createState() =>
      _StatelessVsStatefulDemoState();
}

class _StatelessVsStatefulDemoState extends State<StatelessVsStatefulDemo> {
  int _count = 0; // <-- el "estado" que cambia

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Toqué el botón $_count veces',
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(height: 10),
        // Este botón es un StatelessWidget (no cambia por sí solo),
        // pero al tocarlo llama setState del Stateful PADRE.
        ElevatedButton(
          onPressed: () => setState(() => _count++),
          child: const Text('Tocar (+1)'),
        ),
        const SizedBox(height: 6),
        const Text(
          'Vuelve a tocar: la pantalla se REDIBUJA sola',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 3 · Widget Tree (árbol visible)
// ============================================================
class WidgetTreeDemo extends StatelessWidget {
  const WidgetTreeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Cada nivel colorea de forma distinta para que VES el árbol:
    // raíz (morado) > rama (azul) > hojas (verde).
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF6750A4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF3F51B5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'hoja',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'hoja',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}