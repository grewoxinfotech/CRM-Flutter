import 'package:crm_flutter/app/data/network/all/crm/task/model/task_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/task/service/task_service.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/widget/task_card.dart';
import 'package:crm_flutter/app/widgets/_screen/crm_future_list.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  const TaskList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return CrmFutureList<TaskModel>(
      padding: padding,
      itemCount: itemCount,
      emptyText: "No Task Found",
      future: TaskService().getTasks(),
      itemBuilder: (context, task) => TaskCard(task: task),
    );
  }
}
