import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerCard extends StatelessWidget {
  final String? id;
  final String? relatedId;
  final String? customerNumber;
  final String? name;
  final String? contact;
  final String? phoneCode;
  final String? email;
  final String? taxNumber;
  final Map<String, dynamic>? billingAddress;
  final Map<String, dynamic>? shippingAddress;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final Color? color;
  final GestureTapCallback? onTab;

  const CustomerCard({
    super.key,
    this.id,
    this.relatedId,
    this.customerNumber,
    this.name,
    this.contact,
    this.phoneCode,
    this.email,
    this.taxNumber,
    this.billingAddress,
    this.shippingAddress,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.onTab,
  });

  String _formatAddress(Map<String, dynamic>? address) {
    if (address == null) return 'Not available';
    return "${address['street'] ?? ''}, ${address['city'] ?? ''}, ${address['state'] ?? ''}, ${address['country'] ?? ''} - ${address['postal_code'] ?? ''}";
  }

  @override
  Widget build(BuildContext context) {
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;
    return GestureDetector(
      onTap: onTab,
      child: CrmCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title and Customer Number
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Get.theme.colorScheme.primary.withAlpha(30),
                child: Text(
                  name![0].toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Get.theme.colorScheme.primary,
                  ),
                ),
              ),
              title: Text(
                name ?? 'No Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              subtitle: Text(
                "$phoneCode $customerNumber" ?? 'N/A',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
              trailing: Text(
                "" ?? '',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
