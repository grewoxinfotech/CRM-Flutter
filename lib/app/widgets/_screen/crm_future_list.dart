import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_error_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);

class CrmFutureList<T> extends StatelessWidget {
  final Future<List<T>> future;
  final ItemBuilder<T> itemBuilder;
  final EdgeInsetsGeometry? padding;
  final int? itemCount;
  final ScrollPhysics? physics;
  final String emptyText;

  const CrmFutureList({
    super.key,
    required this.future,
    required this.itemBuilder,
    this.padding,
    this.itemCount,
    this.physics,
    this.emptyText = "No data found",
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  FutureBuilder<List<T>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CrmLoadingCircle();
          }

          if (snapshot.hasError) {
            return CrmErrorText(errorText: snapshot.error.toString());
          }

          final data = snapshot.data;

          if (data == null || data.isEmpty) {
            return Center(child: Text(emptyText));
          }

          return Obx(
            ()=> ViewScreen(
              padding: padding,
              physics: physics ?? NeverScrollableScrollPhysics(),
              itemCount: itemCount != null && itemCount! < data.length
                  ? itemCount!
                  : data.length,
              itemBuilder: (context, index) => itemBuilder(context, data[index]),
            ),
          );
        },
      ),
    );
  }
}
