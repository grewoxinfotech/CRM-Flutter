import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            children: [
              CrmCard(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(10),
                color: Get.theme.colorScheme.primary.withOpacity(0.1),
                child: Text("H"),
              ),
              SizedBox(width: 5),
              Expanded(
                child: CrmCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
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
                          Text(
                            "Palak",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "5/5/1654",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      CrmButton(
                        onTap: () {},
                        title: "Controller",
                        width: 100,
                        height: 20,
                        backgroundColor: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        titleTextStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),

          CrmCard(
            padding: const EdgeInsets.all(5),
            borderRadius: BorderRadius.circular(10),
            alignment: Alignment.centerLeft,
            color: Get.theme.colorScheme.background,
            child: Text(
              "Chat : " +
                  "gfgfdgfdgfsdfl'amksdopfjpaoshudfphusadpafuhpnsdufnoIUbnif",
            ),
          ),
        ],
      ),
    );
  }
}
