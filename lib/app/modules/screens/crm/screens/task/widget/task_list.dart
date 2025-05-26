import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/task/model/task_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/widget/task_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  const TaskList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.put(TaskController());
    return FutureBuilder<List<TaskModel>>(
      future: controller.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CrmLoadingCircle(),
          ); // or CrmLoadingCircle()
        } else if (snapshot.hasError) {
          return Center(
            child: SizedBox(
              width: 250,
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: error, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final tasks = snapshot.data!;
          if (tasks.isEmpty) {
            return const Center(child: Text("No Task Found"));
          } else {
            print("ahahahahahahahahahahahahaahhahahahahahahaahaha  : $tasks");
            return ViewScreen(
              padding:
                  padding ??
                  EdgeInsets.symmetric(horizontal: AppPadding.medium),
              itemCount:
                  (itemCount != null && itemCount! < tasks.length)
                      ? itemCount!
                      : tasks.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => TaskCard(task: tasks[i]),
            );
          }
        } else {
          return const Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
