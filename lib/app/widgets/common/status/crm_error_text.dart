import 'package:flutter/material.dart';

class CrmErrorText extends StatelessWidget {
  final String? errorText;
  final double width;
  final TextStyle? style;

  const CrmErrorText({
    super.key,
    this.errorText,
    this.width = 250,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (errorText == null || errorText!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Center(
      child: SizedBox(
        width: width,
        child: Text(
          errorText!,
          style: style ??
              const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
