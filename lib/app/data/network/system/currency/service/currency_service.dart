import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import '../model/currency_model.dart';

class CurrencyService {
  Future<List<CurrencyModel>> getCurrencies() async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse(UrlRes.currencies),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Currency API Response: ${response.statusCode}'); // Debug status
        print('Response Body: ${response.body}');
        if (responseData['success'] == true) {
          List<dynamic> currencyList = [];

          // Handle different response structures
          if (responseData['data'] != null) {
            // Direct data format
            currencyList = responseData['data'];
            print('currency:-- $currencyList');
          } else if (responseData['message'] != null &&
              responseData['message'] is Map &&
              responseData['message']['data'] != null) {
            // If data is nested under message
            currencyList = responseData['message']['data'];
          }

          return currencyList
              .map((json) => CurrencyModel.fromJson(json))
              .toList();
        } else {
          throw Exception(
            'Failed to load currencies: ${responseData['message']}',
          );
        }
      } else {
        throw Exception('Failed to load currencies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load currencies: $e');
    }
  }
}
