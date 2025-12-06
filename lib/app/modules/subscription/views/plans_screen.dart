import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../care/constants/color_res.dart';
import '../../../care/constants/font_res.dart';
import '../../../widgets/button/crm_button.dart';
import '../../../widgets/common/indicators/crm_loading_circle.dart';
import '../controllers/plan_controller.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PlanController controller = Get.put(PlanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Plans'),
        actions: [
          IconButton(
            onPressed: () => controller.refreshPlans(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CrmLoadingCircle());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: ColorRes.error),
                const SizedBox(height: 16),
                Text(
                  controller.error.value,
                  style: TextStyle(
                    fontFamily: FontRes.nuNunitoSans,
                    fontSize: 16,
                    color: ColorRes.error,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshPlans(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.plans.isEmpty) {
          return const Center(child: Text('No plans available'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshPlans,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.plans.length,
            itemBuilder: (context, index) {
              final plan = controller.plans[index];
              return _buildPlanCard(context, plan);
            },
          ),
        );
      }),
    );
  }

  Widget _buildPlanCard(BuildContext context, plan) {
    final bool isDefault = plan.isDefault ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            isDefault
                ? BorderSide(color: ColorRes.primary, width: 2)
                : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plan name and default badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    plan.name ?? 'N/A',
                    style: TextStyle(
                      fontFamily: FontRes.nuNunitoSans,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: ColorRes.primary,
                    ),
                  ),
                ),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorRes.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'DEFAULT',
                      style: TextStyle(
                        fontFamily: FontRes.nuNunitoSans,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: ColorRes.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${plan.price ?? '0'}',
                  style: TextStyle(
                    fontFamily: FontRes.nuNunitoSans,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: ColorRes.black,
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    '/ ${plan.duration ?? 'N/A'}',
                    style: TextStyle(
                      fontFamily: FontRes.nuNunitoSans,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorRes.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Divider
            Divider(color: ColorRes.grey.withOpacity(0.3)),
            const SizedBox(height: 12),

            // Features
            _buildFeatureRow(
              Icons.storage_rounded,
              'Storage',
              '${plan.storageLimit ?? 'N/A'} GB',
            ),
            _buildFeatureRow(
              Icons.people_outline,
              'Max Users',
              plan.maxUsers ?? 'N/A',
            ),
            _buildFeatureRow(
              Icons.person_outline,
              'Max Clients',
              plan.maxClients ?? 'N/A',
            ),
            _buildFeatureRow(
              Icons.groups_outlined,
              'Max Customers',
              plan.maxCustomers ?? 'N/A',
            ),
            _buildFeatureRow(
              Icons.business_outlined,
              'Max Vendors',
              plan.maxVendors ?? 'N/A',
            ),
            _buildFeatureRow(
              Icons.calendar_today,
              'Trial Period',
              '${plan.trialPeriod ?? '0'} days',
            ),

            const SizedBox(height: 16),

            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color:
                    plan.status?.toLowerCase() == 'active'
                        ? ColorRes.success.withOpacity(0.1)
                        : ColorRes.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                (plan.status ?? 'N/A').toUpperCase(),
                style: TextStyle(
                  fontFamily: FontRes.nuNunitoSans,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color:
                      plan.status?.toLowerCase() == 'active'
                          ? ColorRes.success
                          : ColorRes.error,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Buy Plan Button
            SizedBox(
              width: double.infinity,
              child: CrmButton(
                title: 'Buy Plan',
                onTap: () => _showDateSelectionDialog(context, plan),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: ColorRes.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: FontRes.nuNunitoSans,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorRes.grey,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: FontRes.nuNunitoSans,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ColorRes.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showDateSelectionDialog(BuildContext context, dynamic plan) {
    // Calculate start and end dates
    final DateTime startDate = DateTime.now();
    final DateTime endDate = _calculateEndDate(startDate, plan.duration);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Purchase',
            style: TextStyle(
              fontFamily: FontRes.nuNunitoSans,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plan details summary
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorRes.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name ?? 'N/A',
                        style: TextStyle(
                          fontFamily: FontRes.nuNunitoSans,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: ColorRes.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Price: ₹${plan.price ?? 'N/A'}',
                        style: TextStyle(
                          fontFamily: FontRes.nuNunitoSans,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Duration: ${plan.duration ?? 'N/A'}',
                        style: TextStyle(
                          fontFamily: FontRes.nuNunitoSans,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Plan Dates Section
                Text(
                  'Plan Validity Period',
                  style: TextStyle(
                    fontFamily: FontRes.nuNunitoSans,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),

                // Start Date Display
                _buildDateInfoRow(
                  'Start Date',
                  DateFormat('dd MMM yyyy').format(startDate),
                ),
                const SizedBox(height: 8),

                // End Date Display
                _buildDateInfoRow(
                  'End Date',
                  DateFormat('dd MMM yyyy').format(endDate),
                ),
                const SizedBox(height: 20),

                // Additional Info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColorRes.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ColorRes.success.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: ColorRes.success,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This plan includes ${plan.trialPeriod ?? '0'} days trial period',
                          style: TextStyle(
                            fontFamily: FontRes.nuNunitoSans,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: FontRes.nuNunitoSans,
                  color: ColorRes.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _handlePlanPurchase(plan, startDate, endDate);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorRes.primary,
              ),
              child: Text(
                'Confirm Purchase',
                style: TextStyle(
                  fontFamily: FontRes.nuNunitoSans,
                  color: ColorRes.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  DateTime _calculateEndDate(DateTime startDate, String? duration) {
    if (duration == null) {
      // Default to 30 days if no duration specified
      return startDate.add(const Duration(days: 30));
    }

    // Parse duration string (e.g., "1 Month", "3 Months", "Lifetime", "1 Year")
    final durationLower = duration.toLowerCase();

    if (durationLower.contains('lifetime')) {
      // For lifetime, add 100 years
      return DateTime(startDate.year + 100, startDate.month, startDate.day);
    }

    // Extract number from duration string
    final match = RegExp(r'(\d+)').firstMatch(durationLower);
    if (match != null) {
      final int value = int.parse(match.group(1)!);

      if (durationLower.contains('day')) {
        return startDate.add(Duration(days: value));
      } else if (durationLower.contains('week')) {
        return startDate.add(Duration(days: value * 7));
      } else if (durationLower.contains('month')) {
        return DateTime(startDate.year, startDate.month + value, startDate.day);
      } else if (durationLower.contains('year')) {
        return DateTime(startDate.year + value, startDate.month, startDate.day);
      }
    }

    // Default to 30 days if parsing fails
    return startDate.add(const Duration(days: 30));
  }

  Widget _buildDateInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorRes.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 18, color: ColorRes.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontRes.nuNunitoSans,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorRes.grey,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: FontRes.nuNunitoSans,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ColorRes.black,
            ),
          ),
        ],
      ),
    );
  }

  void _handlePlanPurchase(
    dynamic plan,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final controller = Get.find<PlanController>();



    // ✅ Step 1: Show snackbar feedback
    Get.snackbar(
      'Processing',
      'Creating order for ${plan.name}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorRes.success,
      colorText: ColorRes.white,
      duration: const Duration(seconds: 2),
    );

    final user = await SecureStorage.getUserData();
    final userId = user?.id ?? '';

    await controller.purchasePlan(clientId: userId, plan: plan);

    // Note: Razorpay checkout will automatically open after createOrder() success
  }
}
