import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CrmAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final String? hintText;
  final List<Widget>? action;

  const CrmAppBar({
    super.key,
    this.leading,
    this.title,
    this.hintText,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.small),
        child: Obx(
          ()=> AppBar(
            toolbarHeight: kToolbarHeight,
            elevation: 4.0,
            scrolledUnderElevation: 5.0,
            automaticallyImplyLeading: false,
            backgroundColor: Get.theme.colorScheme.surface,
            foregroundColor: Get.theme.colorScheme.surface,
            shadowColor: Colors.black.withOpacity(0.4),
            surfaceTintColor: Colors.transparent,
            actionsPadding: const EdgeInsets.only(right: AppPadding.medium),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.large),
            ),
            leading:
                leading ??
                Align(alignment: Alignment.center, child: CrmAppLogo()),
            title: title,
            actions:
                action ??
                [
                  CrmIc(
                    icon: LucideIcons.search,
                    color: Get.theme.colorScheme.onPrimary,
                    size: 20,
                  ),
                  SizedBox(width: 10,),
                  Obx(
                    () => CrmIc(
                      icon: LucideIcons.bell,
                      size: 20,
                      color: Get.theme.colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Obx(
                    () => const CircleAvatar(
                      radius: 15,
                      child: Text(
                        "G",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
