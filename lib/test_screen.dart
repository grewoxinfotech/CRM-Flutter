import 'package:crm_flutter/app/modules/project/file/widget/file_card.dart';
import 'package:crm_flutter/app/modules/project/payment/widget/payment_card.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [FileCard(), PaymentCard()],
            ),
          ),
        ),
      ),
    );
  }
}
