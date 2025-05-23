import 'package:flutter/material.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';

class CrmTimePicker extends StatelessWidget {
  final String label;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay?) onTimeSelected;
  final String? hint;
  final bool isRequired;
  final bool isEnabled;
  final String? errorText;

  const CrmTimePicker({
    Key? key,
    required this.label,
    required this.selectedTime,
    required this.onTimeSelected,
    this.hint,
    this.isRequired = false,
    this.isEnabled = true,
    this.errorText,
  }) : super(key: key);

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

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
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                  );
                  if (picked != null) {
                    onTimeSelected(picked);
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
                  selectedTime != null
                      ? _formatTime(selectedTime!)
                      : hint ?? 'Select time',
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedTime != null
                        ? Colors.black87
                        : Colors.grey[600],
                  ),
                ),
                Icon(
                  Icons.access_time,
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