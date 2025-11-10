import 'package:get/get.dart';
import '../../../data/network/subscription/subscription_order_model.dart';
import '../../../data/network/subscription/subscription_order_service.dart';

class SubscriptionOrderController extends GetxController {
  final SubscriptionOrderService _orderService = SubscriptionOrderService();

  /// Observables
  var isLoading = false.obs;
  var orderResponse = Rxn<RazorpayOrderResponse>();

  /// Create a Razorpay order
  Future<void> createOrder({
    required String clientId,
    required String planId,
    required String startDate,
    required String endDate,
  }) async {
    isLoading.value = true;

    final payload = {
      "client_id": clientId,
      "plan_id": planId,
      "start_date": startDate,
      "end_date": endDate,
      "status": "active",
      "payment_status": "unpaid",
    };

    try {
      final response = await _orderService.createOrder(payload);

      if (response != null && response.success == true) {
        orderResponse.value = response;
        Get.snackbar(
          "Success",
          "Razorpay order created successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to create Razorpay order. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
