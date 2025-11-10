class SubscriptionPayment {
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;
  final String clientId;
  final String planId;
  final String startDate;
  final String endDate;
  final String status;
  final String paymentStatus;

  SubscriptionPayment({
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
    required this.clientId,
    required this.planId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.paymentStatus,
  });

  factory SubscriptionPayment.fromJson(Map<String, dynamic> json) {
    return SubscriptionPayment(
      razorpayOrderId: json['razorpay_order_id'] ?? '',
      razorpayPaymentId: json['razorpay_payment_id'] ?? '',
      razorpaySignature: json['razorpay_signature'] ?? '',
      clientId: json['client_id'] ?? '',
      planId: json['plan_id'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'razorpay_order_id': razorpayOrderId,
      'razorpay_payment_id': razorpayPaymentId,
      'razorpay_signature': razorpaySignature,
      'client_id': clientId,
      'plan_id': planId,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
      'payment_status': paymentStatus,
    };
  }
}
