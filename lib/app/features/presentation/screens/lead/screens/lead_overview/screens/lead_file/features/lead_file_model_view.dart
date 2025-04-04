import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_file/features/lead_file_model_widget.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_file/widget/lead_file_tile.dart';
import 'package:flutter/material.dart';

class LeadFileModelView extends StatelessWidget {
  const LeadFileModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LeadFileModelWidget> widgets = LeadFileModelWidget.getwidgets();
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10),
      itemCount: 10,
      separatorBuilder: (context, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        return LeadFileTile(
          title: "Hiren",
          subTitle: "Hirenss",
          fileFormat: "MAN",
          onTap: (){
            print("open");
          },
          deleteButton: (){
            print("Delete");
          },
        );
      },
    );
  }
}
