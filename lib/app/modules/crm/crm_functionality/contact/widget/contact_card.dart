import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../../../data/network/crm/contact/medel/contact_medel.dart';
import '../controller/contact_controller.dart';
import '../views/contact_detail_screen.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contact;
  final Function(ContactModel)? onTap;

  const ContactCard({super.key, required this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        contact.createdAt != null
            ? DateFormat(
              'dd MMM yyyy',
            ).format(DateTime.parse(contact.createdAt!))
            : 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        //onTap: () => onTap?.call(contact) ?? ContactDetailScreen(),
        onTap: () {
          if (onTap != null) {
            onTap!(contact);
          } else {
            Get.to(() => ContactDetailScreen(id: contact.id));
          }
        },

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  (contact.firstName != null && contact.firstName!.isNotEmpty)
                      ? contact.firstName![0].toUpperCase()
                      : '?',

                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${contact.firstName} ${contact.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    if (contact.phone != null && contact.phone!.isNotEmpty)
                      _buildInfoRow('Phone', contact.phone!),
                    if (contact.email != null && contact.email!.isNotEmpty)
                      _buildInfoRow('Email', contact.email!),
                    if (contact.companyId != null &&
                        contact.companyId!.isNotEmpty)
                      _buildInfoRow(
                        'Company',
                        Get.find<ContactController>().getCompanyNameById(
                              contact.companyId,
                            ) ??
                            contact.companyId!,
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(formattedDate, style: const TextStyle(fontSize: 12)),
                  if (contact.contactSource != null &&
                      contact.contactSource!.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        contact.contactSource!,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value', style: const TextStyle(fontSize: 12)),
    );
  }

  void _showContactDetails(BuildContext context) {
    Get.defaultDialog(
      title: '${contact.firstName} ${contact.lastName}',
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (contact.phone != null)
              _buildDialogItem('Phone', contact.phone!),
            if (contact.email != null)
              _buildDialogItem('Email', contact.email!),
            if (contact.email != null)
              _buildDialogItem('Company', contact.companyId!),
            if (contact.address != null ||
                contact.city != null ||
                contact.country != null)
              _buildDialogItem(
                'Address',
                [
                  contact.address,
                  contact.city,
                  contact.country,
                ].where((part) => part != null && part.isNotEmpty).join(', '),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
