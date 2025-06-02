import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/widgets/leave_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';

class LeaveList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  LeaveList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return ViewScreen(
      padding: padding,
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) => LeaveCard(),
    );
  }
}
