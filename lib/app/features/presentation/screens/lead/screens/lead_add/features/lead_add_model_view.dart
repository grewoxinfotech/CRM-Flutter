
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
    List<LeadAddModelView> widgets = [];

  LeadAddController controller = Get.put(LeadAddController());
    widgets.add(LeadAddModelView(widget: CrmHeadline(title: "Leads Information")));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "persone",controller: controller.persone,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "phone",controller: controller.phone,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "lead_value",controller: controller.lead_value,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "stage",controller: controller.stage,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "created_data",controller: controller.created_data,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "description",controller: controller.description,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "email",controller: controller.email,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "company",controller: controller.company,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "source",controller: controller.source,)));
    widgets.add(LeadAddModelView(widget: AuthTextFormField(title: "interest_level",controller: controller.interest_level,)));
    widgets.add(LeadAddModelView(widget: AuthElevatedButton(title: "Add Lead", onPressed: ()=>controller.addlead())));

    return widgets;
  }
}
