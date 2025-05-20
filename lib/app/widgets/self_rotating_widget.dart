import 'package:flutter/material.dart';

class SelfRotatingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SelfRotatingWidget({
    required this.child,
    this.duration = const Duration(seconds: 2),
    super.key,
  });

  @override
  State<SelfRotatingWidget> createState() => _SelfRotatingWidgetState();
}

class _SelfRotatingWidgetState extends State<SelfRotatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(); // Infinite rotation
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
}
