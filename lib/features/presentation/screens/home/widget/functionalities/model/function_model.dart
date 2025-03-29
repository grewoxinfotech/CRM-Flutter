import 'package:crm_flutter/features/data/resources/icon_resources.dart';
import 'package:crm_flutter/features/data/resources/image_resources.dart';
import 'package:crm_flutter/features/presentation/screens/lead/lead_screen/lead_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionModel {
  final String? imagePath;
  final String? title;
  final String? unitId;
  final Color? color;
  final int? num;
  final Widget? widget;


  const FunctionModel({
    this.title,
    this.imagePath,
    this.unitId,
    this.color,
    this.num,
    this.widget,
  });

  static List<FunctionModel> getFunctionitems() {
    List<FunctionModel> functionitems = [];
    functionitems.add(
      FunctionModel(
        imagePath: IconResources.LEADS,
        title: "Leads",
        unitId: "leads",
        color: Color(0xffFFBD21),
        num: 26,
        widget: LeadScreen()
      ),
    );
    functionitems.add(
      FunctionModel(
        imagePath: IconResources.TASK,
        title: "Task",
        unitId: "task",
        color: Color(0xff0AC947),
        num: 56,
      ),
    );
    functionitems.add(
      FunctionModel(
        imagePath: IconResources.CUSTOMER,
        title: "Customer",
        unitId: "customer",
        color: Color(0xff6D5DD3),
        num: 10,
      ),
    );
    functionitems.add(
      FunctionModel(
        imagePath: IconResources.EMPLAYEE,
        title: "Employee",
        unitId: "employee",
        color: Color(0xff2B648F),
        num: 04,
      ),
    );
    functionitems.add(
      FunctionModel(
        imagePath: IconResources.CLIENTS,
        title: "Clients",
        unitId: "clients",
        color: Color(0xffFFCC01),
        num: 45,
      ),
    );
    functionitems.add(
      FunctionModel(
        imagePath: IconResources.CONTRACT,
        title: "Contract",
        unitId: "contract",
        color: Color(0xff3400AD),
        num: 66,
      ),
    );
    return functionitems;
  }
}
