import 'package:crm_flutter/app/care/theme/themes.dart';
import 'package:crm_flutter/app/care/utils/network_service.dart';
import 'package:crm_flutter/app/modules/communication/communication_functionality/chat/controllers/chat_controller.dart';
import 'package:crm_flutter/app/widgets/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => NetworkStatusService().init());
  Get.put(ChatController(), permanent: true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: SplashScreen(),
    ),
  );
}
