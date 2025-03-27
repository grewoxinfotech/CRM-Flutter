import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_container.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildNearestEvents(BuildContext context, Size size) {
  return Column(
    children: [
      CrmHeadline(
        title: "Nearest Events",
        showViewAll: true,
        padding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      Container(
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder:
              (context, index) => CrmContainer(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  leading: FittedBox(
                    child: Container(
                      width: 5,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  title: Text(
                    "Presentation of the new department",
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    "Today | 5:00 PM",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  trailing: FittedBox(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.watch_later),
                          const SizedBox(width: 10),
                          Text("4h"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    ],
  );
}
