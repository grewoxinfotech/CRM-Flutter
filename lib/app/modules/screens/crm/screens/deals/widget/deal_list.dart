import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/widget/deal_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  DealList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    final DealController controller = Get.put(DealController());
    return FutureBuilder<List<DealModel>>(
      future: controller.getDeals(),
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
          final deals = snapshot.data!;
          if (deals.isEmpty) {
            return const Center(child: Text("No Leaves Found"));
          } else {
            return ViewScreen(
              padding:
                  padding ??
                  EdgeInsets.symmetric(horizontal: AppPadding.medium),
              itemCount:
                  (itemCount != null && itemCount! < deals.length)
                      ? itemCount!
                      : deals.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => DealCard(deal: deals[i]),
            );
          }
        } else {
          return const Center(child: Text("Something went wrong."));
        }
      },
    );
  }
}
