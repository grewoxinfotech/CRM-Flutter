import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetService extends GetxController {
  final RxBool isConnected = true.obs;

  late StreamSubscription _subscription;

  @override
  void onInit() {
    super.onInit();
    checkInternet();
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (results is List<ConnectivityResult>) {
        isConnected.value = results.contains(ConnectivityResult.mobile) ||
            results.contains(ConnectivityResult.wifi);
      } else if (results is ConnectivityResult) {
        isConnected.value = (results == ConnectivityResult.mobile ||
            results == ConnectivityResult.wifi);
      }
    });
  }

  void checkInternet() async {
    var results = await Connectivity().checkConnectivity();
    if (results is List<ConnectivityResult>) {
      isConnected.value = results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);
    } else if (results is ConnectivityResult) {
      isConnected.value = (results == ConnectivityResult.mobile ||
          results == ConnectivityResult.wifi);
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
