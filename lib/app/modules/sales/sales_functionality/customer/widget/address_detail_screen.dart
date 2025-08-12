import 'package:flutter/material.dart';

import '../../../../../data/network/sales/customer/model/customer_model.dart';

class AddressDetailScreen extends StatelessWidget {
  final Address address;

  const AddressDetailScreen({Key? key, required this.address})
    : super(key: key);

  Widget _buildDetailTile(String label, String? value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(value ?? 'N/A', style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildDetailTile("Street", address.street, Icons.location_on),
          _buildDetailTile("City", address.city, Icons.location_city),
          _buildDetailTile("State", address.state, Icons.map),
          _buildDetailTile("Country", address.country, Icons.flag),
          _buildDetailTile(
            "Postal Code",
            address.postalCode,
            Icons.markunread_mailbox,
          ),
        ],
      ),
    );
  }
}
