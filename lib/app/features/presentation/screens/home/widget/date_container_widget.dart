import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';

import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';

class DateContainerWidget extends StatelessWidget {
  final String fd;
  final String ld;

  const DateContainerWidget({super.key, required this.fd, required this.ld});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      width: 500,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CrmIcon(iconPath: ICRes.calendar,color: Colors.black,),
          Text(
            fd,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),Text(
            ld,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          CrmIcon(iconPath: ICRes.calendar,color: Colors.white,),

        ],
      ),
    );
  }
}
