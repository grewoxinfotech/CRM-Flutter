import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w800,
      color: Get.theme.colorScheme.primary,
    );

    Widget tile(int x) {
      Size size = MediaQuery.of(context).size;
      double w = size.width;
      double h = size.height;
      return Row(
        children: [
          Text(x.toString()),
          const SizedBox(width: 100),
          Text("${w * x} x ${h * x}"),
        ],
      );
    }

    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, s) => const SizedBox(height: 10),
            itemBuilder: (context, i) => tile(i+1),
          ),
        ),
      ),
    );
  }
}
