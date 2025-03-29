import 'package:flutter/material.dart';

class WellcomeText extends StatelessWidget {
  const WellcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          const Text(
            "Hi Evan, Welcome back!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Dashboard",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
