import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'style_scope.dart';

/// ============================================================
/// SCAFFOLD CON FONDO DEL ESTILO ACTIVO
///
/// POR QUÉ EXISTE:
///   Los estilos maximal y glass pintan su fondo (gradiente) DETRÁS
///   del Navigator (MaterialApp.builder). Pero las rutas son
///   transparentes (opaque: false): si cada pantalla usa un Scaffold
///   común, su fondo transparente deja ver la pantalla ANTERIOR a
///   través de la nueva. Eso se nota muchísimo en maximalismo.
///
///   Este widget envuelve el Scaffold en el fondo del estilo activo:
///   gradiente opaco en glass/maximal, color sólido en los demás.
///   Cada ruta cubre a la anterior y la navegación se ve limpia.
///
///   Acepta los mismos parámetros que Scaffold (appBar, body, etc.)
///   y el Scaffold interno es siempre transparente para que el fondo
///   de este widget brille.
/// ============================================================
class StyledScaffold extends StatelessWidget {
  const StyledScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  /// Same AppBar API as [Scaffold].
  final PreferredSizeWidget? appBar;

  /// Same body API as [Scaffold].
  final Widget? body;

  /// Same floatingActionButton API as [Scaffold].
  final Widget? floatingActionButton;

  /// Same bottomNavigationBar API as [Scaffold].
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final style = StyleScope.of(context);
    final gradient = buildBackgroundGradient(style);
    return DecoratedBox(
      decoration: BoxDecoration(
        // For glass/maximal the gradient is the real background; for the
        // solid styles we paint the scaffold color from the theme.
        gradient: gradient == null
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
        color: gradient == null ? Theme.of(context).scaffoldBackgroundColor : null,
      ),
      child: Scaffold(
        // Transparent so the DecoratedBox background shows through.
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}