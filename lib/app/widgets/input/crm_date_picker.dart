import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrmDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;

  const CrmDatePicker({
    Key? key,
    required this.controller,
    required this.label,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              controller.text = DateFormat('yyyy-MM-dd').format(date);
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
} 