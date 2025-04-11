import 'package:crm_flutter/app/features/screens/lead_&_deal/widgets/payment_tile.dart';
import 'package:flutter/material.dart';

class PaymentViewModel extends StatelessWidget {
  const PaymentViewModel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10),
      itemCount: 10,
      separatorBuilder: (context, i) => const SizedBox(height: 5),
      itemBuilder: (context, i) {
        return PaymentTile(
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
