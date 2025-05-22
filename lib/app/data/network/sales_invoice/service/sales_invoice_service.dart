import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import '../model/sales_invoice_model.dart';

class SalesInvoiceService {
  final String url = UrlRes.salesInvoices;

  Future<Map<String, String>> get headers async => await UrlRes.getHeaders();

  Future<List<SalesInvoice>> getSalesInvoices() async {
    try {
      final response = await http.get(Uri.parse(url), headers: await headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return (data['data'] as List)
              .map((json) => SalesInvoice.fromJson(json))
              .toList();
        }
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch sales invoices: $e');
    }
  }

  Future<SalesInvoice?> getSalesInvoiceById(String id) async {
    try {
      print('Fetching invoice with ID: $id');
      final response = await http.get(
        Uri.parse('$url/$id'),
        headers: await headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true && data['data'] != null) {
          final invoice = SalesInvoice.fromJson(data['data']);
          return invoice;
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch sales invoice: $e');
    }
  }

  Future<List<SalesInvoice>> getSalesInvoicesByDealId(String dealId) async {
    try {
      print('Making API request for related_id: $dealId');
      final response = await http.get(
        Uri.parse(url),  // Get all invoices
        headers: await headers
      );
      print('API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          final allInvoices = (data['data'] as List)
              .map((json) => SalesInvoice.fromJson(json))
              .toList();
          
          // Filter by related_id
          final filteredInvoices = allInvoices
              .where((invoice) => invoice.relatedId == dealId)
              .toList();
          
          print('Total invoices: ${allInvoices.length}');
          print('Filtered invoices for related_id $dealId: ${filteredInvoices.length}');
          print('Related IDs in response: ${allInvoices.map((i) => i.relatedId).toSet().join(', ')}');
          
          return filteredInvoices;
        }
      }
      print('No invoices found or invalid response');
      return [];
    } catch (e) {
      print('Error in getSalesInvoicesByDealId: $e');
      throw Exception('Failed to fetch sales invoices for deal: $e');
    }
  }

  Future<bool> deleteSalesInvoice(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/$id'),
        headers: await headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to delete sales invoice: $e');
    }
  }

  Future<Map<String, dynamic>?> updateSalesInvoice(String id, Map<String, dynamic> data) async {
    try {
      print('Updating invoice with ID: $id');
      print('Update payload: ${json.encode(data)}');
      
      // Get headers and add content-type
      final requestHeaders = await headers;
      requestHeaders['Content-Type'] = 'application/json';

      // Send the complete payload without modification
      final response = await http.put(
        Uri.parse('$url/$id'),
        headers: requestHeaders,
        body: json.encode(data),
      );
      
      print('Update response status: ${response.statusCode}');
      print('Update response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          print('Successfully updated invoice');
          return responseData;
        } else {
          print('API returned success: false - ${responseData['message'] ?? 'No error message'}');
          return null;
        }
      } else {
        print('Failed to update invoice. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error updating sales invoice: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to update sales invoice: $e');
    }
  }

  Future<Map<String, dynamic>?> createSalesInvoice(String dealId, Map<String, dynamic> data) async {
    try {
      print('Creating invoice for deal ID: $dealId');
      print('Create payload: ${json.encode(data)}');
      
      // Get headers and add content-type
      final requestHeaders = await headers;
      requestHeaders['Content-Type'] = 'application/json';

      // Send the request to create invoice
      final response = await http.post(
        Uri.parse('$url/$dealId'),
        headers: requestHeaders,
        body: json.encode(data),
      );
      
      print('Create response status: ${response.statusCode}');
      print('Create response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          print('Successfully created invoice');
          return responseData;
        } else {
          print('API returned success: false - ${responseData['message'] ?? 'No error message'}');
          return null;
        }
      } else {
        print('Failed to create invoice. Status code: ${response.statusCode}');
        print('Error response: ${response.body}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error creating sales invoice: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to create sales invoice: $e');
    }
  }
}
 