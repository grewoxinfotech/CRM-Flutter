import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberCard extends StatelessWidget {
  final String? url;
  final String? title;
  final String? subTitle;
  final String? role;
  final GestureTapCallback? onTap;

  const MemberCard({
    super.key,
    this.onTap,
    this.url,
    this.title,
    this.subTitle,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        margin: EdgeInsets.symmetric(horizontal: AppMargin.large),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Get.theme.colorScheme.background,
            child: Text(
              title![0],
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: textPrimary,
              ),
            ),
          ),
          title: Text(
            "$title",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
          subtitle: Text(
            "$subTitle",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textSecondary,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.small),
              border: Border.all(color: textPrimary),
            ),
            child: Text(
              role.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
