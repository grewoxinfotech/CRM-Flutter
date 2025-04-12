import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size/border_res.dart';
import 'package:crm_flutter/app/care/constants/size/margin_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
import 'package:crm_flutter/app/care/utils/network_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmNoInternet extends StatelessWidget {
  const CrmNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    final network = Get.find<NetworkStatusService>();
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 250,
        height: network.hasInternet.value ? 0 : 30,
        margin: MarginRes.horizontal1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.error,
          borderRadius: BorderRes.borderR4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded, size: 18, color: ColorRes.white),
            Space(size: 10),
            Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ColorRes.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
