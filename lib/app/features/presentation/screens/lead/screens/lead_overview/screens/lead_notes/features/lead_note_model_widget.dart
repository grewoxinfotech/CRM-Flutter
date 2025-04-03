import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_overview/widgets/lead_overview_buttons.dart';
import 'package:flutter/cupertino.dart';

class LeadNoteModelWidget {
  final Widget widget;

  const LeadNoteModelWidget({required this.widget});
  static List<LeadNoteModelWidget> getwidgets (){
    return [
      LeadNoteModelWidget(widget: LeadOverviewButtons()),
    ];
  }
}
