import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/subscription/subscription_payment_model.dart';

class SubscriptionVerifyService {
  final String baseUrl = UrlRes.subscriptionsPayment;

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Verify Razorpay payment
  Future<bool> verifyPayment(SubscriptionPayment payment) async {
    try {
      final url = Uri.parse(baseUrl);
      print("Url: ${url}");
      final response = await http.post(
        url,
        headers: await headers(),
        body: jsonEncode(payment.toJson()),
      );
      print(
        "reponse: ${response.body} || ${response.headers} || ${response.statusCode}",
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } on http.ClientException catch (e) {
      print("⚠️ ClientException: $e");
      return false;
    } on Exception catch (e) {
      print("⚠️ Verify payment exception: $e");
      return false;
    }
  }
}
