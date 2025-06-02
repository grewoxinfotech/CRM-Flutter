import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueCard extends StatelessWidget {
  final double revenue;

  const RevenueCard({super.key, required this.revenue});

  Color get revenueColor {
    return (revenue <= 0) ? Colors.red.shade900 : Colors.green.shade900;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CrmCard(
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        border: Border.all(color: AppColors.divider),
        padding: EdgeInsets.all(AppPadding.medium),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Revenue : ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            Obx(
              () => TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: revenue),
                duration: Duration(seconds:2),  // animation duration
                builder: (context, value, child) {
                  return Text(
                    // Number ko currency format me convert kar sakte ho
                    '\$${value.toStringAsFixed(2)}',
                    style:TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: revenueColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
