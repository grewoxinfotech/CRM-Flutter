import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../widgets/_screen/view_screen.dart';
import '../../../../widgets/button/crm_back_button.dart';
import '../../leave/controllers/leave_controller.dart';
import '../../leave/widgets/leave_card.dart';

class LeaveScreen extends StatelessWidget {
  LeaveScreen({super.key}) {
    Get.put(LeaveController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(),
        title: const Text("Leave Management"),
        actionsPadding: EdgeInsets.only(right: AppPadding.medium),
        actions: [
          CrmButton(
            width: 80,
            height: 30,
            boxShadow: [],
            title: "Export",
            onTap: () => print("Export File"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add_task, color: Colors.white),
        label: Text(
          "Ask for Leave",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Get.theme.colorScheme.surface,
          ),
        ),
      ),
      body: ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppMargin.medium),
        itemBuilder:
            (context, i) => LeaveCard(
              employeeName: "John Doe",
              leaveType: "Half Day",
              startDate: "2025-05-15",
              endDate: "2025-05-17",
              status: "Approved",
              reason: "dafasdfa",
              onEdit: () => print("Edit tapped"),
              onDelete: () => print("Delete tapped"),
            ),
      ),
    );
  }
}
