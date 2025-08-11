import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:http/http.dart' as http;

class NoteService {
  final String url = UrlRes.notes;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Get notes for a specific lead or deal
  Future<List<NoteModel>> getNotes(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$url/$id"),
        headers: await headers(),
      );
      
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data["success"] == true) {
        List<dynamic> notesData = [];
        
        // Check different response structures
        if (data["data"] != null) {
          // Direct data format
          notesData = data["data"];
        } else if (data["message"] != null) {
          // If message is a string and data is elsewhere
          if (data["message"] is String && data["data"] != null) {
            notesData = data["data"];
          }
          // If data is nested under message
          else if (data["message"] is Map && data["message"]["data"] != null) {
            notesData = data["message"]["data"];
          }
        }
        
        return notesData.map((note) => NoteModel.fromJson(note)).toList();
      } else {
        String errorMessage = "Failed to fetch notes";
        if (data["message"] is String) {
          errorMessage = data["message"];
        }
        
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: errorMessage,
          contentType: ContentType.failure,
        );
        return [];
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to fetch notes: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return [];
    }
  }

  Future<bool> createNote(String id, NoteModel note) async {
    try {
      final response = await http.post(
        Uri.parse("$url/$id"),
        headers: await headers(),
        body: jsonEncode(note.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Note created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to create note: ${response.statusCode}",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to create note: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Update an existing note
  Future<bool> updateNote(String noteId, NoteModel note) async {
    try {
      final response = await http.put(
        Uri.parse("$url/$noteId"),
        headers: await headers(),
        body: jsonEncode(note.toJson()),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Note updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: data["message"] ?? "Failed to update note",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to update note: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete a note
  Future<bool> deleteNote(String noteId) async {
    try {
      final response = await http.delete(
        Uri.parse("$url/$noteId"),
        headers: await headers(),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Note deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: data["message"] ?? "Failed to delete note",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to delete note: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
