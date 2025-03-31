import 'package:crm_flutter/app/features/data/resources/url_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/widgets/lead_summery/lesd_summery_tile.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
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
        const SizedBox(height: 10,),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, i) => const SizedBox(width: 10),
            itemBuilder:
                (context, i) => LesdSummeryTile(
                  title: "Crm",
                  count: i,
                  onTap: () {
                    print(UrlResources.Leads);
                  },
                ),
          ),
        ),
      ],
    );
  }
}
