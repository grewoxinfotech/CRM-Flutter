import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/key_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';
import 'package:crm_flutter/app/modules/search/views/search_screen.dart';
import 'package:crm_flutter/app/modules/users/view/profile_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/database/storage/secure_storage_service.dart';

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
    Rxn<UserModel> _user = Rxn<UserModel>(null);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await SecureStorage.getUserData();
      _user.value = user;
    });
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
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    KeyRes.scaffoldKey.currentState!.openDrawer();
                  },
                  icon: Icon(Icons.dehaze_rounded, color: Colors.black),
                ),
              ),
          title: title,
          actions:
              action ??
              [
                GestureDetector(
                  onTap: () => Get.to(() => SearchModuleScreen()),
                  child: CrmIc(
                    iconPath: ICRes.search,
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
                AppSpacing.horizontalMedium,
                CrmIc(
                  iconPath: ICRes.notifications,
                  color: Get.theme.colorScheme.onPrimary,
                ),
                AppSpacing.horizontalMedium,
                GestureDetector(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  child: Obx(() {
                    if (_user.value?.profilePic != null &&
                        _user.value!.profilePic!.isNotEmpty) {
                      return CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(_user.value!.profilePic!),
                      );
                    }
                    return CrmAppLogo();
                  }),
                ),
              ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
