import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberCard extends StatelessWidget {
  final String? url;
  final String? title;
  final String? subTitle;
  final String? role;
  final String? email;
  final String? phone;
  final GestureTapCallback? onTap;

  const MemberCard({
    super.key,
    this.onTap,
    this.url,
    this.title,
    this.subTitle,
    this.role,
    this.email,
    this.phone,
  });

  String getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Get.theme.colorScheme.primary;
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;

    // Determine what to show as subtitle
    String displaySubtitle = '';
    if (subTitle != null && subTitle!.isNotEmpty) {
      displaySubtitle = subTitle!;
    } else if (email != null && email!.isNotEmpty) {
      displaySubtitle = email!;
    } else if (phone != null && phone!.isNotEmpty) {
      displaySubtitle = phone!;
    } else {
      displaySubtitle = 'No contact information';
    }

    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: primary.withAlpha(30),
            child: Text(
              getInitials(title),
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: primary,
              ),
            ),
          ),
          title: Text(
            title ?? 'Unnamed Member',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textPrimary,
            ),
          ),
          subtitle: Text(
            displaySubtitle,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textSecondary),
          ),
          trailing: (role == null || role!.isEmpty) 
              ? null 
              : Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.small,
              vertical: AppPadding.small / 2,
            ),
            decoration: BoxDecoration(
              color: primary.withAlpha(30),
              borderRadius: BorderRadius.circular(AppRadius.small),
            ),
            child: Text(
                    role!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
