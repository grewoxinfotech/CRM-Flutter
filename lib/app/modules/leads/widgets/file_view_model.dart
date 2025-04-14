import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/file_tile.dart';
import 'package:flutter/material.dart';

class FileViewModel extends StatelessWidget {
  final String? id;
  const FileViewModel({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: 10,
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) {
        return FileTile(
          title: "Froge",
          subTitle: "froge.png",
          fileFormat: "PNG",
          onTap: () {
            print("open");
          },
          deleteButton: () {
            String entityType = "lead";
            CrmDeleteDialog(
              entityType: entityType,
              onConfirm: () => print("$entityType deleted successfully!"),
              onCancel: () => print("$entityType deletion canceled!"),
            );
          },
        );
      },
    );
  }
}
