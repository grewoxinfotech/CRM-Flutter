class OtpVerifyResponse {
  final bool success;
  final String message;
  final OtpResponseData? data;

  OtpVerifyResponse({required this.success, required this.message, this.data});

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null ? OtpResponseData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class OtpResponseData {
  final String sessionToken;

  OtpResponseData({required this.sessionToken});

  factory OtpResponseData.fromJson(Map<String, dynamic> json) {
    return OtpResponseData(sessionToken: json['token'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'token': sessionToken};
  }
}
