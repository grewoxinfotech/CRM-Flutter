import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_notes/widget/lead_note_tile.dart';
import 'package:flutter/material.dart';

class LeadNoteModelView extends StatelessWidget {
  const LeadNoteModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 15),
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) => LeadNoteTile(
        title: "Note",
      ),
    );
  }
}
