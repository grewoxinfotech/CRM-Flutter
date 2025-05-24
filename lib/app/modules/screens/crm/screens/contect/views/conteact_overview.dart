import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/contact/model/contact_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactOverviewScreen extends StatelessWidget {

  const ContactOverviewScreen({super.key});

  Widget _buildInfoTile(String label, String? value, {IconData? icon}) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: Colors.indigo) : null,
      title: Text(label),
      subtitle: Text(value ?? 'N/A'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contact = Get.arguments as ContactModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Overview"),
        backgroundColor: Colors.indigo,
        leading: CrmBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppMargin.medium),
        child: CrmCard(
          padding: EdgeInsets.all(AppPadding.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.indigo,
                  child: Text(
                    contact.firstName!.substring(0, 1).toUpperCase(),
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  '${contact.firstName} ${contact.lastName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(height: 30, thickness: 1.2),
              _buildInfoTile("Email", contact.email, icon: Icons.email),
              _buildInfoTile(
                "Phone",
                "${contact.phoneCode} ${contact.phone}",
                icon: Icons.phone,
              ),
              _buildInfoTile(
                "Company",
                contact.companyName,
                icon: Icons.business,
              ),
              _buildInfoTile(
                "Source",
                contact.contactSource,
                icon: Icons.source,
              ),
              _buildInfoTile(
                "Address",
                contact.address,
                icon: Icons.location_on,
              ),
              _buildInfoTile("City", contact.city),
              _buildInfoTile("State", contact.state),
              _buildInfoTile("Country", contact.country),
              _buildInfoTile(
                "Description",
                contact.description,
                icon: Icons.description,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
