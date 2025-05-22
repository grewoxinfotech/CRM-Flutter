import 'package:flutter/material.dart';

enum CrmTextButtonType { primary, secondary }

class CrmTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final CrmTextButtonType type;

  const CrmTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.type = CrmTextButtonType.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: type == CrmTextButtonType.primary 
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(text),
    );
  }
} 