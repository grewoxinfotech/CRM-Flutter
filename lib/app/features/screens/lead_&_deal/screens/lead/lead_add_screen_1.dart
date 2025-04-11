import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/data/lead/lead_controller.dart';
import 'package:crm_flutter/app/features/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_headline.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/widgets/crm_loading_circle.dart';
import 'package:crm_flutter/app/features/widgets/crm_text_field.dart';
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
    ];
    return Scaffold(
      floatingActionButton: Obx(
        () =>
            (leadController.isLoading.value != false)
                ? CrmLoadingCircle()
                : CrmButton(
                  width: Get.width - 30,
                  title: "Add Lead (1/2)",
                  onTap: () => leadController.addLead(),
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        leading: Container(
          alignment: Alignment.center,
          child: CrmIcon(iconPath: ICRes.left, color: Colors.white, width: 30,onTap: ()=>Get.back(),),
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
