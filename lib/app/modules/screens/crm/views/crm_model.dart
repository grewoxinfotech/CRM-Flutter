import 'package:crm_flutter/app/modules/screens/crm/screens/company/views/company_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/views/contact_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/views/deal_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_screen.dart';
import 'package:crm_flutter/app/modules/screens/sales/screens/customer/views/customer_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:flutter/material.dart';

class CrmModel {
  String? title;
  Widget? widget;
  Color? color;
  IconData? iconData;

  CrmModel({required this.title, this.color, this.widget, this.iconData});

  static List<CrmModel> getCrmWidgets() {
    return [
      CrmModel(color: Color(0xff632100), title: "Leads", widget: LeadScreen()),
      CrmModel(color: Color(0xff234567), title: "Deals", widget: DealScreen()),
      CrmModel(color: Color(0xff098765), title: "Task", widget: TaskScreen()),
      CrmModel(
        color: Color(0xff284398),
        title: "Contact",
        widget: ContactScreen(),
      ),
      CrmModel(
        color: Color(0xffEB2F96),
        title: "Company",
        widget: CompanyScreen(),
      ),
      CrmModel(
        color: Color(0xff253684),
        title: "Custom Form",
        widget: CustomerScreen(),
      ),
      CrmModel(
        color: Color(0xff114515),
        title: "Task Calender",
        widget: LeadScreen(),
      ),
      CrmModel(
        color: Color(0xff546145),
        title: "CRM System",
        widget: LeadScreen(),
      ),
    ];
  }
}
