import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FunctionModel {
  final IconData? icon;
  final String? title;
  final Color? color;
  final String? appRoutes;

  FunctionModel({
    required this.title,
    required this.icon,
    required this.color,
    this.appRoutes,
  });

  static List<FunctionModel> getFunctions() {
    return [
      FunctionModel(
        title: "Lead",
        icon: FontAwesomeIcons.at,
        color: Color(0xff632100),
        appRoutes: AppRoutes.lead,
      ),
      FunctionModel(
        title: "Deals",
        icon: FontAwesomeIcons.at,
        color: Color(0xff234567),
        appRoutes: AppRoutes.deal,
      ),
      FunctionModel(
        title: "Task",
        icon: FontAwesomeIcons.at,
        color: Color(0xff098765),
        appRoutes: AppRoutes.task,
      ),
      FunctionModel(
        title: "Contact",
        icon: FontAwesomeIcons.at,
        color: Color(0xff284398),
        appRoutes: AppRoutes.contact,
      ),
    ];
  }
}
