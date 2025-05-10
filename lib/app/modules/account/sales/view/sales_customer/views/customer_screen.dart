import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/account/sales/view/sales_customer/widgets/customer_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(),
        title: Text("Customers"),
        actionsPadding: EdgeInsets.only(right: AppPadding.medium),
        actions: [CrmIc(iconPath: ICRes.search)],
      ),
      body: ViewScreen(
        itemCount: 10,
        padding: EdgeInsets.all(AppPadding.medium),
        itemBuilder:
            (context, i) => CustomerCard(name: "Senal"
                ,phoneCode: "+91",
                customerNumber: "9663366556"
                , color: Colors.green),
      ),
    );
  }
}
