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

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          List<dynamic> usersData = [];

          // Handle different response structures
          if (responseData['data'] != null) {
            usersData = responseData['data'];
          } else if (responseData['message'] != null &&
              responseData['message'] is Map &&
              responseData['message']['data'] != null) {
            usersData = responseData['message']['data'];
          } else {
            return [];
          }

          // Convert all users to User objects first
          final allUsers =
              usersData.map((json) => User.fromJson(json)).toList();

          // If userData.clientId is null, return all users
          if (userData.clientId == null) {
            return allUsers;
          }

          // Filter users by client_id if needed
          return allUsers
              .where(
                (user) =>
                    user.clientId == userData.clientId ||
                    user.clientId == userData.id ||
                    user.id == userData.clientId,
              )
              .toList();
        } else {
          String errorMessage =
              responseData['message'] is String
                  ? responseData['message']
                  : 'Failed to load users';

          CrmSnackBar.showAwesomeSnackbar(
            title: "Error",
            message: errorMessage,
            contentType: ContentType.failure,
          );
          return [];
        }
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to load users: ${response.statusCode}",
          contentType: ContentType.failure,
        );
        return [];
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to fetch users: $e",
        contentType: ContentType.failure,
      );
      print("Error fetching users: $e");
      return [];
    }
  }
}
