
import 'package:crm_flutter/app/features/presentation/screens/auth/widgets/auth_elevated_button.dart';
import 'package:crm_flutter/app/features/presentation/screens/auth/widgets/auth_text_form_field.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/features/lead_add_controller.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadAddModelView {
  final Widget? widget;
  LeadAddModelView({required this.widget});
  static List<LeadAddModelView> getWidgets() {
  LeadAddController controller = Get.put(LeadAddController());
    return [
      LeadAddModelView(widget: CrmHeadline(title: "Leads Information")),
      LeadAddModelView(widget: AuthTextFormField(title: "persone",controller: controller.persone,)),
      LeadAddModelView(widget: AuthTextFormField(title: "phone",controller: controller.phone,)),
      LeadAddModelView(widget: AuthTextFormField(title: "lead_value",controller: controller.lead_value,)),
      LeadAddModelView(widget: AuthTextFormField(title: "stage",controller: controller.stage,)),
      LeadAddModelView(widget: AuthTextFormField(title: "created_data",controller: controller.created_data,)),
      LeadAddModelView(widget: AuthTextFormField(title: "description",controller: controller.description,)),
      LeadAddModelView(widget: AuthTextFormField(title: "email",controller: controller.email,)),
      LeadAddModelView(widget: AuthTextFormField(title: "company",controller: controller.company,)),
      LeadAddModelView(widget: AuthTextFormField(title: "source",controller: controller.source,)),
      LeadAddModelView(widget: AuthTextFormField(title: "interest_level",controller: controller.interest_level,)),
      LeadAddModelView(widget: AuthElevatedButton(title: "Add Lead", onPressed: ()=>controller.addlead())),
    ];
  }
}
