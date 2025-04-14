import 'package:crm_flutter/app/widgets/leads_and_deal/note_tile.dart';
import 'package:flutter/material.dart';

class NotesViewModel extends StatelessWidget {
  final String? id;
  const NotesViewModel({super.key,this. id});

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
