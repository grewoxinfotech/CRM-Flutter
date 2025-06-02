import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/sales/screens/customer/widgets/customer_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(),
        title: Text("Customers"),
        actionsPadding: EdgeInsets.only(right: AppPadding.medium),
        actions: [CrmIc(icon: LucideIcons.search)],
      ),
      body: Obx(
        () => ViewScreen(
          itemCount: 10,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(AppPadding.medium),
          itemBuilder: (context, i) => CustomerCard(),
        ),
      ),
    );
  }
}
