// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../widgets/button/crm_back_button.dart';
// import '../../../../../widgets/button/crm_button.dart';
//
// import '../../deal/views/deal_add_screen.dart';
// import '../controller/contact_controller.dart';
// import '../widget/contact_card.dart';
// import 'contact_add_screen.dart';
//
// class ContactScreen extends StatelessWidget {
//   ContactScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<ContactController>(() => ContactController());
//     final ContactController contactController = Get.put(ContactController());
//
//     return Scaffold(
//
//       appBar: AppBar(
//         leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
//         title: const Text("Contacts"),
//         centerTitle: false,
//         backgroundColor: Colors.transparent,
//       ),
//       floatingActionButton: CrmButton(
//         title: "Add Contact",
//         onTap: () {
//           contactController.resetForm();
//           Get.to(ContactAddScreen());
//         },
//       ),
//       body: Obx(() {
//         if (contactController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (contactController.error.isNotEmpty) {
//           return Center(child: Text(contactController.error.value));
//         }
//         if (contactController.contacts.isEmpty) {
//           return const Center(child: Text('No contacts found'));
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           itemCount: contactController.contacts.length,
//           itemBuilder: (context, index) {
//             final contact = contactController.contacts[index];
//             return ContactCard(contact: contact);
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../../../../widgets/_screen/view_screen.dart';
import '../controller/contact_controller.dart';
import '../widget/contact_card.dart';
import 'contact_add_screen.dart';
import 'contact_detail_screen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.lazyPut<ContactController>(() => ContactController());
    final controller = Get.find<ContactController>();

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Contacts"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded, color: Colors.white),
        onPressed: () async {
          controller.resetForm();
          await Get.to(() => ContactAddScreen());
          controller.refreshList();
        },
      ),
      body: FutureBuilder(
        future: controller.loadInitial(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CrmLoadingCircle();
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
          } else {
            return Obx(() {
              if (controller.items.isEmpty) {
                return const Center(child: Text("No contacts available."));
              }

              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge && metrics.pixels != 0) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: controller.refreshList,
                  child: ViewScreen(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      final contact = controller.items[index];
                      return GestureDetector(
                        onTap: () async {
                          if (contact.id != null) {
                            await Get.to(
                              () => ContactDetailScreen(id: contact.id!),
                            );
                            controller.refreshList();
                          } else {
                            Get.snackbar("Error", "Contact ID is missing");
                          }
                        },
                        child: ContactCard(contact: contact),
                      );
                    },
                  ),
                ),
              );
            });
          }
        },
      ),
    );
  }
}
