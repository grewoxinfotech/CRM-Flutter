import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview/widgets/lead_overview_buttons.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview/widgets/lead_overview_id_information_2.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview/widgets/lead_overview_information.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview/widgets/lead_overview_widget_basic_details.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_custom_delete_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../../data/lead/lead_home/lead_controller.dart';


class LeadOverviewModelWidget {
  final Widget? widget;

  LeadOverviewModelWidget({required this.widget});
  // api call this location

  static List<LeadOverviewModelWidget> getWidgets(BuildContext context ,LeadModel lead) {
    final LeadController leadController = Get.find();

    return [
      LeadOverviewModelWidget(widget: LeadOverviewWidgetBasicDetails(lead: lead)),
      LeadOverviewModelWidget(widget: LeadOverviewInformation(lead: lead,)),
      LeadOverviewModelWidget(widget: LeadOverviewIdInformation2(lead: lead,)),
      LeadOverviewModelWidget(widget: LeadOverviewButtons(editButton: (){},deleteButton: () {
        String entityType = "lead";
        showCustomDeleteDialog(
          context: context,
          entityType: entityType,
          onConfirm: () {
            if (lead.id != null) {
              leadController.deleteLead(lead.id!);
            } else {
              Get.snackbar("Error", "Lead ID not found!");
            }
          },
          onCancel: () {
            print("$entityType deletion canceled!");
          },
        );
      },)),

      //For Backup
      // LeadOverviewModelWidget(widget: LeadOverviewWidgetBasicDetails()),
      // LeadOverviewModelWidget(widget: LeadOverviewInformation(lead: lead)),
      // LeadOverviewModelWidget(widget: LeadOverviewIdInformation2(lead: lead)),
      // LeadOverviewModelWidget(widget: LeadOverviewButtons(leadId: lead.id!)),

    ];
  }
}
