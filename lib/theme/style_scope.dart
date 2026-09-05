import 'package:flutter/material.dart';

import 'app_style.dart';

/// Exposes the active [AppStyle] to the whole widget subtree.
///
/// Lives above the [MaterialApp] so every screen (including pushed routes
/// such as the settings screen) can read the current style and react to
/// style changes in real time via inherited-widget dependencies.
class StyleScope extends InheritedWidget {
  const StyleScope({super.key, required this.style, required super.child});

  /// The style currently applied to the app.
  final AppStyle style;

  /// Returns the active [AppStyle] for [context].
  ///
  /// Registers a dependency, so widgets that call it rebuild automatically
  /// when the style changes. Throws a [FlutterError] when no [StyleScope]
  /// is present above the widget, which usually means the widget was used
  /// outside of `FlutterDocs`.
  static AppStyle of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<StyleScope>();
    if (scope == null) {
      throw FlutterError(
        'StyleScope.of() called with no StyleScope in the widget tree. '
        'Wrap your MaterialApp with a StyleScope (see FlutterDocs.build).',
      );
    }
    return scope.style;
  }

  @override
  bool updateShouldNotify(StyleScope oldWidget) => oldWidget.style != style;
}