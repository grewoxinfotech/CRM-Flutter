import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeRangeSelector extends StatelessWidget {
  final Function(String) onSelected;
  TimeRangeSelector({super.key, required this.onSelected});

  final List<String> items = ["Week", "Month", "Year"];
  final RxString selectedItem = "Week".obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((item) {
        return GestureDetector(
          onTap: () {
            selectedItem.value = item;
            onSelected(item); // Notify parent about selection
          },
          child: Obx(() => _text(item, selectedItem.value == item)),
        );
      }).toList(),
    );
  }

  Widget _text(String text, bool isSelected) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
        color: isSelected ? Get.theme.colorScheme.primary : COLORRes.TEXT_PRIMARY,
      ),
    );
  }
}
