class PasswordResetResponse {
  final bool success;
  final String message;
  final PasswordResetData? data;

  PasswordResetResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory PasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data:
          json['data'] != null
              ? PasswordResetData.fromJson(json['data'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class PasswordResetData {
  final String sessionToken;

  PasswordResetData({required this.sessionToken});

  factory PasswordResetData.fromJson(Map<String, dynamic> json) {
    return PasswordResetData(sessionToken: json['sessionToken'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'sessionToken': sessionToken};
  }
}
