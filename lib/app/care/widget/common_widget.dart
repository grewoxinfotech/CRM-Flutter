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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppRadius.small),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 12))),
    );
  }
}
