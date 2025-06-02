import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewScreen extends StatelessWidget {
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final Widget? separatorWidget;
  final ScrollController? controller;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final Axis scrollDirection;

  const ViewScreen({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorWidget,
    this.controller,
    this.padding,
    this.physics,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  ListView.separated(
        physics: physics ?? NeverScrollableScrollPhysics(),
        reverse: reverse,
        padding: padding,
        separatorBuilder:
            (context, index) => Obx(() => separatorWidget ?? SizedBox(height: 10)),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
