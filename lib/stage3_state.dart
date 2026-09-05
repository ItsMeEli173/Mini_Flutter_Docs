import 'package:flutter/material.dart';

import 'lesson_card.dart';

/// ============================================================
/// ETAPA 3 · STATE & INTERACTION
///
/// Cómo cambia la UI cuando el usuario interactúa.
/// Cada lección es un ejemplo vivo.
/// ============================================================

class Stage3Screen extends StatelessWidget {
  const Stage3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 3 · State & Interaction'),
        backgroundColor: const Color(0xFFEF6C00),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: const [
          LessonCard(
            technicalName: 'setState',
            purpose:
                'El motor del cambio: avisás a Flutter que el estado cambió y ÉL redibuja la pantalla con los valores nuevos. Sin setState, la UI no se actualiza aunque cambies la variable.',
            how: 'Guardás el dato en una variable del State, y cuando querés que la pantalla refleje el cambio, lo hacés DENTRO de setState(() => ...). Tocá los botones: cada toque cambia el estado y se redibuja.',
            snippet:
                "int _count = 0;\n\nElevatedButton(\n  onPressed: () => setState(() {\n    _count++;      // cambia el dato Y avisa\n  }),\n  child: Text('\$_count'),\n)",
            demo: SetStateDemo(),
          ),
          LessonCard(
            technicalName: 'TextField + TextEditingController',
            purpose:
                'Capturar texto del usuario. El controller es el "puente" entre el campo visual y tu código: guarda lo que se escribe y lo podés leer cuando quieras.',
            how: 'Creás un TextEditingController, lo conectás al TextField, y leés controller.text cuando tocás un botón. El resultado se guarda con setState y se muestra. Escribí en el campo.',
            snippet:
                "final _controller = TextEditingController();\n\nTextField(controller: _controller),\n\n// Al tocar:\nsetState(() => _mensaje = _controller.text);",
            demo: TextFieldDemo(),
          ),
          LessonCard(
            technicalName: 'Navigator.push / pop (mover pantallas)',
            purpose:
                'La navegación: abrir OTRA pantalla (push) y volver a la anterior (pop). Es la "pila" de pantallas: como páginas apiladas; la última está arriba.',
            how: 'Navigator.push(context, MaterialPageRoute(...)) abre una pantalla nueva ENCIMA. Navigator.pop(context) la cierra y vuelve. Entrá a la pantalla interna y volvé.',
            snippet:
                "Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (_) => OtraScreen(),\n  ),\n);\n\nNavigator.pop(context); // volver",
            demo: NavigationDemo(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 1 · setState (contador)
// ============================================================
class SetStateDemo extends StatefulWidget {
  const SetStateDemo({super.key});

  @override
  State<SetStateDemo> createState() => _SetStateDemoState();
}

class _SetStateDemoState extends State<SetStateDemo> {
  int _count = 500; // el dato que cambia

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$_count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filled(
              onPressed: () => setState(() => _count--),
              icon: const Icon(Icons.remove),
              color: const Color(0xFFEF6C00),
            ),
            const SizedBox(width: 12),
            IconButton.filled(
              onPressed: () => setState(() => _count++),
              icon: const Icon(Icons.add),
              color: const Color(0xFFEF6C00),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Cada toque → setState → se redibuja',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 2 · TextField + controller
// ============================================================
class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  final _controller = TextEditingController();
  String _texto = 'Escribí un mensaje';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 250,
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Tu mensaje...',
              hintStyle: TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Color(0xFF2A2A3A),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => setState(() => _texto = _controller.text),
          child: const Text('Mostrar'),
        ),
        const SizedBox(height: 6),
        Text(
          _texto,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 3 · Navegación
// ============================================================
class NavigationDemo extends StatelessWidget {
  const NavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const _InnerScreen(),
        ),
      ),
      icon: const Icon(Icons.open_in_new),
      label: const Text('Abrir pantalla interna'),
    );
  }
}

class _InnerScreen extends StatelessWidget {
  const _InnerScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla interna')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Pilas de pantallas → esta está encima'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver (pop)'),
            ),
          ],
        ),
      ),
    );
  }
}