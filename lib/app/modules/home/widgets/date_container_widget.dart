import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateContainerWidget extends StatelessWidget {
  final String fd;
  final String ld;

  const DateContainerWidget({super.key, required this.fd, required this.ld});

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      width: 500,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CrmIc(iconPath: ICRes.calendar, color: Colors.black),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Get.theme.colorScheme.onSecondary,
              ),
              children: [
                TextSpan(text: fd),
                TextSpan(text: "\t\t\t-\t\t\t"),
                TextSpan(text: ld),
              ],
            ),
          ),
          CrmIc(iconPath: ICRes.calendar, color: Colors.white),
        ],
      ),
    );
  }
}
