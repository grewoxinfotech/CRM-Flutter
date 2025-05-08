import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmDropdownField<T> extends StatelessWidget {
  final String title;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool isRequired;
  final String? hintText;
  final IconData? prefixIcon;
  final String? Function(T?)? validator;
  final bool enabled;
  final FocusNode? focusNode;
  final double? width;

  const CrmDropdownField({
    super.key,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
    this.focusNode,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
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
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<T>(
            value: value,
            items: items.map((DropdownMenuItem<T> item) {
              return DropdownMenuItem<T>(
                value: item.value,
                child: Text(
                  item.value.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Get.theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
            onChanged: enabled ? onChanged : null,
            validator: validator,
            focusNode: focusNode,
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
            isExpanded: true,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Get.theme.colorScheme.primary,
              size: 24,
            ),
            dropdownColor: Get.theme.scaffoldBackgroundColor,
            menuMaxHeight: 300,
            itemHeight: 50,
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((DropdownMenuItem<T> item) {
                return Text(
                  item.value.toString(),
                  style: TextStyle(
                    color: Get.theme.colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ],
    );
  }
} 