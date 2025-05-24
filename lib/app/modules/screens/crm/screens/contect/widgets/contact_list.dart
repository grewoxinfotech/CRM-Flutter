import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/service/contact_service.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/views/contact_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/widgets/contact_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  const ContactList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ContactModel>>(
      future: ContactService.getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CrmLoadingCircle(),
          ); // or CrmLoadingCircle()
        } else if (snapshot.hasError) {
          return Center(
            child: SizedBox(
              width: 250,
              child: Text(
                'Server Error : \n${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final contact = snapshot.data!;
          if (contact.isEmpty) {
            return const Center(child: Text("No Leaves Found"));
          } else {
            return ViewScreen(
              padding: padding,
              itemCount:
                  (itemCount != null && itemCount! < contact.length)
                      ? itemCount!
                      : contact.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder:
                  (context, i) => ContactCard(
                    contact: contact[i],
                    onTap: () => Get.to(ContactScreen()),
                  ),
            );
          }
        } else {
          return const Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
