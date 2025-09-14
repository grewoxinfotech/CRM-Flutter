import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../../access/controller/access_controller.dart';
import '../controllers/offer_letter_controller.dart';
import '../widget/offer_letter_card.dart';
import 'add_offer_letter_screen.dart';



class OfferLetterScreen extends StatelessWidget {
  OfferLetterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();

    Get.lazyPut<OfferLetterController>(() => OfferLetterController());
    final OfferLetterController controller = Get.find();

    void _deleteOfferLetter(String id) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: "Offer Letter",
          onConfirm: () async {
            final success = await controller.deleteOfferLetter(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Offer letter deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Offer Letters")),
      floatingActionButton:
      accessController.can(AccessModule.jobOfferLetter, AccessAction.create)
          ? FloatingActionButton(
        onPressed: () {
          controller.resetForm();
          Get.to(() => AddOfferLetterScreen());
        },
        child: const Icon(Icons.add, color: Colors.white),
      )
          : null,
      body: FutureBuilder(
        future: controller.loadInitial(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CrmLoadingCircle());
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Server Error:\n${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              if (!controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: Text("No Offer Letters found."));
              }
              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge && metrics.pixels != 0) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: controller.refreshList,
                  child: ViewScreen(
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final offerLetter = controller.items[index];
                        return Stack(
                          children: [
                            OfferLetterCard(offerLetter: offerLetter),
                            Positioned(
                              right: 26,
                              bottom: 8,
                              child: Row(
                                children: [
                                  if (accessController.can(
                                    AccessModule.jobOfferLetter,
                                    AccessAction.update,
                                  ))
                                    CrmIc(
                                      iconPath: ICRes.edit,
                                      color: ColorRes.success,
                                      onTap: () {
                                        Get.to(
                                              () => AddOfferLetterScreen(
                                            offerLetter: offerLetter,
                                            isFromEdit: true,
                                          ),
                                        );
                                      },
                                    ),
                                  const SizedBox(width: 12),
                                  if (accessController.can(
                                    AccessModule.jobOfferLetter,
                                    AccessAction.delete,
                                  ))
                                    CrmIc(
                                      iconPath: ICRes.delete,
                                      color: ColorRes.error,
                                      onTap: () {
                                        _deleteOfferLetter(
                                          offerLetter.id ?? '',
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (controller.isPaging.value) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              );
            });
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
