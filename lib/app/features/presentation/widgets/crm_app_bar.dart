import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_logo.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_profile.dart';
import 'package:flutter/material.dart';

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
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: CrmContainer(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 20, spreadRadius: -10),
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CrmAppLogo(width: 40),
            Row(
              children: [
                CrmIcon(iconPath: ICRes.search),
                const SizedBox(width: 20),
                CrmIcon(iconPath: ICRes.notifications),
                const SizedBox(width: 18),
                CrmProfile(radius: 15 , child: Text("G")),
                const SizedBox(width: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
