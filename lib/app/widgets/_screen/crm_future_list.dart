import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_error_text.dart';
import 'package:flutter/material.dart';

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
    this.emptyText = "No Data Found",
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CrmLoadingCircle();
        } else if (snapshot.hasError) {
          return CrmErrorText(errorText: snapshot.error.toString());
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.isEmpty) {
            return Center(child: Text(emptyText));
          } else {
            return ViewScreen(
              padding: padding,
              itemCount:
                  (itemCount != null && itemCount! < data.length)
                      ? itemCount!
                      : data.length,
              physics: physics ?? const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => itemBuilder(context, data[i]),
            );
          }
        } else {
          return const Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
