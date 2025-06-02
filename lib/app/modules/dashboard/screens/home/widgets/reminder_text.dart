import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:crm_flutter/app/widgets/orbiting.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ReminderText extends StatelessWidget {
  const ReminderText({super.key});

  @override
  Widget build(BuildContext context) {
    final username = "raiser2";
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppPadding.small,
        horizontal: AppMargin.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              OrbitingWidget(
                radius: 1,
                child: CrmIc(
                  icon: LucideIcons.clock4,
                  color: AppColors.primary,
                  size: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                formatDate(DateTime.now().toString()),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Text(
            "Good Morning, $username!",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          Text(
            "WellCome Back to your Work",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color:AppColors. textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
