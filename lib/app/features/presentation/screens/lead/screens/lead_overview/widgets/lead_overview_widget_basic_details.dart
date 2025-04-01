import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../data/lead/lead_home/lead_model.dart';

class LeadOverviewWidgetBasicDetails extends StatelessWidget {
  // final String firstname;
  // final String lastname;
  // final String email;
  // final String phone;
  // final String location;
  //
  // LeadOverviewWidgetBasicDetails({
  //   super.key,
  //   required this.firstname,
  //   required this.lastname,
  //   required this.email,
  //   required this.phone,
  //   required this.location,
  // });

  final LeadModel lead;

  const LeadOverviewWidgetBasicDetails({Key? key, required this.lead})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CrmContainer(
                width: 75,
                height: 75,
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade50,
                alignment: Alignment.center,
                child: Text(
                  lead.leadTitle != null && lead.leadTitle!.isNotEmpty
                      ? lead.leadTitle![0]
                      : "L",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CrmContainer(
                  height: 75,
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(10),
                  color: Get.theme.colorScheme.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${lead.leadTitle}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Company: ${lead.companyName}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 20,
            indent: 10,
            endIndent: 10,
          ),

          CrmContainer(
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            color: Get.theme.colorScheme.background,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      child: Icon(
                        Icons.email_rounded,
                        color: Get.theme.colorScheme.surface,
                        size: 13,
                      ),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        text: "Email: ", // Title highlighted
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: lead.email ?? "N/A", // Data
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade300, height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      child: Icon(
                        Icons.phone_iphone_rounded,
                        color: Get.theme.colorScheme.surface,
                        size: 13,
                      ),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        text: "Telephone: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: lead.telephone ?? "N/A",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.shade300, height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Get.theme.colorScheme.surface,
                        size: 13,
                      ),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        text: "City: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "lead.city" ?? "N/A",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
