import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/model/leave_model.dart';
import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/service/leave_service.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_manamgemant/widgets/leave_request_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveController extends GetxController {
  final List<LeaveColorModel> leaveColors = LeaveColorModel.getLeaves();
  final LeaveService leaveService = LeaveService();

  Color getLeaveTypeColor(String leaveType) {
    return leaveColors
        .firstWhere(
          (item) => item.leaveType == leaveType,
          orElse: () => LeaveColorModel(color: Colors.grey, leaveType: ''),
        )
        .color;
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<List<LeaveModel>> getLeaves() async =>
      await LeaveService.getLeaves();

  void addLeave() {
    showDialog(
      context: Get.context!,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: LeaveRequestCardDialog(),
          ),
    );
  }
}

class LeaveColorModel {
  final String leaveType;
  final Color color;

  LeaveColorModel({required this.leaveType, required this.color});

  static List<LeaveColorModel> getLeaves() {
    return [
      LeaveColorModel(color: Colors.green, leaveType: "Present"),
      LeaveColorModel(color: Colors.red, leaveType: "Absent"),
      LeaveColorModel(color: Colors.orange, leaveType: "Leave"),
      LeaveColorModel(color: Colors.blue, leaveType: "Half Day"),
      LeaveColorModel(color: Colors.purple, leaveType: "Paid Holiday"),
      LeaveColorModel(color: Colors.deepPurple, leaveType: "Unpaid Holiday"),
      LeaveColorModel(color: Colors.teal, leaveType: "Weekend"),
    ];
  }
}
