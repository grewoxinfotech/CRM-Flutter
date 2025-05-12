import 'package:get/get.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class NoteController extends GetxController {
  final NoteService noteService = Get.find<NoteService>();
  
  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final RxString selectedNoteType = 'normal'.obs;
  final RxBool isLoading = false.obs;
  
  final TextEditingController noteTitleController = TextEditingController();
  final TextEditingController noteDescriptionController = TextEditingController();

  final List<String> noteTypeOptions = ['important', 'normal', 'urgent'];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    noteTitleController.dispose();
    noteDescriptionController.dispose();
    super.onClose();
  }

  Future<void> getNotesForLead(String leadId) async {
    try {
      isLoading.value = true;
      final notesList = await noteService.getNotesByLeadId(leadId);
      notes.assignAll(notesList);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to fetch notes: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createNoteForLead(String leadId) async {
    if (noteTitleController.text.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Please enter a title',
        contentType: ContentType.warning,
      );
      return false;
    }

    if (noteDescriptionController.text.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Please enter a description',
        contentType: ContentType.warning,
      );
      return false;
    }

    try {
      isLoading.value = true;
      
      final note = NoteModel(
        id: '',
        relatedId: leadId,
        noteTitle: noteTitleController.text,
        notetype: selectedNoteType.value,
        description: noteDescriptionController.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      print('Attempting to create note...'); // Debug print
      final success = await noteService.createNote(leadId, note);
      
      if (success) {
        // Clear the form
        noteTitleController.clear();
        noteDescriptionController.clear();
        selectedNoteType.value = 'normal';
        
        // Refresh the notes list
        await getNotesForLead(leadId);
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Note created successfully',
          contentType: ContentType.success,
        );
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to create note: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNoteForLead(String leadId, String noteId) async {
    if (noteTitleController.text.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Please enter a title',
        contentType: ContentType.warning,
      );
      return;
    }

    if (noteDescriptionController.text.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Please enter a description',
        contentType: ContentType.warning,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      final note = NoteModel(
        id: noteId,
        relatedId: leadId,
        noteTitle: noteTitleController.text,
        notetype: selectedNoteType.value,
        description: noteDescriptionController.text,
        clientId: '27QmTY0BI4nb89DW3lXrly9', // This should be dynamic based on the current user's client ID
        createdBy: 'raiser2', // This should be dynamic based on the current user
        updatedBy: 'raiser2', // This should be dynamic based on the current user
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      print('Attempting to update note...'); // Debug print
      final success = await noteService.updateNote(noteId, note);
      
      if (success) {
        // Clear the form
        noteTitleController.clear();
        noteDescriptionController.clear();
        selectedNoteType.value = 'normal';
        
        // Refresh the notes list
        await getNotesForLead(leadId);
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Note updated successfully',
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update note: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteNote(String noteId, String leadId) async {
    try {
      isLoading.value = true;
      final success = await noteService.deleteNote(noteId);
      if (success) {
        await getNotesForLead(leadId);
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete note: ${e.toString()}',
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
