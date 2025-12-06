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

  Future<LeadModel?> fetchLeads({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(url).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Leads: $data");
        return LeadModel.fromJson(data);
      } else {
        print("Failed to load leads: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetch leads: $e");
    }
    return null;
  }

  /// 2. Get a single lead by ID
  Future<LeadData?> getLeadById(String id) async {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return LeadData.fromJson(data);
    }
    return null;
  }

  /// 3. Create a new lead
  Future<bool> createLead(LeadData data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: jsonEncode(data),
    );


    return (response.statusCode == 200 || response.statusCode == 201);
  }

  /// 4. Update a lead by ID
  Future<http.Response> updateLead(String id, Map<String, dynamic> data) async {
    print("=> data =--------- $data");
    print("=> url =--------- $url/$id");
    final response = await http.put(
      Uri.parse("$url/$id"),
      headers: await headers(),
      body: jsonEncode(data),
    );

    return response;
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
