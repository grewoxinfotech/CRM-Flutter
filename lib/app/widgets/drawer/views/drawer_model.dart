import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/views/crm_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/views/hrm_screen.dart';
import 'package:crm_flutter/app/modules/screens/job/views/job_screen.dart';
import 'package:crm_flutter/app/modules/screens/purchase/views/purchase_screen.dart';
import 'package:crm_flutter/app/modules/screens/sales/views/sales_screen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DrawerModel {
  String? title;
  bool? showArrowRight;
  IconData? iconData;
  Widget? widget;

  DrawerModel({
    this.title,
    this.iconData,
    this.widget,
    this.showArrowRight = true,
  });

  static List<DrawerModel> getDrawerItems() {
    return [
      DrawerModel(
        title: "DashBoard",
        iconData: LucideIcons.home,
        showArrowRight: false,
        widget: DashboardScreen(),
      ),
      DrawerModel(
        title: "CRM",
        iconData: LucideIcons.users,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "Sales",
        iconData: LucideIcons.shoppingCart,
        widget: SalesScreen(),
      ),
      DrawerModel(
        title: "Purchase",
        iconData: LucideIcons.shoppingBag,
        widget: PurchaseScreen(),
      ),
      DrawerModel(
        title: "User Management",
        iconData: LucideIcons.users,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "Communication",
        iconData: LucideIcons.messageSquare,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "HRM",
        iconData: LucideIcons.users,
        widget: HrmScreen(),
      ),
      DrawerModel(
        title: "Job",
        iconData: LucideIcons.briefcase,
        widget: JobScreen(),
      ),
      DrawerModel(
        title: "Setting",
        iconData: LucideIcons.settings,
        widget: CrmScreen(),
      ),
      DrawerModel(
        title: "Support",
        iconData: LucideIcons.helpCircle,
        widget: CrmScreen(),
      ),
    ];
  }
}
