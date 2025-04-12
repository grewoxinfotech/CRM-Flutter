import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/graf/features/graf_controller.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/widget/graf/graf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCircularProgress extends StatelessWidget {
  final double percentage;
  final double width;

  final ProgressController controller = Get.put(ProgressController());

  CustomCircularProgress({
    super.key,
    required this.percentage,
    this.width = 100,
  }) {
    controller.startAnimation(percentage);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CircularProgressBar(
        progress: controller.progress.value,
        width: width,
      ),
    );
  }
}
