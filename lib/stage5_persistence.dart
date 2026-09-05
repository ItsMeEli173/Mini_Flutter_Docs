import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lesson_card.dart';

/// ============================================================
/// ETAPA 5 · PERSISTENCIA
///
/// Guardar datos para que sobrevivan al cierre de la app.
/// Primera etapa con un paquete REAL de pub.dev.
/// Cada lección es un ejemplo vivo.
/// ============================================================

class Stage5Screen extends StatelessWidget {
  const Stage5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Etapa 5 · Persistencia'),
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: const [
          LessonCard(
            technicalName: 'shared_preferences (tu primer paquete)',
            purpose:
                'Guardar datos SIMPLES (números, texto, booleanos) en el dispositivo. Sobreviven al cierre de la app. Es tu primer paquete real de pub.dev.',
            how: '1) Agregar la línea shared_preferences: ^2.3.2 a pubspec.yaml. 2) Correr flutter pub get. 3) En código: SharedPreferences.getInstance(), luego setInt/setString para guardar y getInt/getString para leer. Tocá el contador: queda guardado, y si reiniciás la app sigue ahí.',
            snippet:
                "// pubspec.yaml\nshared_preferences: ^2.3.2\n\n// código\nfinal prefs = await SharedPreferences.getInstance();\nawait prefs.setInt('count', _count);      // guardar\nfinal n = prefs.getInt('count') ?? 0;     // leer",
            demo: SharedPrefsDemo(),
          ),
          LessonCard(
            technicalName: 'FutureBuilder (cargar sin congelar la UI)',
            purpose:
                'Leer datos async (de disco, internet, etc.) tarda. Mientras tarda, mostrás un spinner. FutureBuilder arma esa transición de forma declarativa.',
            how: 'Le pasás el Future (la promesa de un dato futuro) y el builder recibe snapshot: connectionState dice si terminó; si tiene data o error, los mostrás. Tocá "Recargar" y mirá cómo aparece el spinner primero.',
            snippet:
                "FutureBuilder(\n  future: _miFuture,\n  builder: (context, snapshot) {\n    if (snapshot.connectionState != done)\n      return CircularProgressIndicator();\n    return Text(snapshot.data);\n  },\n)",
            demo: FutureBuilderDemo(),
          ),
          LessonCard(
            technicalName: 'Patrón guardar / leer (initState)',
            purpose:
                'La estructura completa de persistencia: cuando arranca la pantalla (initState) CARGÁS el valor guardado; cuando el usuario cambia algo, LO GUARDÁS.',
            how: 'initState se ejecuta una sola vez al crear la pantalla — es el momento de leer lo persistido. Después, cada cambio va por setState + set. Escribí algo, tocá "Guardar", reiniciá la app: el texto sigue.',
            snippet:
                "@override\nvoid initState() {\n  super.initState();\n  _cargar();  // lee lo guardado\n}\n\nFuture<void> _cargar() async {\n  final prefs = await SharedPreferences.getInstance();\n  setState(() => _texto = prefs.getString('msg') ?? '');\n}",
            demo: SaveLoadPatternDemo(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 1 · SharedPreferences (contador persistente)
// ============================================================
class SharedPrefsDemo extends StatefulWidget {
  const SharedPrefsDemo({super.key});

  @override
  State<SharedPrefsDemo> createState() => _SharedPrefsDemoState();
}

class _SharedPrefsDemoState extends State<SharedPrefsDemo> {
  int _count = 0;
  bool _loading = true;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _prefs = prefs;
      _count = prefs.getInt('demo_count') ?? 0;
      _loading = false;
    });
  }

  Future<void> _bump() async {
    setState(() => _count++);
    await _prefs?.setInt('demo_count', _count);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const CircularProgressIndicator(color: Colors.white);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Guardado en el dispositivo:',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        Text(
          '$_count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 44,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        IconButton.filled(
          onPressed: _bump,
          icon: const Icon(Icons.add),
          color: const Color(0xFF1565C0),
        ),
        const SizedBox(height: 6),
        const Text(
          'Reiniciá la app: el valor sigue acá',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 2 · FutureBuilder (carga asincrónica)
// ============================================================
class FutureBuilderDemo extends StatefulWidget {
  const FutureBuilderDemo({super.key});

  @override
  State<FutureBuilderDemo> createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  // Simula una lectura lenta (disco / red).
  Future<String> _fakeLoad() => Future.delayed(
        const Duration(seconds: 1),
        () => 'Dato cargado después de 1 segundo',
      );

  late Future<String> _future;

  @override
  void initState() {
    super.initState();
    _future = _fakeLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<String>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Cargando...',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Text(
                'Error al cargar',
                style: TextStyle(color: Colors.redAccent),
              );
            }
            return Text(
              '✓ ${snapshot.data}',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            );
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() {
            _future = _fakeLoad();
          }),
          child: const Text('Recargar (ver spinner)'),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 3 · Patrón guardar / leer
// ============================================================
class SaveLoadPatternDemo extends StatefulWidget {
  const SaveLoadPatternDemo({super.key});

  @override
  State<SaveLoadPatternDemo> createState() => _SaveLoadPatternDemoState();
}

class _SaveLoadPatternDemoState extends State<SaveLoadPatternDemo> {
  final _controller = TextEditingController();
  String _mensaje = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _mensaje = prefs.getString('demo_msg') ?? '');
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _mensaje = _controller.text);
    await prefs.setString('demo_msg', _mensaje);
  }

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
              hintText: 'Escribí algo y guardalo...',
              hintStyle: TextStyle(color: Colors.white38),
              filled: true,
              fillColor: Color(0xFF2A2A3A),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Guardar'),
        ),
        const SizedBox(height: 6),
        Text(
          _mensaje.isEmpty ? '(sin mensaje guardado)' : 'Mensaje: $_mensaje',
          style: TextStyle(
            color: _mensaje.isEmpty ? Colors.white38 : Colors.white,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}