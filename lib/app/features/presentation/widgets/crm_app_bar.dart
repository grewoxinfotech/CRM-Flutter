import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_logo.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmAppBar extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final String? hintText;
  final Widget? action;

  const CrmAppBar({
    super.key,
    this.leading,
    this.title,
    this.hintText,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      width: 600,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.bottomCenter,
      boxShadow: [
        BoxShadow(color: Get.theme.colorScheme.shadow.withAlpha(100), blurRadius: 20),
      ],
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          alignment: Alignment.center,
          child: CrmAppLogo(),
        ),
        actions: [
          CrmIcon(iconPath: ICRes.search),
          const SizedBox(width: 15),
          CrmIcon(iconPath: ICRes.notifications),
          const SizedBox(width: 15),
          CrmProfile(radius: 15, child: Text("G")),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
