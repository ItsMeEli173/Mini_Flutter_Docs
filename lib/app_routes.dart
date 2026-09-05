import 'package:flutter/material.dart';

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
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(0, 0.015), end: Offset.zero)
                    .animate(curved),
            child: child,
          ),
        );
      },
    ),
  );
}