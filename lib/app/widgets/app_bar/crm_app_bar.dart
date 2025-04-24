import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';

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
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
          shadowColor: Colors.black26,
          surfaceTintColor: Colors.transparent,
          actionsPadding: const EdgeInsets.only(right: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
          leading: Align(
            alignment: Alignment.center,
            child: CrmAppLogo(width: 45),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
          actions: [
            CrmIc(iconPath: ICRes.search, color: Colors.black),
            const SizedBox(width: 12),
            CrmIc(iconPath: ICRes.notifications, color: Colors.black),
            const SizedBox(width: 12),
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
