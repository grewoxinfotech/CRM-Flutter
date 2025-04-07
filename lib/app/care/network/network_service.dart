import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkStatusService extends GetxService {
  final RxBool hasInternet = true.obs;

  Future<NetworkStatusService> init() async {
    _startMonitoring();
    return this;
  }

  void _startMonitoring() {
    Connectivity().onConnectivityChanged.listen((_) => _checkInternet());
    _checkInternet();
    InternetConnection().onStatusChange.listen((status) {
      hasInternet.value = status == InternetStatus.connected;
    });
  }

  Future<void> _checkInternet() async {
    final status = await InternetConnection().hasInternetAccess;
    hasInternet.value = status;
  }
}