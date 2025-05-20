import 'dart:math';
import 'package:flutter/material.dart';

class OrbitingWidget extends StatefulWidget {
  final Widget child;
  final double radius;
  final Duration duration;

  const OrbitingWidget({
    required this.child,
    this.radius = 100,
    this.duration = const Duration(seconds: 4),
    super.key,
  });

  @override
  State<OrbitingWidget> createState() => _OrbitingWidgetState();
}

class _OrbitingWidgetState extends State<OrbitingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(); // keep rotating
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        double angle = _controller.value * 2 * pi;
        double x = widget.radius * cos(angle);
        double y = widget.radius * sin(angle);
        return Transform.translate(
          offset: Offset(x, y),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
