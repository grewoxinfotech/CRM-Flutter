import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({super.key});

  @override
  Widget build(BuildContext context) {
    double revenue = 100;
    Color x() {
      final color =
          (revenue <= 0) ? Colors.red.shade900 : Colors.green.shade900;
      return color;
    }

    return CrmCard(
      margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      border: Border.all(color: divider),
      padding: EdgeInsets.all(AppPadding.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Revenue : ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: primary,
            ),
          ),
          Text(
            "₹ $revenue",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: x(),
            ),
          ),
        ],
      ),
    );
  }
}
