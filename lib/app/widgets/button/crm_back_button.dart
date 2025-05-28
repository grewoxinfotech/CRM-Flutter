import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CrmBackButton extends StatelessWidget {
  final double width;
  final Color? color;
  final VoidCallback? onTap;

  const CrmBackButton({super.key, this.width = 20, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CrmIc(
        icon: LucideIcons.chevronLeft,
        color: color ?? Theme.of(context).colorScheme.onPrimary,
        size: width,
        onTap: onTap ?? Get.back,
      ),
    );
  }
}
