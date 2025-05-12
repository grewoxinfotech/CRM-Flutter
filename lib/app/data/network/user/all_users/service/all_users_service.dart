import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:http/http.dart' as http;

class AllUsersService {
  final String url = UrlRes.allUsers;

  Future<List<User>> getUsers() async {
    try {
      final token = await SecureStorage.getToken();
      final userData = await SecureStorage.getUserData();

      if (token == null || userData == null) {
        throw Exception('Authentication required');
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['data'] != null) {
          final List<dynamic> usersData = responseData['data'];
          //print('Users Data: $usersData');
          return usersData.map((json) => User.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
