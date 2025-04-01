import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview_buttons.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview_widget_basic_details.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview_id_information_2.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview_information.dart';
import 'package:flutter/cupertino.dart';

class LeadOverviewModelWidget {
  final Widget? widget;

  LeadOverviewModelWidget({required this.widget});
// api call this location
  static List<LeadOverviewModelWidget> getWidgets() {
    return [
      LeadOverviewModelWidget(widget: LeadOverviewWidgetBasicDetails()),
      LeadOverviewModelWidget(widget: LeadOverviewInformation()),
      LeadOverviewModelWidget(widget: LeadOverviewIdInformation2()),
      LeadOverviewModelWidget(widget: LeadOverviewButtons()),
    ];
  }
}
