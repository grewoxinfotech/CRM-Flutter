import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/super_admin/auth/controllers/auth_controller.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../care/constants/string_res.dart';
import '../../modules/job/job_functions/view/job_screen.dart';
//
// class CrmDrawer extends StatelessWidget {
//   const CrmDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<CustomDrawerController>(() => CustomDrawerController());
//     CustomDrawerController drawerController = Get.find();
//     List<DrawerModel> items = [
//       DrawerModel(title: "DashBoard", iconPath: ICRes.dashboard),
//       DrawerModel(title: "CRM", iconPath: ICRes.crm),
//       DrawerModel(title: "Sales", iconPath: ICRes.sales),
//       DrawerModel(title: "Purchase", iconPath: ICRes.purchase),
//       DrawerModel(title: "Hrm", iconPath: ICRes.hrm),
//       DrawerModel(title: "Job", iconPath: ICRes.notifications),
//     ];
//     Widget divider = Divider(
//       height: 0,
//       color: Get.theme.dividerColor,
//       endIndent: 10,
//       indent: 10,
//     );
//
//     return SafeArea(
//       child: CrmCard(
//         boxShadow: [],
//         width: Get.width * 0.6,
//         margin: const EdgeInsets.only(
//           left: AppPadding.small,
//           bottom: AppPadding.small,
//         ),
//         borderRadius: BorderRadius.circular(AppRadius.large),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CrmAppLogo(),
//                   SizedBox(width: 12),
//                   Text(
//                     "Grewox",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),
//             ),
//             // SizedBox(height: AppPadding.medium),
//             ListView.separated(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: items.length,
//               padding: EdgeInsets.all(AppPadding.small),
//               shrinkWrap: true,
//               itemBuilder: (context, i) {
//                 return Obx(
//                   () => GestureDetector(
//                     onTap: () {
//                       drawerController.onchange(i);
//                       // Get.back();
//                     },
//                     child: CrmCard(
//                       padding: const EdgeInsets.all(AppPadding.small),
//                       boxShadow: [],
//                       borderRadius: BorderRadius.circular(
//                         AppRadius.large - AppPadding.small,
//                       ),
//                       color:
//                           (drawerController.selextedIndex == i)
//                               ? Get.theme.colorScheme.primary.withAlpha(20)
//                               : null,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           CrmIc(
//                             iconPath: items[i].iconPath.toString(),
//                             width: 18,
//                             color:
//                                 (drawerController.selextedIndex == i)
//                                     ? Get.theme.colorScheme.primary
//                                     : Get.theme.colorScheme.onSecondary,
//                           ),
//                           AppSpacing.horizontalSmall,
//                           Text(
//                             items[i].title.toString(),
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight:
//                                   (drawerController.selextedIndex == i)
//                                       ? FontWeight.w700
//                                       : FontWeight.w600,
//                               color:
//                                   (drawerController.selextedIndex == i)
//                                       ? Get.theme.colorScheme.primary
//                                       : Get.theme.colorScheme.onSecondary,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, i) => AppSpacing.verticalSmall,
//             ),
//             AppSpacing.verticalSmall,
//             Align(
//               alignment: Alignment.center,
//               child: FloatingActionButton.extended(
//                 label: Text(
//                   "Support",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//                 icon: CrmIc(iconPath: ICRes.notifications, color: Colors.white),
//                 onPressed: () {},
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: EdgeInsets.all(AppPadding.medium),
//               child: GestureDetector(
//                 onTap: () => Get.put(AuthController()).logout(),
//                 child: Row(
//                   children: [
//                     CrmIc(
//                       iconPath: ICRes.logout,
//                       color: Get.theme.colorScheme.onSecondary,
//                     ),
//                     AppSpacing.horizontalSmall,
//                     Text(
//                       "Logout",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: Get.theme.colorScheme.onSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomDrawerController extends GetxController {
//   final NavigationController navigationController = Get.find();
//   RxInt selextedIndex =0.obs;
//   @override
//   void onInit() {
//     selextedIndex.value=navigationController.currentIndex.value;
//     super.onInit();
//   }
//
//
//
//   onchange(int index) {
//     if (index == 5) {
//       Get.to(() => JobScreen());
//       return selextedIndex(index);
//     }
//     navigationController.changeIndex(index);
//     Get.back();
//     return selextedIndex(index);
//   }
// }
//
// class DrawerModel {
//   String? title;
//   String? iconPath;
//   Widget? widget;
//
//   DrawerModel({this.title, this.iconPath, this.widget});
// }

