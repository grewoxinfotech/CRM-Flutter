import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/controllers/deal_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealAddScreen extends StatelessWidget {
  DealAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DealController dealController = Get.put(DealController());
    List textFields = [
      CrmHeadline(title: "Deal Details"),
      CrmTextField(title: "Deal Title", controller: dealController.dealTitle),
      CrmTextField(title: "Deal Value", controller: dealController.dealValue),
      CrmTextField(title: "Pipeline", controller: dealController.pipeline),
      CrmTextField(title: "Stage", controller: dealController.stage),
      CrmTextField(
        title: "Expected Close Date",
        controller: dealController.closeDate,
      ),
      CrmTextField(title: "Source", controller: dealController.source),
      CrmTextField(title: "Status", controller: dealController.status),
      CrmTextField(title: "Products", controller: dealController.products),

      SizedBox(),
      CrmHeadline(title: "Basic Information"),
      CrmTextField(title: "First Name", controller: dealController.firstName),
      CrmTextField(title: "Last Name", controller: dealController.lastName),
      CrmTextField(title: "Email", controller: dealController.email),
      CrmTextField(
        title: "Phone Number",
        controller: dealController.phoneNumber,
      ),
      CrmTextField(
        title: "Company Name",
        controller: dealController.companyName,
      ),
      CrmTextField(title: "Address", controller: dealController.address),
    ];
    return Scaffold(
      floatingActionButton: Obx(
        () =>
            (dealController.isLoading.value != false)
                ? const SizedBox()
                : CrmButton(
                  width: Get.width - 30,
                  title: "Add Deal",
                  onTap: () {},
                ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        leading: CrmBackButton(),
        title: Text("Create New Deal", style: TextStyle(color: AppColors.white)),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Obx(
        () =>
            (dealController.isLoading.value != false)
                ? CrmLoadingCircle()
                : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                  itemCount: textFields.length,
                  separatorBuilder: (context, i) => const SizedBox(height: 10),
                  itemBuilder: (context, i) => textFields[i],
                ),
      ),
    );
  }
}
