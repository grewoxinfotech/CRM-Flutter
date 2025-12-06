import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/functions/controller/function_controller.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/views/attendance_widget.dart';
import 'package:crm_flutter/app/modules/home/widgets/deal_overview_with_graph.dart';
import 'package:crm_flutter/app/modules/home/widgets/most_selling_product.dart';
import 'package:crm_flutter/app/modules/home/widgets/revenue_graph.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/revenue/controllers/revenue_controller.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/lead_overview_with_graph.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(FunctionController());
  final RevenueController revenueController = Get.put(RevenueController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium * 2,
              vertical: AppPadding.small,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi Evan, Welcome back!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Get.theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                AppSpacing.verticalSmall,
                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.small),

          AttendanceWidget(),
          SizedBox(height: AppSpacing.small),

          Obx(() {
            if (revenueController.isLoading.value &&
                revenueController.items.isEmpty) {
              return Center(child: CrmLoadingCircle());
            }

            if (!revenueController.isLoading.value &&
                revenueController.items.isEmpty) {
              return SizedBox.shrink();
            }
            return RevenueChart(revenueData: revenueController.items);
          }),
          SizedBox(height: AppSpacing.small),

          LeadsOverviewCard(),
          SizedBox(height: AppSpacing.small),

          DealsOverviewCard(),
          SizedBox(height: AppSpacing.small),

          SafeArea(child: MostSellingProductScreen()),
        ],
      ),
    );
  }
}
