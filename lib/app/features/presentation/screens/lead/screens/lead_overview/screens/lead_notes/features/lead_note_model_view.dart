import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_notes/features/lead_note_model_widget.dart';
import 'package:flutter/material.dart';

class LeadNoteModelView extends StatelessWidget {
  const LeadNoteModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LeadNoteModelWidget> widgets = LeadNoteModelWidget.getwidgets();
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      separatorBuilder: (context, i) => const SizedBox(height: 20),
      itemBuilder: (context, i) => widgets[i].widget,
    );
  }
}
