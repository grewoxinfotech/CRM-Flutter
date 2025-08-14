import 'package:flutter/material.dart';
import '../../../../../data/network/purchase/vendor/model/vendor_model.dart';

class VendorCard extends StatelessWidget {
  final VendorData vendor;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const VendorCard({
    Key? key,
    required this.vendor,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  // Get first letter for avatar
  String getInitial() {
    if (vendor.name != null && vendor.name!.isNotEmpty) {
      return vendor.name!.substring(0, 1).toUpperCase();
    }
    return "?";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blueAccent,
              child: Text(
                getInitial(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Vendor Info
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min, // shrink to content
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Client ID Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          vendor.name ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (vendor.clientId != null &&
                          vendor.clientId!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            vendor.clientId!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Contact Info Vertical
                  if (vendor.contact != null)
                    Text("Contact: ${vendor.contact}"),
                  if (vendor.email != null)
                    Text("Email: ${vendor.email}"),
                  if (vendor.phonecode != null)
                    Text("Phone Code: ${vendor.phonecode}"),
                  if (vendor.taxNumber != null)
                    Text("Tax Number: ${vendor.taxNumber}"),
                  const SizedBox(height: 6),

                  // Address Vertical
                  if (vendor.address != null && vendor.address!.isNotEmpty)
                    Text(
                      "Address: ${vendor.address}, ${vendor.city ?? ''}, ${vendor.state ?? ''}, ${vendor.country ?? ''} - ${vendor.zipcode ?? ''}",
                      style: TextStyle(color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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