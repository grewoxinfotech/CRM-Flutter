import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/network/search/module_config.dart';


class ModuleController extends GetxController {
  var modules = <ModuleConfig>[].obs;
  var filteredModules = <ModuleConfig>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadModules();
  }

  Future<void> loadModules() async {
    final String response =
    await rootBundle.loadString('assets/module_config.json');
    final List<dynamic> data = jsonDecode(response);

    modules.value = data.map((e) => ModuleConfig.fromJson(e)).toList();
    filteredModules.assignAll(modules);
  }

  void filterModules(String query) {
    if (query.isEmpty) {
      filteredModules.assignAll(modules);
    } else {
      filteredModules.assignAll(
        modules.where((m) =>
        m.name.toLowerCase().contains(query.toLowerCase()) ||
            m.category.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void openModule(ModuleConfig module) {
    final screenBuilder = screenMapper[module.screen];
    if (screenBuilder != null) {
      Get.to(screenBuilder());
    } else {
      Get.snackbar("Error", "Screen not found for ${module.name}");
    }
  }
}
