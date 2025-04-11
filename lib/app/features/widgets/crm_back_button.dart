import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmBackButton extends StatelessWidget {
  final double? width;
  final Color? color;

  const CrmBackButton({super.key, this.width = 30, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CrmIcon(
        iconPath: ICRes.left,
        color: color ?? Colors.white,
        width: width,
        onTap: ()=> Get.back(),
      ),
    );
  }
}
