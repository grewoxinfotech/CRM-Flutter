import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/model/leave_model.dart';
import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/service/leave_service.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_manamgemant/views/leave_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_manamgemant/widgets/leave_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  LeaveList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LeaveModel>>(
      future: LeaveService.getLeaves(),
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
                'Server Error : \n${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final leaves = snapshot.data!;
          if (leaves.isEmpty) {
            return const Center(child: Text("No Leaves Found"));
          } else {
            return ViewScreen(
              padding: padding,
              itemCount:
                  (itemCount != null && itemCount! < leaves.length)
                      ? itemCount!
                      : leaves.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => LeaveCard(leave: leaves[i],onTap: () => Get.to(LeaveScreen()),),
            );
          }
        } else {
          return const Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
