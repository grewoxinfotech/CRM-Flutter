import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';

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
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      scrollDirection: scrollDirection,
      physics: physics,
      reverse: reverse,
      shrinkWrap: true,
      primary: true,
      separatorBuilder: (context, s) => separatorWidget ?? AppSpacing.verticalSmall,
      padding: padding ?? const EdgeInsets.all(AppMargin.medium).copyWith(bottom: 300),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
