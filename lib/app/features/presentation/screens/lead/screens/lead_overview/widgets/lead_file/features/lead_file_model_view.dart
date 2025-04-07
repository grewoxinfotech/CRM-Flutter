import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_file/widget/lead_file_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_custom_delete_dialog.dart';
import 'package:flutter/material.dart';

class LeadFileModelView extends StatelessWidget {
  const LeadFileModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 15),
      itemCount: 10,
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) {
        return LeadFileTile(
          title: "Froge",
          subTitle: "froge.png",
          fileFormat: "PNG",
          onTap: (){
            print("open");
          },
          deleteButton: () {
            String entityType = "lead";
            showCustomDeleteDialog(
              context: context,
              entityType: entityType,
              onConfirm: () {
                print("$entityType deleted successfully!");
              },
              onCancel: () {
                print("$entityType deletion canceled!");
              },
            );
          },
        );
      },
    );
  }
}
