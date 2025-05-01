import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmAppBar extends StatelessWidget implements PreferredSizeWidget {
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
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // 👈 Left & Right spacing
        child: AppBar(
          toolbarHeight: kToolbarHeight,
          elevation: 5.0,
          titleSpacing: 0,
          scrolledUnderElevation: 5.0,
          primary: true,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          actionsPadding: const EdgeInsets.only(right: AppPadding.medium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.large),
          ),
          leading: Align(
            alignment: Alignment.center,
            child: CrmAppLogo(width: 45),
          ),
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Get.theme.colorScheme.onPrimary,
          ),
          actions: [
            CrmIc(iconPath: ICRes.search, color: Get.theme.colorScheme.onPrimary),
            AppSpacing.horizontalMedium,
            CrmIc(iconPath: ICRes.notifications, color: Get.theme.colorScheme.onPrimary),
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
