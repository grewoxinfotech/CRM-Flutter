import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/company/widgets/company_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Company")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ViewScreen(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.medium,
                vertical: AppPadding.small,
              ),
              itemBuilder:
                  (context, i) => CompanyCard(
                    id: "id",
                    accountOwner: "accountOwner",
                    companyName: "companyName",
                    companySource: "companySource",
                    email: "email",
                    companyNumber: "companyNumber",
                    companyType: "companyType",
                    companyCategory: "companyCategory",
                    companyRevenue: "companyRevenue",
                    phoneCode: "phoneCode",
                    phoneNumber: "phoneNumber",
                    website: "website",
                    billingAddress: "billingAddress",
                    billingCity: "billingCity",
                    billingState: "billingState",
                    billingPinCode: "billingPinCode",
                    billingCountry: "billingCountry",
                    shippingAddress: "shippingAddress",
                    shippingCity: "shippingCity",
                    shippingState: "shippingState",
                    shippingPinCode: "shippingPinCode",
                    shippingCountry: "shippingCountry",
                    description: "description",
                    clientId: "clientId",
                    createdBy: "createdBy",
                    updatedBy: "updatedBy",
                    createdAt: "createdAt",
                    updatedAt: "updatedAt",
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
