import 'package:flutter/material.dart';

class CrmModel {
  String? title;
  Widget? widget;
  String? appRoutes;
  Color? color;
  IconData? iconData;

  CrmModel({
    required this.title,
    this.color,
    this.widget,
    this.appRoutes,
    this.iconData,
  });

  static List<CrmModel> getCrmWidgets() {
    return [
      CrmModel(title: "Leads", color: Color(0xff632100)),
      CrmModel(title: "Deals", color: Color(0xff234567)),
      CrmModel(title: "Task", color: Color(0xff098765)),
      CrmModel(title: "Contact", color: Color(0xFF1B5E20)),
      CrmModel(title: "Company", color: Color(0xFFB71C1C)),
      CrmModel(title: "Custom Form", color: Color(0xFF6A1B9A)),
      CrmModel(title: "Task Calender", color: Color(0xFF01579B)),
      CrmModel(title: "CRM System", color: Color(0xFF4E342E)),
    ];
  }
}
