import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Attendance")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.medium),
        child: Column(
          children: [
            CrmCard(
              padding: EdgeInsets.all(AppPadding.medium),
              child: Column(
                children: [


                  Divider(
                    color: Get.theme.dividerColor,
                    height: AppPadding.medium * 2,
                  ),
                  CrmButton(
                    width: double.infinity,
                    title: "Ask for Leave",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
