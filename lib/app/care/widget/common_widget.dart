import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/size_manager.dart';

class CommonWidget {
  CommonWidget._();

  static Widget buildChips(String text) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorRes.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 12))),
    );
  }

  static Widget buildText(
      String text,
      String title, {
        double fontSize = 14,
        FontWeight fontWeight = FontWeight.normal,
        Color color = Colors.black,
      }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(

              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
