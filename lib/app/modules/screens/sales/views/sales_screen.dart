import 'package:crm_flutter/app/modules/screens/sales/views/sales_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("HRM")),
    );
  }
}
