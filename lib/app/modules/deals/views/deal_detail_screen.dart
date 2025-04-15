import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/modules/deals/views/deal_overview_screen.dart';
import 'package:crm_flutter/app/modules/leads/widgets/file_view_model.dart';
import 'package:crm_flutter/app/modules/leads/widgets/invoice_view_model.dart';
import 'package:crm_flutter/app/modules/leads/widgets/member_view_model.dart';
import 'package:crm_flutter/app/modules/leads/widgets/notes_view_model.dart';
import 'package:crm_flutter/app/modules/leads/widgets/payment_view_model.dart';
import 'package:crm_flutter/app/widgets/tab_bar/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealDetailScreen extends StatelessWidget {
  final String dealId;

  const DealDetailScreen({super.key, required this.dealId});

  @override
  Widget build(BuildContext context) {
    CrmTabBarController controller = Get.find();
    List widgets = [
      DealOverview(dealId: dealId),
      FileViewModel(),
      MemberViewModel(),
      NotesViewModel(),
      InvoiceViewModel(),
      PaymentViewModel(),
    ];
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.surface,
        title: Text("Deal"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                  height: 40
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: widgets.length,
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedIndex.value = i;
                      },
                      child: widgets[i],
                    );
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 5),
              CrmTabBar(
                items: [
                  TabItem(iconPath: ICRes.attach, label: "Overview"),
                  TabItem(iconPath: ICRes.attach, label: "Files"),
                  TabItem(iconPath: ICRes.attach, label: "Members"),
                  TabItem(iconPath: ICRes.attach, label: "Notes"),
                  TabItem(iconPath: ICRes.attach, label: "Invoice"),
                  TabItem(iconPath: ICRes.attach, label: "Paymant"),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
