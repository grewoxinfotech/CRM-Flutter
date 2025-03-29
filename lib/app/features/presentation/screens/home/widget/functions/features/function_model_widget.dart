import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/lead_screen.dart';
import 'package:flutter/material.dart';

class FunctionModelWidget {
  final String? imagePath;
  final String? title;
  final String? unitId;
  final Color? color;
  final int? num;
  final Widget? widget;

  const FunctionModelWidget({
    this.title,
    this.imagePath,
    this.unitId,
    this.color,
    this.num,
    this.widget,
  });

  static List<FunctionModelWidget> getwidgets() {
    List<FunctionModelWidget> widgets = [];
    widgets.add(
      FunctionModelWidget(
        imagePath: IconResources.LEADS,
        title: "Leads",
        unitId: "leads",
        color: Color(0xffFFBD21),
        num: 26,
        widget: LeadScreen(),
      ),
    );
    widgets.add(
      FunctionModelWidget(
        imagePath: IconResources.TASK,
        title: "Task",
        unitId: "task",
        color: Color(0xff0AC947),
        num: 56,
      ),
    );
    widgets.add(
      FunctionModelWidget(
        imagePath: IconResources.CUSTOMER,
        title: "Customer",
        unitId: "customer",
        color: Color(0xff6D5DD3),
        num: 10,
      ),
    );
    widgets.add(
      FunctionModelWidget(
        imagePath: IconResources.EMPLAYEE,
        title: "Employee",
        unitId: "employee",
        color: Color(0xff2B648F),
        num: 04,
      ),
    );
    widgets.add(
      FunctionModelWidget(
        imagePath: IconResources.CLIENTS,
        title: "Clients",
        unitId: "clients",
        color: Color(0xffFFCC01),
        num: 45,
      ),
    );
    widgets.add(
      FunctionModelWidget(
        imagePath: IconResources.CONTRACT,
        title: "Contract",
        unitId: "contract",
        color: Color(0xff3400AD),
        num: 66,
      ),
    );
    return widgets;
  }
}
