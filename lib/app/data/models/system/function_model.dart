import 'package:flutter/material.dart';

class FunctionModel {
  final String? title;
  final String? iconPath;
  final Color? color;
  final int? count;
  final Widget? screenBuilder;

  FunctionModel({
    this.title,
    this.iconPath,
    this.color,
    this.count,
    this.screenBuilder,
  });
}
