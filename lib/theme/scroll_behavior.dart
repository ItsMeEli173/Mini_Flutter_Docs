import 'package:flutter/material.dart';

/// ============================================================
/// COMPORTAMIENTO DE SCROLL DE LA APP
///
/// POR QUÉ NO USAMOS EL OVERSROll DE ANDROID POR DEFECTO:
///   En Material 3, Android usa StretchingOverscrollIndicator: al
///   llegar a un borde, ESTIRA el contenido de la lista. El estiramiento
///   descoloca el BackdropFilter de las tarjetas glass y el blur
///   desaparece (se ven planas, sin translucidez). Bugs de Flutter:
///     - #156219 (BackdropFilter no funciona en top/bottom con stretch)
///     - #138940 (overscroll mal renderizado con backdrop blur)
///
/// SOLUCIÓN:
///   Físicas *bouncing* (como iOS): el borde "rebota" moviendo el
///   contenido completo en vez de estirarlo. El BackdropFilter nunca se
///   estira, el blur se mantiene siempre, y la sensación es consistente
///   y agradable en las dos plataformas.
/// ============================================================
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}