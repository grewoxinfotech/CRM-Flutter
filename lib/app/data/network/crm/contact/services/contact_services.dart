import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/data/network/crm/contact/medel/contact_medel.dart';
import '../../../../../care/constants/url_res.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class ContactService {
  // Fetch all contacts
  Future<List<ContactModel>> getAllContacts() async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse(UrlRes.contacts),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List<dynamic> data = body['message']['data'];

        return data.map((json) => ContactModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load contacts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch contacts: $e');
    }
  }

  // Get contact by ID
  Future<ContactModel?> getContactById(String id) async {
    final headers = await UrlRes.getHeaders();
    final response = await http.get(
      Uri.parse("${UrlRes.contacts}/$id"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ContactModel.fromJson(data['data']);
    }
    return null;
  }

  Future<ContactModel?> addContact(ContactModel contact) async {
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
        return ContactModel.fromJson(contactData);
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

  // Update contact
  Future<bool> updateContact(String id, ContactModel contact) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.put(
        Uri.parse("${UrlRes.contacts}/$id"),
        headers: headers,
        //body: json.encode(contact.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to update contact: $e');
    }
  }

  // Delete contact
  Future<bool> deleteContact(String id) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.delete(
        Uri.parse("${UrlRes.contacts}/$id"),
        headers: headers,
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to delete contact: $e');
    }
  }
}
