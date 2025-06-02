import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactCard extends StatelessWidget {
  final ContactModel? contact;

  const ContactCard({Key? key,this.contact})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CrmCard(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.small,
          vertical: AppPadding.small,
        ),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                "N/A".substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"N/A" "N/A"',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "N/A",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            CircleAvatar(
              backgroundColor: Colors.transparent,
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
