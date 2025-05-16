import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:flutter/material.dart';

class SalesModel {
  String? title;
  Widget? widget;
  Color? color;
  IconData? iconData;

  SalesModel({required this.title, this.color, this.widget, this.iconData});

  static List< SalesModel> getCrmWidgets() {
    return [
      SalesModel(color: Color(0xff632100), title: "Product And Services", widget: LeadScreen()),
      SalesModel(color: Color(0xff632100), title: "Customer", widget: LeadScreen()),
      SalesModel(color: Color(0xff632100), title: "Invoice", widget: LeadScreen()),
      SalesModel(color: Color(0xff632100), title: "Revenue", widget: LeadScreen()),
      SalesModel(color: Color(0xff632100), title: "Credit Note", widget: LeadScreen()),
    ];
  }
}
