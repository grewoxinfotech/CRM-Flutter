import 'package:crm_flutter/app/care/constants/color_res.dart';
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
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              contact.firstName!.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            '${contact.firstName} ${contact.lastName}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: primary,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            contact.email.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textSecondary,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, size: 20),
        ),
      ),
    );
  }
}
