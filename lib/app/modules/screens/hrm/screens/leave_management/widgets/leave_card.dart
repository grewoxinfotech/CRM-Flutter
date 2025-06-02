import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/hrm/leave_manamgemant/model/leave_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel? leave;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEdit;

  const LeaveCard({Key? key, this.leave, this.onTap, this.onEdit})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Obx(
        () => CrmCard(
          boxShadow: [],
          border: Border.all(color: AppColors.divider),
          padding: const EdgeInsets.all(AppPadding.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [TextSpan(text: "N/A - N/A")],
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "N/A Application",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => CrmStatusCard(title: "N/A", color: Colors.red)),
                  SizedBox(height: 10),
                  CrmStatusCard(title: "N/A", color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
