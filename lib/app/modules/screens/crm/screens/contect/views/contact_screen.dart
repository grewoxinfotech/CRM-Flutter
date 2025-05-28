import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/widgets/contact_list.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(),
        title: const Text("Contacts"),
        actionsPadding: EdgeInsets.only(right: AppPadding.medium),
        actions: [CrmIc(iconPath: Ic.filter, color: primary)],
      ),
      floatingActionButton: CrmButton(
        onTap: () => Get.to(AppRoutes.contact),
        title: "Add Contact",
      ),
      body: ContactList(),
    );
  }
}
