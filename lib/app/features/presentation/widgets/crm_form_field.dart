import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CrmFormField({
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
        if (title != null) // Null check added to prevent empty text rendering
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                title!,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorResources.TEXT_SECONDARY,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        if (title != null) const SizedBox(height: 15),
        // Only add space if title exists
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.primary,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.outline,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: 1,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
