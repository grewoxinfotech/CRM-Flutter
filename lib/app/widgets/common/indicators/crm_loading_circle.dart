import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CrmLoadingCircle extends StatelessWidget {
  final double size;

  const CrmLoadingCircle({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(color: Get.theme.colorScheme.primary, size: size),
    );
  }
}
