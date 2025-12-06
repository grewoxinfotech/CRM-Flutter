import 'dart:convert';
import 'package:crm_flutter/app/data/network/forget_password_api/model/otp_verify_model.dart';
import 'package:http/http.dart' as http;
import '../../../../care/constants/url_res.dart';
// import '../../../data/models/password_reset_response.dart';
import '../model/forget_password_model.dart';

class ForgetPasswordService {
  ForgetPasswordService._();

  static final ForgetPasswordService instance = ForgetPasswordService._();

  /// ✅ Get request headers (e.g., Content-Type, Authorization)
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// ✅ Send password reset request
  Future<PasswordResetResponse> forgetPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(UrlRes.forgetPassword),
        headers: await headers(),
        body: jsonEncode({"email": email}),
      );

      print("[FORGET PASSWORD RESPONSE] ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        return PasswordResetResponse.fromJson(jsonData);
      } else {
        return PasswordResetResponse(
          success: false,
          message: "No user found with this email ",
        );
      }
    } catch (e) {
      print("[FORGET PASSWORD ERROR] $e");
      return PasswordResetResponse(
        success: false,
        message: "Something went wrong. Please try again later.",
      );
    }
  }

  Future<OtpVerifyResponse> otpVerifyMethod(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(UrlRes.otpVerify),
        headers: await headers(),
        body: jsonEncode({"email": email, 'otp': otp}),
      );

      print("[VERIFY OTP PASSWORD RESPONSE] ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return OtpVerifyResponse.fromJson(jsonData);
      } else {
        return OtpVerifyResponse(
          success: false,
          message: "Failed to generate otp",
        );
      }
    } catch (e) {
      print("[VERIFY OTP PASSWORD ERROR] $e");
      return OtpVerifyResponse(
        success: false,
        message: "Something went wrong. Please try again later.",
      );
    }
  }

  Future<Map<String, dynamic>> resetPasswordMethod(
    String email,
    String confirmEmail,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(UrlRes.resetPassword),
        headers: await headers(),
        body: jsonEncode({
          "newPassword": email,
          'confirmPassword': confirmEmail,
        }),
      );

      print("[RESET PASSWORD RESPONSE] ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        return {};
      }
    } catch (e) {
      print("[RESET PASSWORD ERROR] $e");
      return {};
    }
  }
}
