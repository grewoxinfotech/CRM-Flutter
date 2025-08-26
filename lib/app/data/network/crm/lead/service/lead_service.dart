// import 'dart:convert';
//
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:crm_flutter/app/care/constants/url_res.dart';
// import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
// import 'package:http/http.dart' as http;
//
// class LeadService {
//   final String url = UrlRes.leads;
//
//   static Future<Map<String, String>> headers() async {
//     return await UrlRes.getHeaders();
//   }
//
//   /// 1. Get all leads
//   Future<List> getLeads() async {
//     final response = await http.get(Uri.parse(url), headers: await headers());
//     final data = jsonDecode(response.body);
//     if (response.statusCode == 200 && data["success"] == true) {
//       if (data["message"] != null && data["message"]["data"] != null) {
//         return data["message"]["data"] ?? [];
//       }
//
//       // Fallback to old structure
//       return data["data"] ?? [];
//     } else {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: "Error",
//         message:
//             data["message"] is String
//                 ? data["message"]
//                 : "Failed to fetch leads",
//         contentType: ContentType.failure,
//       );
//       return [];
//     }
//   }
//
//   /// 2. Get lead by ID
//   Future<Map<String, dynamic>?> getLeadById(String id) async {
//     final response = await http.get(
//       Uri.parse("$url/$id"),
//       headers: await headers(),
//     );
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       // Check if data is in the new structure
//       if (data["message"] != null && data["message"]["data"] != null) {
//         return data["message"]["data"];
//       }
//       return data['data'];
//     } else {
//       return null;
//     }
//   }
//
//   /// 3. Create Lead
//   Future<http.Response> createLead(Map<String, dynamic> data) async {
//     return await http.post(
//       Uri.parse(url),
//       headers: await headers(),
//       body: jsonEncode(data),
//     );
//   }
//
//   /// 4. Update Lead by ID
//   Future<http.Response> updateLead(String id, Map<String, dynamic> data) async {
//     return await http.put(
//       Uri.parse("$url/$id"),
//       headers: await headers(),
//       body: jsonEncode(data),
//     );
//   }
//
//   /// 5. Delete Lead by ID
//   Future<bool> deleteLead(String id) async {
//     final response = await http.delete(
//       Uri.parse("$url/$id"),
//       headers: await headers(),
//     );
//     final data = jsonDecode(response.body);
//     CrmSnackBar.showAwesomeSnackbar(
//       title: "Message",
//       message:
//           data['message'] is String ? data['message'] : "Operation completed",
//       contentType: ContentType.success,
//     );
//     return data['success'];
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';

import '../model/lead_model.dart';

class LeadService {
  final String url = UrlRes.leads;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all leads
  Future<List<LeadModel>> getLeads() async {
    final response = await http.get(Uri.parse(url), headers: await headers());
    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 && decoded["success"] == true) {
      final rawList = decoded["data"] ?? decoded["message"]?["data"];

      if (rawList != null && rawList is List) {
        return rawList
            .map<LeadModel>((json) => LeadModel.fromJson(json))
            .toList();
      }
    }

    CrmSnackBar.showAwesomeSnackbar(
      title: "Error",
      message:
          decoded["message"] is String
              ? decoded["message"]
              : "Failed to fetch leads",
      contentType: ContentType.failure,
    );
    return [];
  }

  /// 2. Get a single lead by ID
  Future<LeadModel?> getLeadById(String id) async {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LeadModel.fromJson(data);
    }
    return null;
  }

  /// 3. Create a new lead
  Future<bool> createLead(LeadModel data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: jsonEncode(data),
    );

    print("[DEBUG]=> response =--------- ${response.body}");
    return (response.statusCode == 200 || response.statusCode == 201);

    // return await http.post(
    //   Uri.parse(url),
    //   headers: await headers(),
    //   body: jsonEncode(data),
    // );
  }

  /// 4. Update a lead by ID
  Future<http.Response> updateLead(String id, Map<String, dynamic> data) async {
    return await http.put(
      Uri.parse("$url/$id"),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// 5. Delete a lead by ID
  Future<bool> deleteLead(String id) async {
    final response = await http.delete(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );

    final data = jsonDecode(response.body);
    CrmSnackBar.showAwesomeSnackbar(
      title: "Message",
      message:
          data['message'] is String ? data['message'] : "Operation completed",
      contentType: ContentType.success,
    );

    return data['success'] == true;
  }
}
