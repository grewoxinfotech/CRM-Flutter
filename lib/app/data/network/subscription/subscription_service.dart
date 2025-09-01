import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;

import '../../../widgets/common/messages/crm_snack_bar.dart';
import 'subscription_model.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';

class SubscriptionService {
  final String baseUrl = UrlRes.subscriptionsAssign; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch subscriptions with optional pagination & search
  Future<List<SubscriptionData>> fetchSubscriptions({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );
      print("URI: $uri");
      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> subscriptions = data["data"];
        print("Subscriptions: $subscriptions");
        return subscriptions.map((json) => SubscriptionData.fromJson(json)).toList();
      } else {
        print("Failed to load subscriptions: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchSubscriptions: $e");
    }
    return [];
  }

  /// Get single subscription by ID
  Future<SubscriptionData?> getSubscriptionById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Data: $data");
        return SubscriptionData.fromJson(data["data"]);
      }
    } catch (e) {
      print("Get subscription by ID exception: $e");
    }
    return null;
  }

  /// Create new subscription
  Future<bool> createSubscription(SubscriptionData subscription) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(subscription.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Subscription created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create subscription",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create subscription exception: $e");
      return false;
    }
  }

  /// Update subscription
  Future<bool> updateSubscription(String id, SubscriptionData subscription) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(subscription.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Subscription updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update subscription",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update subscription exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the subscription",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete subscription
  Future<bool> deleteSubscription(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete subscription exception: $e");
      return false;
    }
  }
}
