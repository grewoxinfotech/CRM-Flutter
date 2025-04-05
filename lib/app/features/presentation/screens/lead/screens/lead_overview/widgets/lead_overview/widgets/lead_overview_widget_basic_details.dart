import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewWidgetBasicDetails extends StatelessWidget {

  final LeadModel lead;

  const LeadOverviewWidgetBasicDetails({Key? key, required this.lead})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade50,
                ),
                alignment: Alignment.center,
                child: Text(
                  lead.leadTitle != null && lead.leadTitle!.isNotEmpty
                      ? lead.leadTitle![0]
                      : "L",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: CrmContainer(
                  height: 60,
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  color: Get.theme.colorScheme.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${lead.leadTitle}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${lead.companyName}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 10,
            indent: 5,
            endIndent: 5,
          ),

          CrmContainer(
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            color: Get.theme.colorScheme.background,
            child: Column(
              children: [
                items(ICRes.mailSVG, lead.email ?? "N/A"),
                Divider(color: Colors.grey.shade300, height: 10),
                items(ICRes.call, lead.telephone ?? "N/A"),
                Divider(color: Colors.grey.shade300, height: 10),
                items(ICRes.location, "lead.city" ?? "N/A"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget items(String iconPath, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CrmIcon(iconPath: iconPath, width: 14, color: Colors.grey.shade700),
      const SizedBox(width: 10),
      Text(
        title.toString(),
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: Colors.grey[700],
        ),
      ),
    ],
  );
}
