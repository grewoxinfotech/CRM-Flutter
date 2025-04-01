import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  "T",
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
                        "Test123",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Company",
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
                    Text("abcd@gmail.com"),
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
                    Text("+91 4568514520"),
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
                    Text("Surat ,Gujrat"),
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
