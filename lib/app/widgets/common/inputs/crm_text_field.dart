import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isRequired;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const CrmTextField({
    super.key,
    this.controller,
    this.title = "",
    this.validator,
    this.hintText,
    this.contentPadding,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.isRequired = false,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines = 1,
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
        (title == "")
            ? SizedBox()
            : Column(
              children: [
                Row(
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.theme.colorScheme.onSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isRequired)
                      Text(
                        ' *',
                        style: TextStyle(
                          color: Get.theme.colorScheme.error,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ],
                ),
                AppSpacing.verticalSmall,
              ],
            ),
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
            contentPadding:
                contentPadding ?? const EdgeInsets.all(AppPadding.small),
            filled: true,
            fillColor:
                enabled
                    ? Get.theme.colorScheme.surface
                    : Get.theme.colorScheme.surface.withAlpha(128),
            hintText: hintText,
            hintStyle: TextStyle(
              color: textSecondary.withAlpha(200),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            prefixIcon:
                prefixIcon != null
                    ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.small,
                      ),
                      child: prefixIcon,
                    )
                    : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            suffixIcon:
                suffixIcon != null
                    ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.medium,
                      ),
                      child: suffixIcon,
                    )
                    : null,
            enabledBorder: tile(Get.theme.dividerColor),
            focusedBorder: tile(Get.theme.colorScheme.primary),
            errorBorder: tile(Get.theme.colorScheme.error),
            focusedErrorBorder: tile(Get.theme.colorScheme.error),
            errorStyle: TextStyle(
              color: Get.theme.colorScheme.error,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

InputBorder? tile(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.medium),
    borderSide: BorderSide(color: color, width: 1),
  );
}
