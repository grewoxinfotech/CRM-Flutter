import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:flutter/material.dart';

class JobModel {
  String? title;
  Widget? widget;
  Color? color;
  IconData? iconData;

  JobModel({required this.title, this.color, this.widget, this.iconData});

  static List<JobModel> getCrmWidgets() {
    return [
      JobModel(color: Color(0xff632100), title: "Jobs", widget: LeadScreen()),
      JobModel(color: Color(0xff632100), title: "Candidates", widget: LeadScreen()),
      JobModel(color: Color(0xff632100), title: "On Boarding", widget: LeadScreen()),
      JobModel(color: Color(0xff632100), title: "Applications", widget: LeadScreen()),
      JobModel(color: Color(0xff632100), title: "Letters", widget: LeadScreen()),
      JobModel(color: Color(0xff632100), title: "Interviews", widget: LeadScreen()),
    ];
  }
}
