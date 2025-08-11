import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const CustomLoadingIndicator({
    Key? key,
    this.size = 40.0,
    this.color = Colors.blue,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
