import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/functions/widget/function_card.dart';
import 'package:crm_flutter/app/modules/screens/purchase/views/purchase_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("HRM")),
    );
  }
}
