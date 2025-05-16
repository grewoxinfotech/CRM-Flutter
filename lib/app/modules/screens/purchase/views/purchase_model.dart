import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:flutter/material.dart';

class PurchaseModel {
  String? title;
  Widget? widget;
  Color? color;
  IconData? iconData;

   PurchaseModel({required this.title, this.color, this.widget, this.iconData});

  static List< PurchaseModel> getCrmWidgets() {
    return [
       PurchaseModel(color: Color(0xff632100), title: "Vendor", widget: LeadScreen()),
       PurchaseModel(color: Color(0xff632100), title: "Billing", widget: LeadScreen()),
       PurchaseModel(color: Color(0xff632100), title: "Debit Note", widget: LeadScreen()),
    ];
  }
}
