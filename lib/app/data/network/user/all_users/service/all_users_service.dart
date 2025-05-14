import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';

class AllUsersService {
  final String url = UrlRes.allUsers;

  Future<List<User>> getUsers() async {
    try {
      final token = await SecureStorage.getToken();
      final userData = await SecureStorage.getUserData();
      final isLoggedIn = await SecureStorage.getLoggedIn();

      if (!isLoggedIn || token == null || userData == null) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Authentication Error",
          message: "Please login to continue",
          contentType: ContentType.failure,
        );
        Get.offAllNamed('/login');
        return [];
      }

      print('Logged in user client_id: ${userData.clientId}');

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
          
          //pending filter role with start
          final filteredUsers = usersData.where((user) => 
            user['client_id'] == userData.id
          ).toList();
          //pending filter role with end

          return filteredUsers.map((json) => User.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to fetch users: $e",
        contentType: ContentType.failure,
      );
      return [];
    }
  }
}
