import 'package:crm_flutter/features/presentation/screens/lead/widgets/lead_summery/lesd_summery_tile.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/cupertino.dart';

class LeadSummaryView extends StatelessWidget {
  const LeadSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CrmHeadline(
          title: "Lead Summery",
          padding: const EdgeInsets.symmetric(horizontal: 30),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: 100,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              if (i % 2 == 0) {
                int c = i ~/ 2;
                return LesdSummeryTile(title: "Crm", count: c);
              } else if (i % 2 != 0) {
                return SizedBox(width: 10);
              }
            },
          ),
        ),
      ],
    );
  }
}
