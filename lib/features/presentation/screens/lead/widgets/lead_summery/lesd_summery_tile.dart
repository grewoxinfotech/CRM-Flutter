
import 'package:crm_flutter/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LesdSummeryTile extends StatelessWidget {

  final GestureTapCallback? onTap;
  final int count;
  final String title;

  const LesdSummeryTile({super.key,required this.title,required this.count,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmContainer(
        width: 150,
        height: 100,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            Text(
              title.toString(),

              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
