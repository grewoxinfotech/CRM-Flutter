import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/service/contact_service.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/widgets/contact_card.dart';
import 'package:crm_flutter/app/widgets/_screen/crm_future_list.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  const ContactList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return CrmFutureList<ContactModel>(
      padding: padding,
      itemCount: itemCount,
      emptyText: "No Contact Found",
      future: ContactService.getContacts(),
      itemBuilder: (context, contact) => ContactCard(contact: contact),
    );
  }
}
