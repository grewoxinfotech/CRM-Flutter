import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: AppBar(
          toolbarHeight: kToolbarHeight,
          elevation: 5.0,
          scrolledUnderElevation: 5.0,
          automaticallyImplyLeading: false,
          backgroundColor: Get.theme.colorScheme.surface,
          foregroundColor: Get.theme.colorScheme.surface,
          shadowColor: Get.theme.colorScheme.surface,
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
                  iconPath: ICRes.search,
                  color: Get.theme.colorScheme.onPrimary,
                ),
                AppSpacing.horizontalMedium,
                CrmIc(
                  iconPath: ICRes.notifications,
                  color: Get.theme.colorScheme.onPrimary,
                ),
                AppSpacing.horizontalMedium,
                const CircleAvatar(
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
              ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
