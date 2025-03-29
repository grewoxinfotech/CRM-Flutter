import 'package:crm_flutter/features/presentation/screens/auth/widgets/auth_elevated_button.dart';
import 'package:crm_flutter/features/presentation/screens/auth/widgets/auth_text_form_field.dart';
import 'package:crm_flutter/features/presentation/screens/lead/lead_add/features/lead_add_controller.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadAddViewModel {
  final Widget? widget;

  LeadAddViewModel({required this.widget});

  static List<LeadAddViewModel> getWidgets() {
    List<LeadAddViewModel> widgets = [];

  LeadAddController controller = Get.put(LeadAddController());
    widgets.add(LeadAddViewModel(widget: CrmHeadline(title: "Leads Information")));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "persone",controller: controller.persone,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "phone",controller: controller.phone,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "lead_value",controller: controller.lead_value,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "stage",controller: controller.stage,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "created_data",controller: controller.created_data,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "description",controller: controller.description,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "email",controller: controller.email,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "company",controller: controller.company,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "source",controller: controller.source,)));
    widgets.add(LeadAddViewModel(widget: AuthTextFormField(title: "interest_level",controller: controller.interest_level,)));
    widgets.add(LeadAddViewModel(widget: AuthElevatedButton(title: "Add Lead", onPressed: ()=>controller.addlead())));

    return widgets;
  }
}
