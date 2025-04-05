import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_file/widget/lead_file_tile.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_members/widget/lead_member_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_custom_delete_dialog.dart';
import 'package:flutter/material.dart';

class LeadMemberModelView extends StatelessWidget {
  const LeadMemberModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 15),
      itemCount: 50,
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) {
        return LeadMemberTile(
          title: "Name",
          subTitle: "test@gmail.com",
          role: "EMP",
        );
      },
    );
  }
}
