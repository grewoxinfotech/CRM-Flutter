import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/internet_service.dart';

class InternetStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isConnected = Get.find<InternetService>().isConnected.value;
      return isConnected
          ? SizedBox.shrink()
          : Container(
            width: double.infinity,
            padding: EdgeInsets.all(7),
            color: Colors.red,
            child: Text(
              "No Internet Connection!",
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          );
    });
  }
}
