import 'package:crm_flutter/app/features/screens/lead_&_deal/widgets/note_tile.dart';
import 'package:flutter/material.dart';

class NotesViewModel extends StatelessWidget {
  const NotesViewModel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 10),
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) => NoteTile(title: "Note"),
    );
  }
}
