import 'dart:ffi';

import 'package:crm_flutter/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsDuratio extends StatelessWidget {
  final Double? time;
  final GestureTapCallback? onTap;

  const EventsDuratio({super.key, this.time,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmContainer(
        width: 65,
        height: 35,
        padding: EdgeInsets.all(10),
        color: Get.theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Icon(Icons.watch_later),
            const SizedBox(width: 10),
            Text(time.toString() + "h"),
          ],
        ),
      ),
    );
  }
}