class CrmDrawer extends StatelessWidget {
  const CrmDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CustomDrawerController>(() => CustomDrawerController());
    final drawerController = Get.find<CustomDrawerController>();

    final items = [
      DrawerModel(title: "DashBoard", iconPath: ICRes.dashboard),
      DrawerModel(title: "CRM", iconPath: ICRes.crm),
      DrawerModel(title: "Sales", iconPath: ICRes.sales),
      DrawerModel(title: "Purchase", iconPath: ICRes.purchase),
      DrawerModel(title: "Hrm", iconPath: ICRes.hrm),
      DrawerModel(title: "Job", iconPath: ICRes.notifications),
    ];

    return SafeArea(
      child: CrmCard(
        boxShadow: [],
        width: Get.width * 0.6,
        margin: const EdgeInsets.only(
          left: AppPadding.small,
          bottom: AppPadding.small,
        ),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Logo + Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CrmAppLogo(),
                  const SizedBox(width: 12),
                  Text(
                    StringRes.appName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),

            /// Drawer Items
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(AppPadding.small),
              itemCount: items.length,
              itemBuilder: (context, i) {
                return Obx(
                  () => GestureDetector(
                    onTap: () => drawerController.onChange(i),
                    child: CrmCard(
                      padding: const EdgeInsets.all(AppPadding.small),
                      boxShadow: [],
                      borderRadius: BorderRadius.circular(
                        AppRadius.large - AppPadding.small,
                      ),
                      color:
                          drawerController.selectedIndex.value == i
                              ? Get.theme.colorScheme.primary.withAlpha(20)
                              : null,
                      child: Row(
                        children: [
                          CrmIc(
                            iconPath: items[i].iconPath!,
                            width: 18,
                            color:
                                drawerController.selectedIndex.value == i
                                    ? Get.theme.colorScheme.primary
                                    : Get.theme.colorScheme.onSecondary,
                          ),
                          AppSpacing.horizontalSmall,
                          Text(
                            items[i].title!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  drawerController.selectedIndex.value == i
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                              color:
                                  drawerController.selectedIndex.value == i
                                      ? Get.theme.colorScheme.primary
                                      : Get.theme.colorScheme.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => AppSpacing.verticalSmall,
            ),

            AppSpacing.verticalSmall,

            /// Support Button
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: ElevatedButton.icon(
            //       style: ElevatedButton.styleFrom(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(AppRadius.medium),
            //         ),
            //       ),
            //       onPressed: () {},
            //       icon: CrmIc(iconPath: ICRes.notifications, color: Colors.white),
            //       label: const Text(
            //         "Support",
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            //       ),
            //     ),
            //   ),
            // ),
            const Spacer(),

            /// Logout
            Padding(
              padding: const EdgeInsets.all(AppPadding.medium),
              child: GestureDetector(
                onTap: () {
                  Get.lazyPut<AuthController>(() => AuthController());
                  Get.find<AuthController>().logout();
                },
                child: Row(
                  children: [
                    CrmIc(
                      iconPath: ICRes.logout,
                      color: Get.theme.colorScheme.onSecondary,
                    ),
                    AppSpacing.horizontalSmall,
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Get.theme.colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerController extends GetxController {
  final NavigationController navigationController = Get.find();
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    /// initial sync
    selectedIndex.value = navigationController.currentIndex.value;

    /// keep synced with navigation controller
    ever(navigationController.currentIndex, (index) {
      selectedIndex.value = index as int;
    });
  }

  void onChange(int index) {
    if (index == 5) {
      Get.to(() => JobScreen());
    } else {
      navigationController.changeIndex(index);
      Get.back();
    }
    // still set it manually in case user taps drawer item
    selectedIndex.value = index;
  }
}

class DrawerModel {
  final String? title;
  final String? iconPath;
  final Widget? widget;

  DrawerModel({this.title, this.iconPath, this.widget});
}
