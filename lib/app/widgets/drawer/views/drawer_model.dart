import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/views/crm_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/views/hrm_screen.dart';
import 'package:crm_flutter/app/modules/screens/job/views/job_screen.dart';
import 'package:crm_flutter/app/modules/screens/purchase/views/purchase_screen.dart';
import 'package:crm_flutter/app/modules/screens/sales/views/sales_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerModel {
  String? title;
  IconData? iconData;
  Widget? widget;

  DrawerModel({this.title, this.iconData, this.widget});

  static List<DrawerModel> getDrowerItems() {
    return [
      DrawerModel(
        title: "DashBoard",
        iconData: FontAwesomeIcons.at,
        widget: DashboardScreen(),
      ),
      DrawerModel(
        title: "Crm",
        iconData: FontAwesomeIcons.at,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "Sales",
        iconData: FontAwesomeIcons.at,
        widget: SalesScreen(),
      ),
      DrawerModel(
        title: "Purchase",
        iconData: FontAwesomeIcons.at,
        widget: PurchaseScreen(),
      ),
      DrawerModel(
        title: "User Management",
        iconData: FontAwesomeIcons.at,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "Communication",
        iconData: FontAwesomeIcons.at,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "Hrm",
        iconData: FontAwesomeIcons.at,
        widget: HrmScreen(),
      ),
      DrawerModel(
        title: "Job",
        iconData: FontAwesomeIcons.at,
        widget: JobScreen(),
      ),
      DrawerModel(
        title: "Setting",
        iconData: FontAwesomeIcons.at,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "Support",
        iconData: FontAwesomeIcons.at,
        widget: CrmScreen(),
      ),
    ];
  }
}
