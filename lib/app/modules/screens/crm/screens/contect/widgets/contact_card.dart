import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback? onTap;

  const ContactCard({Key? key, required this.contact, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.contactOverView, arguments: contact),
      child: CrmCard(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.small,
          vertical: AppPadding.small,
        ),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                contact.firstName!.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppSpacing.horizontalSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${contact.firstName} ${contact.lastName}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: primary,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    contact.email.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.horizontalSmall,
            CircleAvatar(
              backgroundColor: transparent,
              child: const Icon(
                Icons.chevron_right,
                size: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
