import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';

class HrmModel {
  final String title;
  final Widget widget;
  final Color color;
  final IconData? iconData;

  HrmModel({
    required this.title,
    required this.widget,
    required this.color,
    this.iconData,
  });

  static List<HrmModel> getCrmWidgets() {
    return [
      HrmModel(
        title: "Employee",
        widget: LeadScreen(),
        color: Color(0xFF00796B),
      ),
      HrmModel(
        title: "Payroll",
        widget: LeadScreen(),
        color: Color(0xFF6A1B9A),
      ),
      HrmModel(title: "Role", widget: LeadScreen(), color: Color(0xFF283593)),
      HrmModel(title: "Branch", widget: LeadScreen(), color: Color(0xFF1565C0)),
      HrmModel(
        title: "Designation",
        widget: LeadScreen(),
        color: Color(0xFF00838F),
      ),
      HrmModel(
        title: "Department",
        widget: LeadScreen(),
        color: Color(0xFF558B2F),
      ),
      HrmModel(
        title: "Attendance",
        widget: LeadScreen(),
        color: Color(0xFFF57C00),
      ),
      HrmModel(
        title: "Holiday",
        widget: LeadScreen(),
        color: Color(0xFFD32F2F),
      ),
      HrmModel(title: "Leave", widget: LeadScreen(), color: Color(0xFF5D4037)),
      HrmModel(
        title: "Calendar",
        widget: LeadScreen(),
        color: Color(0xFF1976D2),
      ),
      HrmModel(
        title: "Meeting",
        widget: LeadScreen(),
        color: Color(0xFF455A64),
      ),
      HrmModel(
        title: "Announcement",
        widget: LeadScreen(),
        color: Color(0xFF0097A7),
      ),
      HrmModel(
        title: "Document",
        widget: LeadScreen(),
        color: Color(0xFF6D4C41),
      ),
      HrmModel(
        title: "Training",
        widget: LeadScreen(),
        color: Color(0xFF512DA8),
      ),
    ];
  }
}
