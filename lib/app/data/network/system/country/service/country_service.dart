import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import '../model/country_model.dart';

class CountryService {
  Future<List<CountryModel>> getCountries() async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse(UrlRes.countries), // 🔹 Make sure this endpoint exists in UrlRes
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print('Country API Response: ${response.statusCode}'); // Debug status
        // print('Response Body: ${response.body}');
        if (responseData['success'] == true) {
          List<dynamic> countryList = [];

          // Handle different response structures
          if (responseData['data'] != null) {
            // Direct data format
            countryList = responseData['data'];
            print('countries:-- $countryList');
          } else if (responseData['message'] != null &&
              responseData['message'] is Map &&
              responseData['message']['data'] != null) {
            // If data is nested under message
            countryList = responseData['message']['data'];
          }

          return countryList
              .map((json) => CountryModel.fromJson(json))
              .toList();
        } else {
          throw Exception(
            'Failed to load countries: ${responseData['message']}',
          );
        }
      } else {
        throw Exception('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }
}
