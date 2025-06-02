import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/care/utils/network_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmNoInternet extends StatelessWidget {
  const CrmNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    final network = Get.find<NetworkStatusService>();
    return Obx(() {
      final noInternet = !network.hasInternet.value;
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: noInternet ? 1 : 0,
        child: noInternet
            ? Container(
          width: 210,
          height: 30,
          margin: const EdgeInsets.all(AppMargin.small),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  "No Internet Connection",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        )
            : const SizedBox.shrink(),
      );
    });
  }
}
