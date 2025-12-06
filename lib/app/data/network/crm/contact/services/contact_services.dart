import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../medel/contact_medel.dart';

class ContactService {
  final String baseUrl = UrlRes.contacts; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch contacts with optional pagination & search
  Future<ContactModel?> fetchContacts({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> contacts = data["message"]["data"];
        return ContactModel.fromJson(data);
      } else {
        print("Failed to load contacts: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchContacts: $e");
    }
    return null;
  }

  /// Get single contact by ID
  Future<ContactData?> getContactById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ContactData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get contact by ID exception: $e");
    }
    return null;
  }

  Future<ContactData?> addContact(ContactData contact) async {
    try {
      final headers = await UrlRes.getHeaders();

      final response = await http.post(
        Uri.parse(UrlRes.contacts),
        headers: headers,
        body: jsonEncode(contact.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final contactData = responseData["data"];
        return ContactData.fromJson(contactData);
      } else {
        print('[ERROR]----------${response.body}');
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error (${response.statusCode})",
          message: "Failed to create contact: ${response.body}",
          contentType: ContentType.failure,
        );
        throw Exception("Failed to create contact: ${response.body}");
      }
    } catch (e) {
      print('error: $e');

      throw e;
    }
  }

  /// Update contact
  Future<bool> updateContact(String id, ContactData contact) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(contact.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Contact updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update contact",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update contact exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the contact",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete contact
  Future<bool> deleteContact(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete contact exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while deleting the contact",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
