import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:flutter/material.dart';

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
          CrmIcon(iconPath: ICRes.calendar, color: Colors.black),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: COLORRes.TEXT_PRIMARY,
              ),
              children: [
                TextSpan(text: fd),
                TextSpan(text: "\t\t\t-\t\t\t"),
                TextSpan(text: ld),
              ],
            ),
          ),
          CrmIcon(iconPath: ICRes.calendar, color: Colors.white),
        ],
      ),
    );
  }
}
