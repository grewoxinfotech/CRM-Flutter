import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:flutter/material.dart';

class WellcomeText extends StatelessWidget {
  const WellcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi Evan, Welcome back!",
            style: TextStyle(
              fontSize: 16,
              color: COLORRes.TEXT_PRIMARY.withAlpha(175),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Dashboard",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: COLORRes.TEXT_PRIMARY,
            ),
          ),
        ],
      ),
    );
  }
}
