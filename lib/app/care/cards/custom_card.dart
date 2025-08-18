import 'package:flutter/material.dart';

/// A customizable card that accepts any widget as its [child].
class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.margin,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor,
    this.elevation = 1.5,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.clipBehavior = Clip.antiAlias,
    this.border,
    this.shadowColor,
  });

  /// The content inside the card.
  final Widget child;

  /// Optional tap handler (adds ripple if provided).
  final VoidCallback? onTap;

  /// Outer spacing around the card.
  final EdgeInsetsGeometry? margin;

  /// Inner spacing inside the card.
  final EdgeInsetsGeometry padding;

  /// Background color of the card. Defaults to theme cardColor.
  final Color? backgroundColor;

  /// Material elevation.
  final double elevation;

  /// Card corner radius.
  final BorderRadius borderRadius;

  /// Clip behavior for the card’s content.
  final Clip clipBehavior;

  /// Optional border for the card.
  final BoxBorder? border;

  /// Optional shadow color.
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Theme.of(context).cardColor;

    final card = Material(
      color: bg,
      elevation: elevation,
      shadowColor: shadowColor,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius, border: border),
        padding: padding,
        child: child,
      ),
    );

    final clipped = ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: card,
    );

    if (onTap == null) {
      return Container(margin: margin, child: clipped);
    }

    return Container(
      margin: margin,
      child: InkWell(onTap: onTap, child: clipped),
    );
  }
}
