import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/views/lead_detail_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  LeadList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    final LeadController controller = Get.put(LeadController());
    return FutureBuilder<List<LeadModel>>(
      future: controller.getLeads(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CrmLoadingCircle(),
          ); // or CrmLoadingCircle()
        } else if (snapshot.hasError) {
          return Center(
            child: SizedBox(
              width: 250,
              child: Text(
                'Server Error : \n${snapshot.error}',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final leads = snapshot.data!;
          if (leads.isEmpty) {
            return const Center(child: Text("No Leaves Found"));
          } else {
            return ViewScreen(
              padding:
                  padding ??
                  EdgeInsets.symmetric(horizontal: AppPadding.medium),
              itemCount:
                  (itemCount != null && itemCount! < leads.length)
                      ? itemCount!
                      : leads.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder:
                  (context, i) => LeadCard(
                    lead: leads[i],
                    onTap: () => Get.to(LeadDetailScreen(lead: leads[i])),
                  ),
            );
          }
        } else {
          return const Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
