import 'package:crm_flutter/app/services/network_service.dart';
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
        margin: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.error,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded, size: 18, color: Get.theme.colorScheme.surface),
            const SizedBox(width: 10),
            Text(
              "No Internet Connection",
              style: TextStyle(
                color: Get.theme.colorScheme.surface,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
