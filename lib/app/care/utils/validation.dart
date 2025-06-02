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
  } else if (name.trim().length < 6) {
    return "Name must be at least 3 characters long!";
  }
  return null;
}

String? phoneValidation(String? phone) {
  if (phone == null || phone.trim().isEmpty) {
    return "Please enter your phone number!";
  } else if (!GetUtils.isPhoneNumber(phone.trim()) || phone.trim().length != 10) {
    return "Enter a valid more 9-digit phone number!";
  }
  return null;
}

/// Validates a generic required field with customizable field name
String? requiredField(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter $fieldName!";
  }
  return null;
}
