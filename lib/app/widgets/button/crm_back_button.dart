import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmBackButton extends StatelessWidget {
  final double width;
  final Color? color;
  final VoidCallback? onTap;

  const CrmBackButton({super.key, this.width = 30, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CrmIc(
        iconPath: Ic.left,
        color: color ?? Theme.of(context).colorScheme.onPrimary,
        width: width,
        onTap: onTap ?? Get.back,
      ),
    );
  }
}
