import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/models/task_model.dart';
import 'package:crm_flutter/app/data/service/secure_storage_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';

class TaskService extends GetConnect {
  final String _url = UrlRes.task;
  final context = Get.context!;

  Future<List<TaskModel>> fetchTasks(String id) async {
    try {
      final token = await SecureStorage.getToken();
      if (token == null) {
        throw Exception('No token found. Please log in again.');
      }

      final response = await get(
        "${_url}${id} ",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
        final data = response.body['data'];
        if (data is List) {
          return data.map((e) => TaskModel.fromJson(e)).toList();
        } else {
          throw Exception("Unexpected response format: 'data' is not a list.");
        }
      } else {
        throw Exception(
          "Failed to fetch tasks. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching tasks: $e");
      rethrow; // maintain original error for better debug trace
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      String? token = await SecureStorage.getToken();
      if (token == null)
        throw Exception("No token found. Please log in again.");

      final response = await delete(
        "$_url/$id",
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 && response.body is Map<String, dynamic>) {
        return response.body["success"] == true;
      } else {
        print("Delete failed: ${response.statusText}");
        CrmSnackBar.showAwesomeSnackbar(
          title: "Delete Failed",
          message: "${response.body["message"]}",
          contentType: ContentType.warning,
          color: ColorRes.error,
        );
        return false;
      }
    } catch (e) {
      print("Error deleting task: $e");
      return false;
    }
  }
}

