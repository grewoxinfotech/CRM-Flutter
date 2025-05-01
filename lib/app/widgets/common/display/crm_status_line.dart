import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class CrmStatusLine extends StatelessWidget {
  final Color color;
  final double height;

  const CrmStatusLine({super.key, required this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return CrmCard(width: 5, height: height, color: color);
  }
}
