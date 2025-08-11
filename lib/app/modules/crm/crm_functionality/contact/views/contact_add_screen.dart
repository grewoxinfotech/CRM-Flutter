import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../controller/contact_controller.dart';

class ContactAddScreen extends StatelessWidget {
  ContactAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ContactController>(() => ContactController());
    final ContactController contactController = Get.find();
    List textFields = [
      CrmTextField(
        title: "First Name",
        controller: contactController.firstName,
      ),
      CrmTextField(title: "Last Name", controller: contactController.lastName),
      CrmTextField(title: "Email", controller: contactController.email),
      CrmTextField(title: "Phone Number", controller: contactController.phone),
      CrmTextField(title: "Website", controller: contactController.website),
      CrmTextField(
        title: "Company Name",
        controller: contactController.companyName,
      ),
      CrmTextField(
        title: "Company Source",
        controller: contactController.contactSource,
      ),
      CrmTextField(title: "Address", controller: contactController.address),
      CrmTextField(
        title: "Description",
        controller: contactController.description,
      ),
      CrmTextField(
        title: "Contact Owner",
        controller: contactController.contactOwner,
      ),
    ];
    return Scaffold(
      floatingActionButton: Obx(
        () =>
            (contactController.isLoading.value != false)
                ? const SizedBox()
                : CrmButton(
                  width: Get.width - 30,
                  title: "Add Contact",
                  onTap: () {
                    contactController.createContact();
                  },
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: const CrmBackButton(),
        title: const Text("Create Contact"),
      ),

      body: Obx(
        () =>
            (contactController.isLoading.value != false)
                ? CrmLoadingCircle()
                : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
                  itemCount: textFields.length,
                  separatorBuilder: (context, i) => const SizedBox(height: 10),
                  itemBuilder: (context, i) => textFields[i],
                ),
      ),
    );
  }
}
