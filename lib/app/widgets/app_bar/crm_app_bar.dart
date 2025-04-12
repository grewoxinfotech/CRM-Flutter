import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size/border_res.dart';
import 'package:crm_flutter/app/care/constants/size/margin_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/profile/crm_profile_avatar.dart';
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
    return CrmCard(
      height: 50,
      margin: MarginRes.horizontal2,
      borderRadius: BorderRes.borderR2,
      child: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(alignment: Alignment.center, child: CrmAppLogo()),
        actions: [
          CrmIc(iconPath: ICRes.search),
          Space(size: 15),
          CrmIc(iconPath: ICRes.notifications),
          Space(size: 15),
          CrmProfileAvatar(
            radius: 15,
            child: Text(
              "G",
              style: TextStyle(
                fontSize: 20,
                color: Get.theme.colorScheme.surface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Space(size: 10),
        ],
      ),
    );
  }
}
