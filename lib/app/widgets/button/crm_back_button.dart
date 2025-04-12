import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmBackButton extends StatelessWidget {
  final double? width;
  final Color? color;

  const CrmBackButton({super.key, this.width = 30, this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CrmIc(
        iconPath: ICRes.left,
        color: color ?? ColorRes.white,
        width: width,
        onTap: () => Get.back(),
      ),
    );
  }
}
