// 📁 function_model.dart

import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/screens/deal/deals_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/screens/lead/leads_screen.dart';
import 'package:flutter/material.dart';

class FunctionModel {
  final String title;
  final String iconPath;
  final Color color;
  final int count;
  final Widget Function()? screenBuilder;

  const FunctionModel({
    required this.title,
    required this.iconPath,
    required this.color,
    required this.count,
    this.screenBuilder,
  });

  static List<FunctionModel> all() => [
    FunctionModel(
      title: 'Leads',
      iconPath: ICRes.leads,
      color: const Color(0xffFFBD21),
      count: 26,
      screenBuilder: () => LeadsScreen(),
    ),
    FunctionModel(
      title: 'Deals',
      iconPath: ICRes.leads,
      color: const Color(0xff28B999),
      count: 26,
      screenBuilder: () => DealsScreen(),
    ),
    FunctionModel(
      title: 'Tasks',
      iconPath: ICRes.task,
      color: const Color(0xff0AC947),
      count: 56,
    ),
    FunctionModel(
      title: 'Customer',
      iconPath: ICRes.custemer,
      color: const Color(0xff6D5DD3),
      count: 10,
    ),
    FunctionModel(
      title: 'Employee',
      iconPath: ICRes.employees,
      color: const Color(0xff2B648F),
      count: 4,
    ),
    FunctionModel(
      title: 'Clients',
      iconPath: ICRes.clients,
      color: const Color(0xffFFCC01),
      count: 45,
    ),
    FunctionModel(
      title: 'Contract',
      iconPath: ICRes.contract,
      color: const Color(0xff3400AD),
      count: 66,
    ),
  ];
}
