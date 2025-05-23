import 'package:flutter/material.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:intl/intl.dart';

class CrmDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime?) onDateSelected;
  final String? hint;
  final bool isRequired;
  final bool isEnabled;
  final String? errorText;

  const CrmDatePicker({
    Key? key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    this.hint,
    this.isRequired = false,
    this.isEnabled = true,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppPadding.small),
        ],
        InkWell(
          onTap: isEnabled
              ? () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    onDateSelected(picked);
                  }
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.medium,
              vertical: AppPadding.medium,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null
                    ? Theme.of(context).colorScheme.error
                    : Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(8),
              color: isEnabled ? Colors.white : Colors.grey[100],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : hint ?? 'Select date',
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedDate != null
                        ? Colors.black87
                        : Colors.grey[600],
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
} 