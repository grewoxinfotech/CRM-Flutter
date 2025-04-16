import 'package:flutter/material.dart';

class ViewModel extends StatelessWidget {
  final int? itemCount;
  final NullableIndexedWidgetBuilder? itemBuilder;

  const ViewModel({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: itemCount!,
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: itemBuilder!,
    );
  }
}
