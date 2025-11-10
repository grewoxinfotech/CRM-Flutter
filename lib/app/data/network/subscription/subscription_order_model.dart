class RazorpayOrderResponse {
  final bool? success;
  final String? message;
  final RazorpayOrderData? data;

  RazorpayOrderResponse({this.success, this.message, this.data});

  factory RazorpayOrderResponse.fromJson(Map<String, dynamic> json) {
    return RazorpayOrderResponse(
      success: json['success'],
      message: json['message'],
      data:
          json['data'] != null
              ? RazorpayOrderData.fromJson(json['data'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    final dataMap = <String, dynamic>{};
    if (success != null) dataMap['success'] = success;
    if (message != null) dataMap['message'] = message;
    if (data != null) dataMap['data'] = data!.toJson();
    return dataMap;
  }
}

class RazorpayOrderData {
  final String? orderId;
  final int? amount;
  final String? currency;
  final String? keyId;
  final String? planName;

  RazorpayOrderData({
    this.orderId,
    this.amount,
    this.currency,
    this.keyId,
    this.planName,
  });

  factory RazorpayOrderData.fromJson(Map<String, dynamic> json) {
    return RazorpayOrderData(
      orderId: json['orderId'],
      amount: json['amount'],
      currency: json['currency'],
      keyId: json['keyId'],
      planName: json['planName'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (orderId != null) data['orderId'] = orderId;
    if (amount != null) data['amount'] = amount;
    if (currency != null) data['currency'] = currency;
    if (keyId != null) data['keyId'] = keyId;
    if (planName != null) data['planName'] = planName;
    return data;
  }
}
