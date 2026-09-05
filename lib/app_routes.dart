import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'theme/style_scope.dart';

/// ============================================================
/// NAVEGACIÓN DE LA APP — rutas TRANSPARENTES
///
/// POR QUÉ NO USAMOS `MaterialPageRoute` PARA NAVEGAR:
///   MaterialPageRoute es una ruta OPAQUE (opaque: true). El framework
///   asume que el contenido cubre TODA la pantalla y, durante la
///   transición, pinta un fondo propio (blanco por defecto) que NO
///   responde a ningún theme color (ni canvasColor, ni scaffoldBackground).
///   Ese fondo es el "parpadeo blanco" que vimos al navegar en estilos
///   cuyo fondo real es un gradiente dibujado DETRÁS del Navigator
///   (glassmorphism / maximalismo).
///
/// SOLUCIÓN:
///   Una ruta con opaque: false. El Navigator SABE que debe preservar
///   lo que está debajo (el gradiente) y ninguna capa opaca entra en la
///   composición: la transición solo hace fade + un pequeño slide.
///   Es el mismo patrón que usa showDialog/showModalBottomSheet.
///
/// EL PISO DEL ESTILO (POR QUÉ ESTÁ ACÁ Y NO EN EL SCAFFOLD):
///   Cada ruta necesita su fondo para cubrir a la anterior. Pero ese
///   fondo NO puede pintarse dentro de la pantalla (StyledScaffold es
///   transparente a propósito): la pantalla fadea dentro de un
///   FadeTransition, y un gradiente semi-transparente en la MISMA capa
///   que el blur de las tarjetas glass hace que el BackdropFilter capture
///   un fondo equivocado → parpadeo blanco al navegar en glass.
///
///   Por eso [transitionsBuilder] arma un Stack con DOS capas que fadean
///   por SEPARADO:
///     1. El piso del estilo (gradiente o color sólido), siempre opaco.
///     2. El contenido (la pantalla + su slide), encima del piso.
///   Durante el push el piso se enciende primero que el contenido; en el
///   pop se apaga de forma que la pantalla anterior emerge al final.
///   SEMÁNTICA: el vidrio glass (BackdropFilter) nunca comparte el
///   saveLayer con un fondo a medio alpha → blur correcto y sin blanco.
/// ============================================================

/// Abre [screen] "encima" con una transición suave y fondo transparente.
Future<void> pushScreen(
  BuildContext context, {
  required Widget screen,
}) {
  return Navigator.of(context).push(
    PageRouteBuilder<void>(
      // La clave: opaque false. Si esto fuera true, el framework pinta
      // un fondo propio durante la transición y revivimos el parpadeo.
      opaque: false,
      // Sin barrera oscura: esta ruta no es un diálogo.
      barrierColor: null,
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        // Capa 1: el piso del estilo activo. Fadea en SU PROPIO
        // FadeTransition, separado del contenido, para que el blur de
        // las tarjetas glass nunca capture un fondo a medio alpha.
        final style = StyleScope.of(context);
        final gradient = buildBackgroundGradient(style);
        final Widget floor = DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient == null
                ? null
                : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradient,
                  ),
            color:
                gradient == null ? Theme.of(context).scaffoldBackgroundColor : null,
          ),
        );

        return Stack(
          fit: StackFit.expand,
          children: [
            // El piso fadea por su lado, opaco desde que empieza a
            // aparecer: cubre a la pantalla anterior desde el inicio y
            // le da al vidrio glass un fondo estable que capturar.
            FadeTransition(opacity: curved, child: floor),
            // Capa 2: el contenido (con su leve slide) fadea ENCIMA
            // del piso, nunca dentro de la misma capa de composición.
            FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(0, 0.015), end: Offset.zero)
                        .animate(curved),
                child: child,
              ),
            ),
          ],
        );
      },
    ),
  );
}