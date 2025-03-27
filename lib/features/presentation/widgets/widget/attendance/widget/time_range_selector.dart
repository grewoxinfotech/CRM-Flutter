import 'package:flutter/material.dart';
import "package:get/get.dart";
class TimeRangeSelector extends StatelessWidget {
  const TimeRangeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ["Week", "Month", "Year"].map((period) {
        return GestureDetector(
          onTap: () {},
          child: Text(period,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Get.theme.colorScheme.primary)),
        );
      }).toList(),
    );
  }
}
