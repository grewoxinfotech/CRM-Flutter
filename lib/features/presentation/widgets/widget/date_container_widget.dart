import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_container.dart';
import 'package:flutter/material.dart';

class DateContainerWidget extends StatelessWidget {
  final String fd;
  final String ld;

  const DateContainerWidget({super.key, required this.fd, required this.ld});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      width: 500,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      borderRadius: BorderRadius.circular(14),
      child: Text(
        "${fd} - ${ld}",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
