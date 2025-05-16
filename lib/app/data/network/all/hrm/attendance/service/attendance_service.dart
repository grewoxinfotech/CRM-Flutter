import 'package:crm_flutter/app/data/network/all/hrm/attendance/model/attendance_model.dart';
import 'package:get/get.dart';

class AttendanceService extends GetConnect {
  final String baseUrl = "https://api.raiser.in/api/v1/attendance";

  Future<List<AttendanceModel>> getAllAttendances() async {
    final response = await get(baseUrl);

    if (response.statusCode == 200) {
      final List data = response.body;
      return data.map((e) => AttendanceModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load attendance');
    }
  }

  Future<bool> punchIn(String employeeId) async {
    final response = await post('$baseUrl/punch-in', {
      'employee': employeeId,
      'startTime': DateTime.now().toIso8601String(),
    });
    return response.statusCode == 200;
  }

  Future<bool> punchOut(String id) async {
    final response = await post('$baseUrl/punch-out', {
      'id': id,
      'endTime': DateTime.now().toIso8601String(),
    });
    return response.statusCode == 200;
  }
}
