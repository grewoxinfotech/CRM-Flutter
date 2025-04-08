import 'package:crm_flutter/app/features/presentation/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              CrmContainer(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(10),
                color: Get.theme.colorScheme.primary.withOpacity(0.1),
                child: Text("H"),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: CrmContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  borderRadius: BorderRadius.circular(10),
                  height: 60,
                  alignment: Alignment.center,
                  color: Get.theme.colorScheme.background,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Palak",style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),),
                          SizedBox(width: 5,),
                          Text("5/5/1654",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),)
                        ],
                      ),
                      CrmButton(title: "Controller", onPressed: (){},
                        borderRadius: BorderRadius.circular(10),
                        width: 100,
                        backgroundColor: Colors.green,
                        fontSize: 12,
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),

          CrmContainer(
            padding: const EdgeInsets.all(5),
            borderRadius: BorderRadius.circular(10),
            alignment: Alignment.centerLeft,
            color: Get.theme.colorScheme.background,
child: Text("Chat : "+"gfgfdgfdgfsdfl'amksdopfjpaoshudfphusadpafuhpnsdufnoIUbnif"),
          ),
        ],
      ),
    );
  }
}
