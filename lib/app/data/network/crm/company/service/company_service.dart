import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../care/constants/url_res.dart';
import '../model/company_model.dart';

class CompanyService {
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
      print("=>:${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("=>:${data}");
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
