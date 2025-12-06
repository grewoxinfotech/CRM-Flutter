import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/model/user_model.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/super_admin/auth/views/login/login_screen.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetConnect {
  final String url = UrlRes.login;
  final String i = UrlRes.contentType;
  final String j = UrlRes.applicationJson;

  Future<bool> login(String email, String password) async {
    final loginData = {"login": email, "password": password};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {i: j},
        body: jsonEncode(loginData),
      );

      final data = jsonDecode(response.body);
      print("User Data : $data");
      if (response.statusCode == 200 && data["success"] == true) {
        final token = data['data']['token'];
        final user = UserModel.fromJson(data['data']['user']);
        await SecureStorage.saveToken(token);
        await SecureStorage.saveUserData(user);
        await SecureStorage.saveRememberMe(true);
        await SecureStorage.saveLoggedIn(true);

        // Get.offAll(DashboardScreen());
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Login Failed",
          message: data["message"] ?? "Unknown error",
          contentType: ContentType.warning,
        );
      }
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Something went wrong: $e",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  Future<void> logout() async {
    await SecureStorage.clearAll();
    Get.offAll(LoginScreen());
  }



  static Future<UserModel> updateProfile(UserModel user) async {
    final updateUrl = '${UrlRes.baseURL}/clients/${user.id}';
    final header = await UrlRes.getHeaders();

    // 🔹 Create multipart request
    var request = http.MultipartRequest('PUT', Uri.parse(updateUrl));

    // 🔹 Add headers
    request.headers.addAll(header);

    request.fields.addAll({
      'firstName': user.firstName ?? '',
      'lastName': user.lastName ?? '',
      'username': user.username ?? '',
      'email': user.email ?? '',
      'phone': user.phone ?? '',
      'address': user.address ?? '',
      'city': user.city ?? '',
      'state': user.state ?? '',
      'country': user.country ?? '',
      'zipcode': user.zipcode ?? '',
      'currency': user.currency ?? '',
      'gstIn': user.gstIn ?? '',
      'bankname': user.bankName ?? '',
      'accounttype': user.accountType ?? '',
      'accountholder': user.accountHolder ?? '',
      // 'accountnumber': user.accountNumber.toString() ?? '',
      'ifsc': user.ifsc ?? '',
      'banklocation': user.bankLocation ?? '',
      'updatedAt': DateTime.now().toIso8601String(),
    });

    if (user.accountNumber != null) {
      request.fields['accountnumber'] = user.accountNumber.toString();
    }



    // 🔹 Send request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data["data"]);
    } else {
      throw Exception("Failed to update profile: ${response.body}");
    }
  }
}
