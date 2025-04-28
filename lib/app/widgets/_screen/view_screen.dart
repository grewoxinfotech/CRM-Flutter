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
      padding: const EdgeInsets.only(bottom: 80),
      separatorBuilder: (context, s) => const SizedBox(height: 10, width: 10),
      itemBuilder: itemBuilder,
    );
  }
}
