import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  var isPunchedIn = false.obs;
  var punchTime = ''.obs;

  void togglePunch() {
    isPunchedIn.value = !isPunchedIn.value;
    punchTime.value = DateFormat('hh:mm a').format(DateTime.now());
  }
}

class PunchButton extends StatelessWidget {
  final AttendanceController controller = Get.put(AttendanceController());

  PunchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.isPunchedIn.value ? 'You are PUNCHED IN' : 'You are PUNCHED OUT',
            style: TextStyle(
              fontSize: 18,
              color: controller.isPunchedIn.value ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (controller.punchTime.isNotEmpty)
            Text(
              'Since: ${controller.punchTime.value}',
              style: TextStyle(color: Colors.grey),
            ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: controller.togglePunch,
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.isPunchedIn.value ? Colors.red : Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: Icon(controller.isPunchedIn.value ? Icons.logout : Icons.login),
            label: Text(
              controller.isPunchedIn.value ? 'Punch Out' : 'Punch In',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    });
  }
}
