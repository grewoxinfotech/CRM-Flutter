import 'package:crm_flutter/app/care/theme/themes.dart';
import 'package:crm_flutter/app/care/utils/network_service.dart';
import 'package:crm_flutter/app/data/network/all/user_managemant/user_service.dart';
import 'package:crm_flutter/app/routes/app_pages.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => NetworkStatusService().init());
  await Get.putAsync(() => UserService().init());
  debugPaintSizeEnabled = false;
  debugPaintBaselinesEnabled = false;
  debugPaintPointersEnabled = false;
  debugPaintLayerBordersEnabled = false;
  debugRepaintRainbowEnabled = false;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    ),
  );
}
