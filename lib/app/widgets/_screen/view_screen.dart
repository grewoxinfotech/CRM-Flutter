import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatelessWidget {
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final ScrollController? controller;
  final bool reverse;

  const ViewScreen({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      reverse: reverse,
      itemCount: itemCount,
      shrinkWrap: true,
      primary: true,
      controller: controller,
      padding: const EdgeInsets.only(top: AppPadding.medium,bottom: 80),
      separatorBuilder:
          (context, s) => AppSpacing.verticalSmall,
      itemBuilder: itemBuilder,
    );
  }
}
