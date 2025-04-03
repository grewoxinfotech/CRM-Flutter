import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_overview/widgets/lead_overview_buttons.dart';
import 'package:flutter/cupertino.dart';

class LeadFileModelWidget {
  final Widget widget;

  const LeadFileModelWidget({required this.widget});
  static List<LeadFileModelWidget> getwidgets (){
    return [
      LeadFileModelWidget(widget: LeadOverviewButtons()),
    ];
  }
}
