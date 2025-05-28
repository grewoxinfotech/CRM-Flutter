import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ExitController extends GetxController {
  DateTime? _lastBackPressed;

  Future<bool> handleBackPress() async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;

      Fluttertoast.showToast(
        msg: "Press back again to exit.",
        toastLength: Toast.LENGTH_SHORT,
      );

      return false; // Don’t close yet
    }
    return true; // Close the app
  }
}
