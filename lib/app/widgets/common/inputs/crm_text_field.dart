import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size/border_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CrmTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CrmTextField({
    super.key,
    this.controller,
    required this.title,
    this.validator,
    this.hintText,
    this.obscureText = false, // Default value set
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
            fontSize: 16,
            color: Get.theme.colorScheme.onSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        Space(size: 5),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            focusedBorder: tile(Get.theme.colorScheme.primary),
            enabledBorder: tile(Get.theme.colorScheme.outline),
            focusedErrorBorder: tile(Get.theme.colorScheme.error),
            errorBorder: tile(Get.theme.colorScheme.error),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

InputBorder? tile(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRes.borderR3,
    borderSide: BorderSide(color: color, width: 1),
  );
}

