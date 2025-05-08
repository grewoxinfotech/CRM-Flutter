import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';

class CrmIndicator extends StatelessWidget {
  final Color color;
  final String text;

  const CrmIndicator({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: color, radius: 10),
        AppSpacing.horizontalSmall,
        Text(text, style: TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
