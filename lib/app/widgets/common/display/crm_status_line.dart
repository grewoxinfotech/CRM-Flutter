import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmStatusLine extends StatelessWidget {
  final Color color;
  final double height;
  final double width;

  const CrmStatusLine({
    super.key,
    required this.color,
    required this.height,
    this.width = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CrmCard(
        width: width,
        height: height,
        color: color,
        borderRadius: BorderRadius.circular(width / 2), // rounded edges for style
        boxShadow: [], // remove shadow for a clean line
      ),
    );
  }
}
