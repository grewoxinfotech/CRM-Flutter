import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ContactOverviewScreen extends StatelessWidget {
  const ContactOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactModel contact = Get.arguments;

    final String id = contact.id.toString();
    final String contactOwner = contact.contactOwner.toString();
    final String firstName = contact.firstName.toString();
    final String lastName = contact.lastName.toString();
    final String companyName = contact.companyName.toString();
    final String email = contact.email.toString();
    final String phoneCode = contact.phoneCode.toString();
    final String phone = contact.phone.toString();
    final String contactSource = contact.contactSource.toString();
    final String description = contact.description.toString();
    final String address = contact.address.toString();
    final String city = contact.city.toString();
    final String state = contact.state.toString();
    final String country = contact.country.toString();
    final String relatedId = contact.relatedId.toString();
    final String clientId = contact.clientId.toString();

    return Scaffold(
      appBar: AppBar(title: Text("$firstName $lastName")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppMargin.medium),
        child: Column(
          children: [
            CrmCard(
              width: double.infinity,
              padding: EdgeInsets.all(AppPadding.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(
                      contact.firstName!.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 25,
                        color: white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  AppSpacing.verticalSmall,
                  Text(
                    "$firstName $lastName",
                    style: TextStyle(
                      fontSize: 16,
                      color: textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$email",
                        style: TextStyle(
                          fontSize: 12,
                          color: textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "+91 $phone",
                        style: TextStyle(
                          fontSize: 12,
                          color: textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Divider(),

                  _tile(
                    icon: CrmIc(icon: LucideIcons.locate,size: 14,),
                    title: "Location",
                    subTitle: "$city, $state, $country",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _tile extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? icon;

  const _tile({
    super.key,
    this.title = '',
    required this.subTitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Row(
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 4)],
            if (title != "") Text(
              "$title",
              style: TextStyle(
                fontSize: 12,
                color: textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Text(
          "$subTitle",
          style: TextStyle(
            fontSize: 12,
            color: textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
