import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_screen.dart';

class JobModel {
  final String title;
  final Widget widget;
  final Color color;
  final IconData iconData;

  JobModel({
    required this.title,
    required this.widget,
    required this.color,
    required this.iconData,
  });

  static List<JobModel> getCrmWidgets() {
    return [];
  }
}
