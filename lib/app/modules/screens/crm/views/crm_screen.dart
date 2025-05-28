import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/functions/widget/function_card.dart';
import 'package:crm_flutter/app/modules/screens/crm/views/crm_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmScreen extends StatelessWidget {
  const CrmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CrmModel> items = CrmModel.getCrmWidgets();
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: Text("Crm")),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 200),
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppPadding.small,
                mainAxisSpacing: AppPadding.small,
                mainAxisExtent: 60,
              ),
              padding: EdgeInsets.symmetric(horizontal: AppPadding.medium),
              itemCount: items.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder:
                  (context, i) => FunctionCard(
                    onTap: () => Get.to(items[i].widget),
                    title: items[i].title,
                    color: items[i].color,
                    icon: items[i].iconData,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
