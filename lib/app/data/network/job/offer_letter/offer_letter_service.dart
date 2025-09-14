import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;


import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'offer_letter_model.dart';

class OfferLetterService {
  final String baseUrl = UrlRes.offerLetters; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch offer letters with optional pagination & search
  Future<OfferLetterModel?> fetchOfferLetters({
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
        print("Offer Letters: $data");
        return OfferLetterModel.fromJson(data);
      } else {
        print("Failed to load offer letters: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchOfferLetters: $e");
    }
    return null;
  }

  /// Get single offer letter by ID
  Future<OfferLetterData?> getOfferLetterById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return OfferLetterData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get offer letter by ID exception: $e");
    }
    return null;
  }

  /// Create new offer letter
  // Future<bool> createOfferLetter(OfferLetterData offerLetter,File file) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(baseUrl),
  //       headers: await headers(),
  //       body: jsonEncode(offerLetter.toJson()),
  //     );
  //
  //     final responseData = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: "Success",
  //         message:
  //         responseData["message"] ?? "Offer letter created successfully",
  //         contentType: ContentType.success,
  //       );
  //       return true;
  //     } else {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: "Error",
  //         message: responseData["message"] ?? "Failed to create offer letter",
  //         contentType: ContentType.failure,
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Create offer letter exception: $e");
  //     return false;
  //   }
  // }

  Future<bool> createOfferLetter(OfferLetterData offerLetter, File? file) async {
    try {
      final uri = Uri.parse(baseUrl);
      final request = http.MultipartRequest("POST", uri);

      // Add headers (remove Content-Type so multipart can handle it)
      request.headers.addAll(await headers());

      // Add file only if provided
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath("file", file.path),
        );
      }

      // Add form fields (convert model to map but remove nulls)
      final Map<String, dynamic> fields = offerLetter.toJson()
        ..removeWhere((key, value) => value == null);

      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Send
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Offer letter created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create offer letter",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create offer letter exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while creating offer letter",
        contentType: ContentType.failure,
      );
      return false;
    }
  }


  /// Update existing offer letter
  Future<bool> updateOfferLetter(String id, OfferLetterData offerLetter, File? file) async {
    try {
      final uri = Uri.parse("$baseUrl/$id");

      http.BaseRequest request;

      if (file != null) {
        // ✅ Multipart request if file is present
        final multipartRequest = http.MultipartRequest("PUT", uri);

        // Add headers
        multipartRequest.headers.addAll(await headers());

        // Add file
        multipartRequest.files.add(
          await http.MultipartFile.fromPath("file", file.path),
        );

        // Add form fields
        final Map<String, dynamic> fields = offerLetter.toJson()
          ..removeWhere((key, value) => value == null);

        fields.forEach((key, value) {
          multipartRequest.fields[key] = value.toString();
        });

        request = multipartRequest;
      } else {
        // ✅ Simple JSON PUT if no file
        request = http.Request("PUT", uri)
          ..headers.addAll(await headers())
          ..body = jsonEncode(offerLetter.toJson());
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Offer letter updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update offer letter",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update offer letter exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the offer letter",
        contentType: ContentType.failure,
      );
      return false;
    }
  }


  /// Delete offer letter
  Future<bool> deleteOfferLetter(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete offer letter exception: $e");
      return false;
    }
  }
}
