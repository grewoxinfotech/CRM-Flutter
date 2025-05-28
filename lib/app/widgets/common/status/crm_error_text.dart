import 'package:flutter/material.dart';

class CrmErrorText extends StatelessWidget {
  final String? errorText;

  const CrmErrorText({super.key, this.errorText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        child: Text(
          errorText.toString(),
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
