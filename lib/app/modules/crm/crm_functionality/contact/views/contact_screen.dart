import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/button/crm_button.dart';

import '../../deal/views/deal_add_screen.dart';
import '../controller/contact_controller.dart';
import '../widget/contact_card.dart';
import 'contact_add_screen.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ContactController>(() => ContactController());
    final ContactController contactController = Get.put(ContactController());

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Contacts'),
      //   actions: [IconButton(
      //     icon: const Icon(Icons.refresh),
      //     onPressed: contactController.fetchContacts,
      //   )],
      // ),
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Contacts"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: CrmButton(
        title: "Add Contact",
        onTap: () => Get.to(ContactAddScreen()),
      ),
      body: Obx(() {
        if (contactController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (contactController.error.isNotEmpty) {
          return Center(child: Text(contactController.error.value));
        }
        if (contactController.contacts.isEmpty) {
          return const Center(child: Text('No contacts found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: contactController.contacts.length,
          itemBuilder: (context, index) {
            final contact = contactController.contacts[index];
            return ContactCard(contact: contact);
          },
        );
      }),
    );
  }
}
