import 'package:crm/features/presentation/widgets/widget_custem/crm_container.dart';
import 'package:flutter/material.dart';

Widget buildDateContainer(Size size, String? fd, String? ld) {
  return CrmContainer(
    width: size.width,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    borderRadius: BorderRadius.circular(14),
    child: Text(
      "${fd} - ${ld}",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}
