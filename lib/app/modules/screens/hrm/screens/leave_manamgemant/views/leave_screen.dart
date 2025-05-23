import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_manamgemant/views/leave_list.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Leaves"), leading: CrmBackButton()),
      body: LeaveList(),
    );
  }
}
