import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_notes/features/lead_note_model_widget.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_notes/widget/lead_note_tile.dart';
import 'package:flutter/material.dart';

class LeadNoteModelView extends StatelessWidget {
  const LeadNoteModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LeadNoteModelWidget> widgets = LeadNoteModelWidget.getwidgets();
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 15),
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) => LeadNoteTile(
        title: "Note",
      ),
    );
  }
}
