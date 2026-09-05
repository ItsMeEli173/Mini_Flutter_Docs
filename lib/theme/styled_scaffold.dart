import 'package:flutter/material.dart';

/// ============================================================
/// SCAFFOLD CON FONDO DEL ESTILO ACTIVO
///
/// POR QUÉ EXISTE:
///   Los estilos maximal y glass pintan su fondo (gradiente). Cada
///   ruta debe cubrir a la anterior para que la navegación se vea
///   limpia. Pero el fondo NO puede pintarse aquí, dentro de la
///   pantalla: esta pantalla se desvanece dentro del `FadeTransition`
///   de `pushScreen`, y un gradiente semi-transparente en la MISMA
///   capa que el blur de las tarjetas glass hace que ese blur capture
///   un fondo equivocado y aparezca el parpadeo blanco.
///
///   Por eso el piso del estilo lo pinta la PROPIA RUTA (`pushScreen`
///   en app_routes.dart), en una capa separada que fadea por su lado.
///   Este widget solo aporta un Scaffold transparente (y la misma API
///   que Scaffold: appBar, body, etc.) para que ese piso brille.
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
    // Transparent on purpose: the style background is painted by the route
    // (pushScreen) on a separate layer so glass blur stays correct.
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}