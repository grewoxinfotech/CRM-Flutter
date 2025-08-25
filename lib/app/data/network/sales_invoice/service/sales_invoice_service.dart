import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/sales_invoice/model/sales_invoice_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:http/http.dart' as http;

class SalesInvoiceService {
  final String url = UrlRes.salesInvoices;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Get all sales invoices with optional pagination & search
  Future<List<SalesInvoice>> fetchSalesInvoices({
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

        List<dynamic>? invoicesList;

        if (data["data"] != null && data["data"] is List) {
          // Direct list format
          invoicesList = data["data"];
        } else if (data["message"] != null &&
            data["message"] is Map &&
            data["message"]["data"] != null &&
            data["message"]["data"] is List) {
          // Nested list under message
          invoicesList = data["message"]["data"];
        }

        if (invoicesList != null) {
          return invoicesList
              .map((json) => SalesInvoice.fromJson(json))
              .toList();
        }
      }
    } catch (e) {
      print("fetchSalesInvoices Exception: $e");
    }
    return [];
  }

  /// Get a single invoice by ID
  Future<SalesInvoice?> getSalesInvoiceById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$url/$id"),
        headers: await headers(),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data["success"] == true) {
        // Check different response structures
        Map<String, dynamic>? invoiceData;

        if (data["data"] != null) {
          // Direct data format
          invoiceData = data["data"];
        } else if (data["message"] != null &&
            data["message"] is Map &&
            data["message"]["data"] != null) {
          // If data is nested under message
          invoiceData = data["message"]["data"];
        }

        if (invoiceData != null) {
          return SalesInvoice.fromJson(invoiceData);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get invoices for a specific deal
  Future<List<SalesInvoice>> getSalesInvoicesByDealId(String dealId) async {
    try {
      final response = await http.get(Uri.parse(url), headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          // Check different response structures
          List<dynamic>? invoicesData;

          if (data["data"] != null) {
            // Direct data format
            invoicesData = data["data"];
          } else if (data["message"] != null &&
              data["message"] is Map &&
              data["message"]["data"] != null) {
            // If data is nested under message
            invoicesData = data["message"]["data"];
          }

          if (invoicesData != null && invoicesData.isNotEmpty) {
            // Convert all invoices to models
            final allInvoices =
                invoicesData
                    .map((invoice) => SalesInvoice.fromJson(invoice))
                    .toList();

            // Filter by deal ID
            final filteredInvoices =
                allInvoices
                    .where((invoice) => invoice.relatedId == dealId)
                    .toList();

            return filteredInvoices;
          }
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Update an existing invoice
  Future<bool> updateSalesInvoice(String id, Map<String, dynamic> data) async {
    try {
      print("[DEBUG]=>data ---- ${data}");
      final response = await http.put(
        Uri.parse("$url/$id"),
        headers: await headers(),
        body: json.encode(data),
      );
      print("[DEBUG]=>response ---- ${response.body}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          return true;
        } else {
          CrmSnackBar.showAwesomeSnackbar(
            title: "Error",
            message:
                responseData['message'] is String
                    ? responseData['message']
                    : 'Failed to update invoice',
            contentType: ContentType.failure,
          );
          return false;
        }
      } else {
        // CrmSnackBar.showAwesomeSnackbar(
        //   title: "Error",
        //   message: "Failed to update invoice. Status: ${response.statusCode}",
        //   contentType: ContentType.failure,
        // );
        return false;
      }
    } catch (e) {
      // CrmSnackBar.showAwesomeSnackbar(
      //   title: "Error",
      //   message: "Error updating invoice: ${e.toString()}",
      //   contentType: ContentType.failure,
      // );
      return false;
    }
  }

  /// Create a new invoice
  Future<bool> createSalesInvoice(SalesInvoice data, String dealId) async {
    print("[DEBUG]=>$data");

    try {
      final response = await http.post(
        Uri.parse(url + "/$dealId"),
        headers: await headers(),
        body: json.encode(data),
      );
      print("[DEBUG]=>$data");
      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          return true;
        } else {
          CrmSnackBar.showAwesomeSnackbar(
            title: "Error",
            message:
                responseData['message'] is String
                    ? responseData['message']
                    : 'Failed to create invoice',
            contentType: ContentType.failure,
          );
          return false;
        }
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to create invoice. Status: ${response.statusCode}",
          contentType: ContentType.failure,
        );
        print("[DEBUG]=>${response.body.toString()}");

        return false;
      }
    } catch (e) {
      print("[DEBUG]=>${e.toString()}");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Error creating invoice: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete an invoice by ID
  Future<bool> deleteSalesInvoice(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$url/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        final responseData = jsonDecode(response.body);

        if (responseData["success"] == true) {
          CrmSnackBar.showAwesomeSnackbar(
            title: "Success",
            message: "Invoice deleted successfully",
            contentType: ContentType.success,
          );
          return true;
        } else {
          CrmSnackBar.showAwesomeSnackbar(
            title: "Error",
            message:
                responseData['message'] is String
                    ? responseData['message']
                    : 'Failed to delete invoice',
            contentType: ContentType.failure,
          );
          return false;
        }
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to delete invoice. Status: ${response.statusCode}",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Error deleting invoice: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
