// company_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../care/constants/url_res.dart';
import '../model/company_model.dart';

class CompanyService {
  // // Fetch all contacts
  // Future<List<ContactModel>> getAllContacts() async {
  //   try {
  //     final headers = await UrlRes.getHeaders();
  //     final response = await http.get(
  //       Uri.parse(UrlRes.contacts),
  //       headers: headers,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final body = json.decode(response.body);
  //       final List<dynamic> data = body['message']['data'] ?? [];
  //       return data.map((json) => ContactModel.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load contacts: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to fetch contacts: $e');
  //   }
  // }

  // Fetch all companies (without pagination)
  // Future<CompanyModel?> fetchCompanies() async {
  //   try {
  //     final headers = await UrlRes.getHeaders();
  //     final response = await http.get(
  //       Uri.parse(UrlRes.companies),
  //       headers: headers,
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final jsonResponse = json.decode(response.body);
  //       // final companyModel = CompanyModel.fromJson(jsonResponse);
  //
  //       // Return the list of companies directly
  //       return CompanyModel.fromJson(jsonResponse);
  //     } else {
  //       throw Exception('Failed to load companies: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load companies: $e');
  //   }
  // }
  Future<CompanyModel?> fetchCompanies({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(UrlRes.companies).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await UrlRes.getHeaders());

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        print("Companies Response: $jsonResponse");
        return CompanyModel.fromJson(jsonResponse);
      } else {
        print("Failed to load companies: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchCompanies: $e");
    }

    return null;
  }

  // Get company by ID
  Future<CompanyData?> getCompanyById(String id) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse("${UrlRes.companies}/$id"),
        headers: headers,
      );
      print("[DEBUG]=>:${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("[DEBUG]=>:${data}");
        // return CompanyModel.fromJson(data);
        return CompanyData.fromJson(data["data"]);
      }
      return null;
    } catch (e) {
      print('Error fetching company: $e');
      return null;
    }
  }
}
