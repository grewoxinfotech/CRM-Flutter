import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CrmImagePicker {
  static final ImagePicker _picker = ImagePicker();

  /// Pick a single image from gallery
  static Future<File?> pickFromGallery({
    int? imageQuality, // 0–100, lower = more compression
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
       ('Error picking from gallery: $e');
      return null;
    }
  }

  /// Pick a single image from camera
  static Future<File?> pickFromCamera({int? imageQuality}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
       ('Error picking from camera: $e');
      return null;
    }
  }

  /// Pick multiple images from gallery
  static Future<List<File>> pickMultiple({int? imageQuality}) async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: imageQuality,
      );
      return pickedFiles.map((file) => File(file.path)).toList();
    } catch (e) {
       ('Error picking multiple images: $e');
      return [];
    }
  }
}
