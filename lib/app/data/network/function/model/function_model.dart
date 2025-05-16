import 'package:flutter/material.dart';

class FunctionModel {
  final String title;
  final IconData icon;
  final Color color;
  final Widget? screenBuilder;

  FunctionModel({
    required this.title,
    required this.icon,
    required this.color,
    this.screenBuilder,
  });
}
