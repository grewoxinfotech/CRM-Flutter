import 'package:crm_flutter/app/widgets/leads_and_deal/member_tile.dart';
import 'package:flutter/material.dart';

class MemberViewModel extends StatelessWidget {
  final String? id;
  const MemberViewModel({super.key,this. id});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10),
      itemCount: 10,
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) {
        return MemberTile(
          title: "Test",
          subTitle: "test@gmail.com",
          role: "EMP",
          onTap: () {
            print("Employee : " + (i + 1).toString());
          },
        );
      },
    );
  }
}
