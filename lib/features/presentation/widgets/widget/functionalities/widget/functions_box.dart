import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionsBox extends StatelessWidget {
  final String icon;
  final String title;
  final GestureTapCallback? onTap;
  final Color? color;

  const FunctionsBox({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: CrmContainer(
          width: 120,
          height: 150,
          color: Get.theme.colorScheme.outline.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CrmContainer(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                color: color,
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(icon, width: 25),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
