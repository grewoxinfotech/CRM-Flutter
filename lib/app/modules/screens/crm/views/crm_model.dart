import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
      CrmModel(
        title: "Leads",
        color: Color(0xff632100),
        iconData: LucideIcons.target,
        appRoutes: AppRoutes.lead,
      ),
      CrmModel(
        title: "Deals",
        color: Color(0xff234567),
        iconData: LucideIcons.heartHandshake,
        appRoutes: AppRoutes.deal,
      ),
      CrmModel(
        title: "Task",
        color: Color(0xff098765),
        iconData: LucideIcons.clipboardCheck,
        appRoutes: AppRoutes.task,
      ),
      CrmModel(
        title: "Contact",
        color: Color(0xff284398),
        iconData: LucideIcons.users2,
        appRoutes: AppRoutes.contact,
      ),
      CrmModel(
        title: "Company",
        color: Color(0xffEB2F96),
        iconData: LucideIcons.building2,
        appRoutes: AppRoutes.company,
      ),
      CrmModel(
        title: "Custom Form",
        color: Color(0xff253684),
        iconData: LucideIcons.fileText,
        appRoutes: AppRoutes.customForm,
      ),
      CrmModel(
        title: "Task Calender",
        widget: LeadScreen(),
        color: Color(0xff114515),
        iconData: LucideIcons.calendarClock,
      ),
      CrmModel(
        title: "CRM System",
        widget: LeadScreen(),
        color: Color(0xff546145),
        iconData: LucideIcons.settings2,
      ),
    ];
  }
}
