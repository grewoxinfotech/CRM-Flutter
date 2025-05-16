import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllUserService extends GetxService {
  final Uri url = Uri.parse(UrlRes.auth);

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List> fetchAllUsers() async {
    final response = await http.get(url, headers: await headers());
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data["success"] == true) {
      return data["data"] ?? [];
    } else {
      return [];
    }
  }

  // Optional helper method like in LabelService
  // UserModel? getUserById(List<UserModel> user, String userId) {
  //   return user.firstWhere(
  //     (user) => user.id == userId,
  //     orElse:
  //         () => UserModel(
  //           createdAt: DateTime.now(),
  //           updatedAt: DateTime.now(),
  //           currency: 'USD',
  //         ),
  //   );
  // }
}
