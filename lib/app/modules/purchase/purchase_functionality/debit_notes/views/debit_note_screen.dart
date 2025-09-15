import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../access/controller/access_controller.dart';
import '../binding/debit_note_binding.dart';
import '../controller/debit_note_controller.dart';
import '../widget/debit_note_card.dart';
import 'debit_note_add_screen.dart';
//
// class DebitNotesScreen extends StatelessWidget {
//   const DebitNotesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Lazy load the controller
//     Get.lazyPut(() => DebitNoteController());
//     final DebitNoteController controller = Get.find();
//
//     // Initial fetch
//     controller.fetchAllDebitNotes();
//
//     void _deleteDebitNote(String id, String name) {
//       Get.dialog(
//         CrmDeleteDialog(
//           entityType: name,
//           onConfirm: () async {
//             final success = await controller.deleteDebitNote(id);
//             if (success) {
//               Get.back();
//               CrmSnackBar.showAwesomeSnackbar(
//                 title: "Success",
//                 message: "Debit note deleted successfully",
//                 contentType: ContentType.success,
//               );
//             }
//           },
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Debit Notes")),
//       floatingActionButton: FloatingActionButton(
//         onPressed:
//             () =>
//                 Get.to(() => AddDebitNoteScreen(), binding: DebitNoteBinding()),
//         child: const Icon(Icons.add),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value && controller.debitNotes.isEmpty) {
//           return const Center(child: CrmLoadingCircle());
//         }
//
//         if (controller.debitNotes.isEmpty) {
//           return const Center(child: Text("No debit notes found."));
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.refreshDebitNotes,
//           child: ListView.builder(
//             itemCount: controller.debitNotes.length + 1,
//             itemBuilder: (context, index) {
//               if (index < controller.debitNotes.length) {
//                 final note = controller.debitNotes[index];
//                 return Stack(
//                   children: [
//                     DebitNoteCard(
//                       debitNote: note.debitNote,
//                       updatedBill: note.updatedBill,
//                     ),
//                     Positioned(
//                       right: 8,
//                       bottom: 8,
//                       child: Row(
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit, color: Colors.blue),
//                             onPressed: () {
//                               Get.to(() => AddDebitNoteScreen());
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               _deleteDebitNote(
//                                 note.debitNote.id ?? '',
//                                 note.debitNote.description ?? 'Debit Note',
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               } else if (controller.isLoading.value) {
//                 return const Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               } else {
//                 return const SizedBox.shrink();
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
// }

class DebitNotesScreen extends StatelessWidget {
  const DebitNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();

    final DebitNoteController controller = Get.put(DebitNoteController());

    void _deleteDebitNote(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteDebitNote(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Debit note deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Debit Notes")),
      floatingActionButton:
          accessController.can(AccessModule.debitNote, AccessAction.create)
              ? FloatingActionButton(
                onPressed:
                    () => Get.to(
                      () => AddDebitNoteScreen(),
                      binding: DebitNoteBinding(),
                    ),
                child: const Icon(Icons.add),
              )
              : null,
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return const Center(child: CrmLoadingCircle());
        }

        if (controller.items.isEmpty) {
          return const Center(child: Text("No debit notes found."));
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
                  final note = controller.items[index];
                  return Stack(
                    children: [
                      DebitNoteCard(
                        debitNote: note.debitNote,
                        updatedBill: note.updatedBill,
                      ),
                      Positioned(
                        right: 26,
                        bottom: 8,
                        child: Row(
                          children: [
                            // IconButton(
                            //   icon: const Icon(Icons.edit, color: Colors.blue),
                            //   onPressed: () {
                            //     Get.to(() => AddDebitNoteScreen());
                            //   },
                            // ),
                            if (accessController.can(
                              AccessModule.debitNote,
                              AccessAction.delete,
                            ))
                              CrmIc(
                                iconPath: ICRes.delete,
                                color: ColorRes.error,
                                onTap: () {
                                  _deleteDebitNote(
                                    note.debitNote.id ?? '',
                                    note.debitNote.description ?? 'Debit Note',
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (controller.isLoading.value) {
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
      }),
    );
  }
}
