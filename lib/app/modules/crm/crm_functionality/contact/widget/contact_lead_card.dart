import 'package:flutter/material.dart';

import '../../../../../widgets/date_time/format_date.dart';



class ContactLeadCard extends StatelessWidget {
  final String? title;
  final String? stage;
  final int? value;
  final String? currency;
  final String? pipeline;
  final String? status;
  final String? createdAt;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContactLeadCard({
    super.key,
    this.title,
    this.stage,
    this.value,
    this.currency,
    this.pipeline,
    this.status,
    this.createdAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title ?? 'Untitled Lead',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoLine('Stage', stage),
              _infoLine('Status', status),
              _infoLine(
                'Value',
                (value != null && currency != null) ? "$currency $value" : null,
              ),
              _infoLine('Pipeline', pipeline),
              _infoLine('Created', formatDate(createdAt ?? '')),
            ],
          ),
        ),
        trailing: Wrap(
          spacing: 4,
          children: [
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.green),
                onPressed: onEdit,
              ),
            if (onDelete != null)
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.error,
                ),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoLine(String label, String? value) {
    return Text(
      "$label: ${value?.isNotEmpty == true ? value : '-'}",
      style: const TextStyle(fontSize: 13),
    );
  }
}
