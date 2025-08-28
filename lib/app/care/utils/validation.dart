import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

final formKey = GlobalKey<FormState>();

String? emailValidation(String? email) {
  if (email == null || email.trim().isEmpty) {
    return "Please enter your email!";
  } else if (!GetUtils.isEmail(email.trim())) {
    return "Enter a valid email!";
  }
  return null;
}

String? passwordValidation(String? password) {
  if (password == null || password.isEmpty) {
    return "Please enter your password!";
  }
  return null;
}

String? nameValidation(String? name) {
  if (name == null || name.trim().isEmpty) {
    return "Please enter your name!";
  } else if (name.trim().length < 3) {
    return "Name must be at least 3 characters long!";
  }
  return null;
}

String? phoneValidation(String? phone) {
  if (phone == null || phone.trim().isEmpty) {
    return "Please enter your phone number!";
  } else if (!GetUtils.isPhoneNumber(phone.trim()) || phone.length != 10) {
    return "Enter a valid 10-digit phone number!";
  }
  return null;
}

/// Validates Generic Required Field
String? requiredField(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter $fieldName!";
  }
  return null;
}

//url validator
String? urlValidation(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null; // ✅ Not required field, so return valid if empty
  }

  // ✅ Basic regex for URL validation
  final urlPattern =
      r'^(https?:\/\/)?' // optional http/https
      r'([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' // domain
      r'(:\d+)?' // optional port
      r'(\/.*)?$'; // optional path/query
  final regExp = RegExp(urlPattern);

  if (!regExp.hasMatch(value.trim())) {
    return "Enter a valid URL";
  }

  return null;
}
