import 'dart:convert';
import 'package:crm_flutter/app/data/network/subscription/subscription_order_model.dart';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'plan_model.dart';

class SubscriptionOrderService {
  final String baseUrl = UrlRes.subscriptionsOrder;

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Create a Razorpay order
  Future<RazorpayOrderResponse?> createOrder(Map<String, dynamic> body) async {
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.post(
        url,
        headers: await headers(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return RazorpayOrderResponse.fromJson(data);
      } else {
        print("Failed to create Razorpay order: ${response.body}");
        return null;
      }
    } on http.ClientException catch (e) {
      print("ClientException: $e");
      return null;
    } on Exception catch (e) {
      print("Create order exception: $e");
      return null;
    }
  }
}
