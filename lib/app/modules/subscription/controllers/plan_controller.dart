import 'package:crm_flutter/app/modules/super_admin/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../data/network/subscription/plan_model.dart';
import '../../../data/network/subscription/plan_service.dart';
import '../../../data/network/subscription/subscription_order_model.dart';
import '../../../data/network/subscription/subscription_order_service.dart';
import '../../../data/network/subscription/subscription_payment_model.dart';
import '../../../data/network/subscription/subscription_payment_service.dart';

class PlanController extends GetxController {
  final PlanService _service = PlanService();
  final SubscriptionOrderService _orderService = SubscriptionOrderService();
  final SubscriptionVerifyService _verifyService = SubscriptionVerifyService();
  late Razorpay _razorpay;

  final RxList<PlanData> plans = <PlanData>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isPurchasing = false.obs;
  final RxString error = ''.obs;
  final Rxn<RazorpayOrderResponse> orderResponse = Rxn<RazorpayOrderResponse>();
  RxMap<String, dynamic> orderPayload = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlans();

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  /// 📦 Fetch all subscription plans
  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _service.fetchPlans();
      plans.assignAll(response);

      if (plans.isEmpty) {
        error.value = 'No plans available';
      }
    } catch (e) {
      error.value = 'Failed to load plans: $e';
       ("Exception in fetchPlans: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPlans() async {
    await fetchPlans();
  }

  /// 💳 Purchase Plan → Calls createOrder API then opens Razorpay Checkout
  Future<void> purchasePlan({
    required String clientId,
    required PlanData plan,
    String? userEmail,
    String? userContact,
  }) async {
    try {
      isPurchasing.value = true;
      error.value = '';

      final int durationDays = _parseDurationToDays(plan.duration);

      final payload = {
        "client_id": clientId,
        "plan_id": plan.id,
        "start_date": DateTime.now().toIso8601String().split('T').first,
        "end_date":
            DateTime.now()
                .add(Duration(days: durationDays))
                .toIso8601String()
                .split('T')
                .first,
        "status": "active",
        "payment_status": "unpaid",
      };
      orderPayload.value = payload;

      final response = await _orderService.createOrder(payload);

      if (response != null && response.success == true) {
        orderResponse.value = response;
        _openRazorpayCheckout(response, userEmail, userContact);
      } else {
        Get.snackbar(
          "Error",
          "Failed to create order. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isPurchasing.value = false;
    }
  }

  /// 🧾 Open Razorpay Checkout
  void _openRazorpayCheckout(
    RazorpayOrderResponse response, [
    String? userEmail,
    String? userContact,
  ]) {
    final data = response.data;
    if (data == null) {
      Get.snackbar("Error", "Invalid order response.");
      return;
    }

    final options = {
      'key': data.keyId,
      'amount': (data.amount ?? 0) * 100, // Razorpay uses paise
      'name': data.planName ?? 'Subscription Plan',
      'order_id': data.orderId,
      'currency': data.currency ?? 'INR',
      'description': 'Purchase of ${data.planName ?? 'Plan'}',
      'prefill': {
        'contact': userContact ?? '9999999999',
        'email': userEmail ?? 'test@example.com',
      },
      'theme': {'color': '#3399cc'},
    };

     ("Opening Razorpay with options: $options");
    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Get.snackbar(
      "Payment Successful",
      "Payment ID: ${response.paymentId}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

     ("Payment Success: ${response.paymentId}");

    final order = orderResponse.value?.data;
    if (order == null) {
       ("No order data found for verification.");
      return;
    }

    // Build verification payload
    final payment = SubscriptionPayment(
      razorpayOrderId: response.orderId ?? '',
      razorpayPaymentId: response.paymentId ?? '',
      razorpaySignature: response.signature ?? '',
      clientId: orderPayload['client_id'] ?? '',
      planId: orderPayload['plan_id'] ?? '',
      startDate: orderPayload['start_date'] ?? '',
      endDate: orderPayload['end_date'] ?? '',
      status: "active",
      paymentStatus: "paid",
    );

    print('Payment Data: ${payment.toJson()}');

    // Verify with backend
    final verified = await _verifyService.verifyPayment(payment);

    if (verified) {
      Get.snackbar(
        "Verified",
        "Payment verified successfully. Logging out...",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );

      await Future.delayed(const Duration(seconds: 2));

      /// Perform logout
      final controller = Get.put(AuthController());
      controller.logout();
    } else {
      Get.snackbar(
        "Verification Failed",
        "Could not verify payment with server.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  /// ❌ Payment Error
  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      "Payment Failed",
      "Error: ${response.code} - ${response.message}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
     ("Payment Error: ${response.message}");
  }

  /// 💳 External Wallet Selected
  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      "External Wallet Selected",
      "Wallet: ${response.walletName}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
    );
  }

  /// ⏳ Parse plan duration (string) → days
  int _parseDurationToDays(String? duration) {
    if (duration == null || duration.isEmpty) return 30;

    final lower = duration.toLowerCase().trim();
    final numeric = int.tryParse(lower);
    if (numeric != null) return numeric;

    if (lower.contains('month')) {
      final months = int.tryParse(lower.split(' ').first) ?? 1;
      return months * 30;
    }
    if (lower.contains('year')) {
      final years = int.tryParse(lower.split(' ').first) ?? 1;
      return years * 365;
    }
    if (lower.contains('week')) {
      final weeks = int.tryParse(lower.split(' ').first) ?? 1;
      return weeks * 7;
    }

    return 30;
  }
}
