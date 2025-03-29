import 'package:crm_flutter/features/data/resources/icon_resources.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmBottemBar extends StatelessWidget {
  CrmBottemBar({super.key});

  final List<int> num = [0,1,2,3];
  final RxInt selectedItem = 0.obs;

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: EdgeInsets.all(10),
      height: 70,
      width: 2000,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: num.map((e)=> BarItem(IconResources.LOGO, (){
          selectedItem.value = e;

        })).toList(),
      ),
    );
  }
}

Widget BarItem(final String iconpath, final GestureTapCallback? onTap, ) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 30,
      width: 50,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(100),
      ),
      alignment: Alignment.center,
      child: Image.asset(iconpath,width: 24),
    ),
  );
}
