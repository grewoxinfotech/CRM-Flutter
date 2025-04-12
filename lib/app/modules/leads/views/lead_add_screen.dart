import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/modules/leads/controllers/lead_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadAddScreen1 extends StatelessWidget {
  LeadAddScreen1({super.key});

  LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    List textFields = [
      CrmHeadline(title: "Lead Details"),
      CrmTextField(title: "Lead Title", controller: leadController.leadTitle),
      CrmTextField(
        title: "Interest Level",
        controller: leadController.interestLevel,
      ),
      CrmTextField(title: "Lead Value", controller: leadController.leadValue),
      CrmTextField(title: "Pipeline", controller: leadController.pipeline),
      CrmTextField(title: "Stage", controller: leadController.stage),
      CrmTextField(title: "Source", controller: leadController.source),
      CrmTextField(title: "Status", controller: leadController.status),
      CrmTextField(title: "Category", controller: leadController.category),
      CrmTextField(title: "Team Members", controller: leadController.teamMembers),
      CrmHeadline(title: "Basic Information"),
      CrmTextField(title: "First Name", controller: leadController.firstName),
      CrmTextField(title: "Last Name", controller: leadController.lastName),
      CrmTextField(title: "Email", controller: leadController.email),
      CrmTextField(title: "Phone Number", controller: leadController.phoneNumber),
      CrmTextField(title: "Company Name", controller: leadController.companyName),
      CrmTextField(title: "Address", controller: leadController.address),
    ];
    return Scaffold(
      floatingActionButton: Obx(
            () =>
        (leadController.isLoading.value != false)
            ? CrmLoadingCircle()
            : CrmButton(
          width: Get.width - 30,
          title: "Add Lead",
          onTap: () => leadController.addLead(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        leading: Container(
          alignment: Alignment.center,
          child: CrmIc(iconPath: ICRes.left, color: Colors.white, width: 30,onTap: ()=>Get.back(),),
        ),
        title: Text("Create New Lead", style: TextStyle(color: Colors.white)),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: CrmCard(
        margin: const EdgeInsets.fromLTRB(20,20,20, 80),
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: textFields.length,
            separatorBuilder: (context, i) => SizedBox(height: 15),
            itemBuilder: (context, i) => textFields[i],
          ),
        ),
      ),
    );
  }
}
