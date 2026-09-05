import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'lesson_card.dart';
import 'theme/styled_scaffold.dart';

/// ============================================================
/// ETAPA 6 · DATOS EXTERNOS (API & JSON)
///
/// Traer datos de internet y convertirlos en algo usable.
/// Cada lección es un ejemplo vivo.
/// ============================================================

class Stage6Screen extends StatelessWidget {
  const Stage6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return StyledScaffold(
      appBar: AppBar(
        title: const Text('Etapa 6 · Datos externos'),
        backgroundColor: const Color(0xFF00838F),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: const [
          LessonCard(
            technicalName: 'JSON & dart:convert',
            purpose:
                'El formato universal de intercambio de datos: texto estructurado con claves y valores. Las APIs devuelven JSON y vos lo convertís a Dart.',
            how: 'jsonDecode(jsonString) convierte el texto en Map/List de Dart; jsonEncode hace lo inverso. Accedés con mapa["clave"]. Este demo parsea un JSON hardcodeado para que veas el resultado.',
            snippet:
                "import 'dart:convert';\n\nfinal mapa = jsonDecode('{\"nombre\": \"Eli\"}');\nprint(mapa['nombre']); // Eli\n\nfinal texto = jsonEncode({'ok': true});",
            demo: JsonDemo(),
          ),
          LessonCard(
            technicalName: 'HTTP GET (red con el paquete http)',
            purpose:
                'Pedir datos reales a una URL de internet. Es el "fetch" de Flutter. Acá usamos una API pública de prueba (jsonplaceholder) como servidor.',
            how: 'http.get(Uri.parse(url)) devuelve una respuesta. Si statusCode == 200, el body es el JSON. Siempre manejá el error (sin conexión / servidor caído). Tocá el botón: pide un dato real a internet.',
            snippet:
                "final res = await http.get(\n  Uri.parse('https://...'),\n);\nif (res.statusCode == 200) {\n  final data = jsonDecode(res.body);\n}",
            demo: HttpFetchDemo(),
          ),
          LessonCard(
            technicalName: 'Model class (fromJson / toJson)',
            purpose:
                'No trabajés con Map<String, dynamic> sueltos: convertí el JSON en un OBJETO tipado (modelo) con campos conocidos. Es la base de apps serias.',
            how: 'Definís una clase con sus campos y un constructor fromJson(Map). Después trabajás con objeto.title en vez de mapa["title"]. Este demo parsea un JSON hardcodeado y lo dibuja como objeto real.',
            snippet:
                "class Todo {\n  final int id;\n  final String title;\n  final bool done;\n\n  Todo.fromJson(Map<String, dynamic> json)\n      : id = json['id'],\n        title = json['title'],\n        done = json['completed'];\n}",
            demo: ModelDemo(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LECCIÓN 1 · JSON
// ============================================================
class JsonDemo extends StatelessWidget {
  const JsonDemo({super.key});

  // Un "servidor" simulado para no depender de internet en esta lección.
  static const _json = '{"nombre": "Elias", "edad": 25, "stack": "Flutter"}';

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(_json) as Map<String, dynamic>;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _json,
          style: const TextStyle(
            color: Color(0xFF9CDCFE),
            fontFamily: 'monospace',
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'JSON → ${data['nombre']} · ${data['edad']} años · ${data['stack']}',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 2 · HTTP real
// ============================================================
class HttpFetchDemo extends StatefulWidget {
  const HttpFetchDemo({super.key});

  @override
  State<HttpFetchDemo> createState() => _HttpFetchDemoState();
}

class _HttpFetchDemoState extends State<HttpFetchDemo> {
  static const _url = 'https://jsonplaceholder.typicode.com/todos/1';

  bool _loading = false;
  String? _error;
  String? _body;

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
      _body = null;
    });
    try {
      final res = await http.get(Uri.parse(_url));
      if (!mounted) return;
      if (res.statusCode == 200) {
        setState(() {
          _body = res.body;
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'HTTP ${res.statusCode}';
          _loading = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Sin conexión';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: _loading ? null : _fetch,
          icon: const Icon(Icons.cloud_download_outlined),
          label: const Text('Pedir a internet'),
        ),
        const SizedBox(height: 10),
        if (_loading)
          const CircularProgressIndicator(color: Colors.white)
        else if (_error != null)
          Text(
            'Error: $_error',
            style: const TextStyle(color: Colors.redAccent, fontSize: 13),
          )
        else if (_body != null)
          Text(
            _body!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF9CDCFE),
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          )
        else
          const Text(
            'Esperando pedido...',
            style: TextStyle(color: Colors.white38, fontSize: 12),
          ),
      ],
    );
  }
}

// ============================================================
// LECCIÓN 3 · Model class
// ============================================================
class ModelDemo extends StatelessWidget {
  const ModelDemo({super.key});

  static const _json = '{"id": 1, "title": "Aprender Flutter", "completed": false}';

  @override
  Widget build(BuildContext context) {
    final todo = TodoModel.fromJson(jsonDecode(_json) as Map<String, dynamic>);
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
              Row(
                children: [
                  const Text('Título: ',
                      style: TextStyle(color: Colors.white54, fontSize: 13)),
                  Text(todo.title!,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text('Completada: ',
                      style: TextStyle(color: Colors.white54, fontSize: 13)),
                  Text('${todo.done}',
                      style: const TextStyle(color: Colors.white, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Objeto real: todo.title, todo.done',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

/// Modelo tipado (el "objeto" que reemplaza al Map suelto).
class TodoModel {
  final int? id;
  final String? title;
  final bool? done;

  TodoModel({this.id, this.title, this.done});

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        done = json['completed'] as bool?;
}