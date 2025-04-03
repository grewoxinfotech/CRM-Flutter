import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';

class LeadFileScreen extends StatelessWidget {
  const LeadFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){}),
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
