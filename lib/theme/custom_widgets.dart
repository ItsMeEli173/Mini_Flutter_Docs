import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

import 'app_style.dart';
import 'app_theme.dart';
import 'style_scope.dart';

/// Renders [child] inside a shell that matches the active [AppStyle].
///
/// Replaces the generic [Card] across the whole app so every card follows
/// the selected style without duplicating theme logic on each screen.
/// The lesson demos keep their own dark "embedded IDE" container and are
/// never restyled by this widget.
class StyleCard extends StatelessWidget {
  const StyleCard({
    super.key,
    required this.child,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.borderRadius,
  });

  /// The content shown inside the card.
  final Widget child;

  /// Optional tap action. When set, the card becomes tappable.
  final VoidCallback? onTap;

  /// Outer margin around the card.
  final EdgeInsetsGeometry margin;

  /// Overrides the style-specific corner radius when provided.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    switch (StyleScope.of(context)) {
      case AppStyle.light:
      case AppStyle.dark:
        return _materialCard();
      case AppStyle.minimal:
        return _minimalCard(context);
      case AppStyle.maximal:
        return _maximalCard(context);
      case AppStyle.neumorph:
        return _neumorphCard();
      case AppStyle.glass:
        return _glassCard();
    }
  }

  /// Light and dark keep the classic Material card: a subtle elevation and
  /// clipped corners. An [InkWell] inside the [Card] keeps the ripple on
  /// the card surface.
  Widget _materialCard() {
    final Widget content = onTap == null ? child : InkWell(onTap: onTap, child: child);
    return Card(
      elevation: 2,
      margin: margin,
      clipBehavior: Clip.antiAlias,
      child: content,
    );
  }

  /// Minimal: flat surface with a small radius and a hairline border.
  /// No shadows, no elevation, nothing floating.
  Widget _minimalCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final content = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant, width: 1),
      ),
      child: child,
    );
    return _wrapTap(content);
  }

  /// Maximal: a saturated gradient surface, a large radius and a colored
  /// glow shadow derived from the accent color.
  Widget _maximalCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final content = Container(
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primaryContainer, scheme.tertiaryContainer],
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
    return _wrapTap(content);
  }

  /// Neumorph: the classic soft-raised relief made of two BoxShadows:
  /// a light one from the top-left ("lit" corner) and a dark one from the
  /// bottom-right ("recessed" corner), on the shared neumorphic surface.
  Widget _neumorphCard() {
    final content = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: neumorphSurfaceColor,
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: Color(0xFFA3B1C6),
            offset: Offset(6, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: child,
    );
    return _wrapTap(content);
  }

  /// Glass: the content is clipped to rounded corners, blurred with a
  /// BackdropFilter and placed over a translucent white panel with a soft
  /// white border. The colorful background makes the frosting visible.
  Widget _glassCard() {
    final radius = borderRadius ?? BorderRadius.circular(16);
    final content = ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: radius,
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: child,
        ),
      ),
    );
    return _wrapTap(content);
  }

  /// Cards without a callback stay inert; with one they become tappable.
  Widget _wrapTap(Widget content) {
    if (onTap == null) return content;
    return GestureDetector(onTap: onTap, child: content);
  }
}