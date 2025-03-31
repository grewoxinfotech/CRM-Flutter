import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';

class LeadOverviewIdInformation extends StatelessWidget {
  const LeadOverviewIdInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage(IconResources.LOGO),
                ),
                const SizedBox(height: 10),
                Text(
                  "Grewox Infotech",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text("abcdefghi@gmail.com", style: TextStyle(fontSize: 14)),
            ],
          ),

          Text(
            "Phone",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text("+91 6548564255"),
          Text(
            "Location",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text("Surat, Gujrat"),
        ],
      ),
    );
  }
}
