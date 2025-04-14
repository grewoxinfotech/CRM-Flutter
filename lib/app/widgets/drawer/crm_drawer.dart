import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/modules/auth/controllers/auth_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrmDrawer extends StatelessWidget {
  const CrmDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerController drawerController = Get.put(DrawerController());
    List<DrawerModel> items = [
      DrawerModel(title: "DashBoard", iconPath: ICRes.customer),
      DrawerModel(title: "Project", iconPath: ICRes.project),
      DrawerModel(title: "Calendar", iconPath: ICRes.calendar),
      DrawerModel(title: "Vacations", iconPath: ICRes.project),
      DrawerModel(title: "Employees", iconPath: ICRes.employees),
      DrawerModel(title: "Messenger", iconPath: ICRes.notifications),
      DrawerModel(title: "Info Portal", iconPath: ICRes.file),
    ];
    return SafeArea(
      child: CrmCard(
        width: Get.width * 0.7,
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        margin: const EdgeInsets.only(left: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CrmAppLogo(),
            const SizedBox(height: 40),
            SizedBox(
              child: ListView.separated(
                itemCount: items.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () => drawerController.onchange(i),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CrmCard(
                            width: Get.width * 0.6,
                            padding: const EdgeInsets.all(15),
                            color:
                                (drawerController.selextedIndex == i)
                                    ? Get.theme.colorScheme.primary.withAlpha(
                                      20,
                                    )
                                    : Get.theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [],
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CrmIc(
                                  iconPath: items[i].iconPath.toString(),
                                  color:
                                      (drawerController.selextedIndex == i)
                                          ? Get.theme.colorScheme.primary
                                          : Get.theme.colorScheme.onSecondary,
                                  width: 24,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  items[i].title.toString(),
                                  style: TextStyle(
                                    fontWeight:
                                        (drawerController.selextedIndex == i)
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                    fontSize: 16,
                                    color:
                                        (drawerController.selextedIndex == i)
                                            ? Get.theme.colorScheme.primary
                                            : Get.theme.colorScheme.onSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: Get.width * 0.015,
                            height: 50,
                            decoration: BoxDecoration(
                              color:
                                  (drawerController.selextedIndex == i)
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, i) => const SizedBox(height: 10),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,

              child: FloatingActionButton.extended(
                label: Text(
                  "Support",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                icon: CrmIc(iconPath: ICRes.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ),
            Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.center,

              child: FloatingActionButton.extended(
                backgroundColor: Get.theme.colorScheme.error,
                label: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Get.theme.colorScheme.surface,
                  ),
                ),
                icon: CrmIc(
                  iconPath: ICRes.logout,
                  color: Get.theme.colorScheme.surface,
                ),
                onPressed: () => Get.put(AuthController()).logout(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerController extends GetxController {
  RxInt selextedIndex = 0.obs;

  onchange(int index) => selextedIndex(index);
}

class DrawerModel {
  String? title;
  String? iconPath;
  Widget? widget;

  DrawerModel({this.title, this.iconPath, this.widget});
}
