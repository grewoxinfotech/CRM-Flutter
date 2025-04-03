import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';

class LeadNoteScreen extends StatelessWidget {
  const LeadNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              CrmAppBar(),
            ],
          )
        ],
      ),
    );
  }
}
