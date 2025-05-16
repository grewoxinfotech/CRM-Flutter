import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:flutter/material.dart';

class HrmModel {
  String? title;
  Widget? widget;
  Color? color;
  IconData? iconData;

  HrmModel({required this.title, this.color, this.widget, this.iconData});

  static List<HrmModel> getCrmWidgets() {
    return [
      HrmModel(color: Color(0xff632100), title: "employee", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "PayRoll", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Role", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Branch", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Designation", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Department", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Attendance", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Holiday", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Leave", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Calender", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Meeting", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Announcement", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Document", widget: LeadScreen()),
      HrmModel(color: Color(0xff632100), title: "Training", widget: LeadScreen()),
    ];
  }
}
