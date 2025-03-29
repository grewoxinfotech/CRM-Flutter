import 'package:crm_flutter/features/presentation/screens/lead/widgets/lead_summery/lesd_summery_tile.dart';
import 'package:crm_flutter/features/presentation/screens/lead/widgets/leads/lead_tile.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';

class LeadView extends StatelessWidget {
  const LeadView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CrmHeadline(
            title: "Leads",
            padding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          const SizedBox(height: 10),
          SizedBox(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 13,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                if (i % 2 == 0) {
                  int c = i ~/ 2;
                  return LeadTile(
                    claint_name: "Neel",
                    company_name: "Grewox Infotech",
                    amount: c,
                    source: "Google",
                    status: "Good",
                    status_color: Colors.green,
                    date: "28 match 2025",
                  );
                } else if (i % 2 != 0) {
                  return SizedBox(height: 10);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
