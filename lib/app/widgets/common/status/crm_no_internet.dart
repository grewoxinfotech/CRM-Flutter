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
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: network.hasInternet.value ? 0 : 210,
        height: network.hasInternet.value ? 0 : 30,
        margin: const EdgeInsets.all(AppMargin.small),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.error,
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: network.hasInternet.value ? 0 : 18,
                color: ColorRes.white,
              ),
              AppSpacing.horizontalSmall,
              Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: network.hasInternet.value ? 0 : 14,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
