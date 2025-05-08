import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CrmTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final bool isRequired;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool enabled;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const CrmTextField({
    super.key,
    this.controller,
    required this.title,
    this.validator,
    this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.isRequired = false,
    this.keyboardType,
    this.maxLines = 1,
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: 14,
                color: Get.theme.colorScheme.onSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: Get.theme.colorScheme.error,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          enabled: enabled,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onTap: onTap,
          style: TextStyle(
            fontSize: 15,
            color: Get.theme.colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: enabled ? Get.theme.colorScheme.surface : Get.theme.colorScheme.surface.withAlpha(128),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Get.theme.colorScheme.onSurface.withAlpha(128),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefixIcon != null 
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    prefixIcon,
                    size: 20,
                    color: Get.theme.colorScheme.primary,
                  ),
                )
              : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.outline.withAlpha(128),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.outline.withAlpha(128),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: 1.5,
              ),
            ),
            errorStyle: TextStyle(
              color: Get.theme.colorScheme.error,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

InputBorder? tile(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: color, width: 1),
  );
}

