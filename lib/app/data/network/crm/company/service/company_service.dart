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
  Future<List<Data>> getAllCompanies() async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse(UrlRes.companies),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final companyModel = CompanyModel.fromJson(jsonResponse);

        // Return the list of companies directly
        return companyModel.message?.data ?? [];
      } else {
        throw Exception('Failed to load companies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load companies: $e');
    }
  }

  // Get company by ID
  Future<Data?> getCompanyById(String id) async {
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
        return Data.fromJson(data["data"]);
      }
      return null;
    } catch (e) {
      print('Error fetching company: $e');
      return null;
    }
  }
}
