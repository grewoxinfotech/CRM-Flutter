import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FunctionModel {
  final IconData? icon;
  final String? title;
  final Color? color;
  final String? appRoutes;

  FunctionModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.appRoutes,
  });

  static List<FunctionModel> getFunctions() {
    return [
      FunctionModel(
        title: "Lead",
        icon: LucideIcons.target,
        color: Color(0xff632100),
        appRoutes: AppRoutes.deal,
      ),
      FunctionModel(
        title: "Deal",
        icon: LucideIcons.heartHandshake,
        color: Color(0xff234567),
        appRoutes: AppRoutes.deal,
      ),
      FunctionModel(
        title: "Task",
        icon: LucideIcons.clipboardCheck,
        color: Color(0xff098765),
        appRoutes: AppRoutes.contact,
      ),
      FunctionModel(
        title: "Contact",
        icon:  LucideIcons.users2,
        color: Color(0xff284398),
        appRoutes: AppRoutes.lead,
      ),
    ];
  }
}
