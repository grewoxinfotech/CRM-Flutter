import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/contect/widgets/contact_list.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Contact")),
      body: ContactList(padding: EdgeInsets.all(AppMargin.medium)),
    );
  }
}
