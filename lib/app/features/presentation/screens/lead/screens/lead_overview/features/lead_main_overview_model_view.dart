import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/features/lead_main_overview_model_widget.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadMainOverviewModelView extends StatelessWidget {
  const LeadMainOverviewModelView({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeadMainOverviewModelWidget> widgets =
        LeadMainOverviewModelWidget.getwidgets();
    final PageController _pageController = PageController();
    CrmTabBarController navigation_controller = Get.put(CrmTabBarController());

    return PageView.builder(
      controller: _pageController,
      itemCount: widgets.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        navigation_controller.selectedIndex == i;
        return widgets[i].widget;
      },
    );
  }
}
