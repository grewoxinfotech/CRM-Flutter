import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/widgets/attendance/controllers/graf_controller.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/widgets/attendance/views/graf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrafProgress extends StatelessWidget {
  final double percentage;
  final double width;

  final GrafController controller = Get.put(GrafController());

  GrafProgress({
    super.key,
    required this.percentage,
    this.width = 100,
  }) {
    controller.startAnimation(percentage);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>  CircularProgressBar(
        progress: controller.progress.value,
        width: width * 2,
      ),
    );
  }
}
