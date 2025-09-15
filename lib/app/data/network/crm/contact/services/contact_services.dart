// import 'dart:convert';
//
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:http/http.dart' as http;
// import 'package:crm_flutter/app/data/network/crm/contact/medel/contact_medel.dart';
// import '../../../../../care/constants/url_res.dart';
// import '../../../../../widgets/common/messages/crm_snack_bar.dart';
//
// class ContactService {
//   // Fetch all contacts
//   Future<List<ContactModel>> getAllContacts() async {
//     try {
//       final headers = await UrlRes.getHeaders();
//       final response = await http.get(
//         Uri.parse(UrlRes.contacts),
//         headers: headers,
//       );
//
//       if (response.statusCode == 200) {
//         final body = json.decode(response.body);
//         final List<dynamic> data = body['message']['data'];
//
//         return data.map((json) => ContactModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load contacts: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch contacts: $e');
//     }
//   }
//
//   // Get contact by ID
//   Future<ContactModel?> getContactById(String id) async {
//     final headers = await UrlRes.getHeaders();
//     final response = await http.get(
//       Uri.parse("${UrlRes.contacts}/$id"),
//       headers: headers,
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return ContactModel.fromJson(data['data']);
//     }
//     return null;
//   }
//
//   Future<ContactModel?> addContact(ContactModel contact) async {
//     try {
//       final headers = await UrlRes.getHeaders();
//
//       final response = await http.post(
//         Uri.parse(UrlRes.contacts),
//         headers: headers,
//         body: jsonEncode(contact.toJson()),
//       );
//
//       if (response.statusCode == 201 || response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         final contactData = responseData["data"];
//         return ContactModel.fromJson(contactData);
//       } else {
//         print('[ERROR]----------${response.body}');
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Error (${response.statusCode})",
//           message: "Failed to create contact: ${response.body}",
//           contentType: ContentType.failure,
//         );
//         throw Exception("Failed to create contact: ${response.body}");
//       }
//     } catch (e) {
//       print('error: $e');
//
//       throw e;
//     }
//   }
//
//   // Update contact
//   Future<bool> updateContact(String id, ContactModel contact) async {
//     try {
//       final headers = await UrlRes.getHeaders();
//       final response = await http.put(
//         Uri.parse("${UrlRes.contacts}/$id"),
//         headers: headers,
//         body: json.encode(contact.toJson()),
//       );
//       print("[DEBUG] => ${response.body}");
//       return response.statusCode == 200 || response.statusCode == 201;
//     } catch (e) {
//       throw Exception('Failed to update contact: $e');
//     }
//   }
//
//   // Delete contact
//   Future<bool> deleteContact(String id) async {
//     try {
//       final headers = await UrlRes.getHeaders();
//       final response = await http.delete(
//         Uri.parse("${UrlRes.contacts}/$id"),
//         headers: headers,
//       );
//
//       return response.statusCode == 200;
//     } catch (e) {
//       throw Exception('Failed to delete contact: $e');
//     }
//   }
// }

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

  /// Create contact
  // Future<bool> createContact(ContactModel contact) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(baseUrl),
  //       headers: await headers(),
  //       body: jsonEncode(contact.toJson()),
  //     );
  //
  //     final responseData = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: "Success",
  //         message: responseData["message"] ?? "Contact created successfully",
  //         contentType: ContentType.success,
  //       );
  //       return true;
  //     } else {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: "Error",
  //         message: responseData["message"] ?? "Failed to create contact",
  //         contentType: ContentType.failure,
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Create contact exception: $e");
  //     CrmSnackBar.showAwesomeSnackbar(
  //       title: "Exception",
  //       message: "Something went wrong while creating the contact",
  //       contentType: ContentType.failure,
  //     );
  //     return false;
  //   }
  // }

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
