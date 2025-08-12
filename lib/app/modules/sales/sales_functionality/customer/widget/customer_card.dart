import 'package:flutter/material.dart';
import '../../../../../data/network/sales/customer/model/customer_model.dart';

class CustomerCard extends StatelessWidget {
  final CustomerData customer;

  const CustomerCard({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Customer Avatar or Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[600], size: 32),
              ),
            ),
            const SizedBox(width: 12),

            // Customer Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    customer.name ?? 'Unnamed Customer',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Email
                  if (customer.email != null && customer.email!.isNotEmpty)
                    Text(
                      customer.email!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 4),

                  // Phone
                  if (customer.contact != null && customer.contact!.isNotEmpty)
                    Text(
                      customer.contact!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                  // Optional Address
                  if (customer.shippingAddress != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Address: ${customer.shippingAddress}',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
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
