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
      scrollDirection: scrollDirection,
      physics: physics,
      reverse: reverse,
      itemCount: itemCount,
      shrinkWrap: true,
      primary: true,
      controller: controller,
      padding:
          padding ?? const EdgeInsets.only(top: AppPadding.medium, bottom: 80),
      separatorBuilder:
          (context, s) => separatorWidget ?? AppSpacing.verticalSmall,
      itemBuilder: itemBuilder,
    );
  }
}
