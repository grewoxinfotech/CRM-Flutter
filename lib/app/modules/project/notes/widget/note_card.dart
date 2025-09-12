// import 'package:crm_flutter/app/care/constants/color_res.dart';
// import 'package:crm_flutter/app/care/constants/ic_res.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../care/constants/access_res.dart';
// import '../../../access/controller/access_controller.dart';
//
// class NoteCard extends StatelessWidget {
//   final String? id;
//   final String? relatedId;
//   final String? noteTitle;
//   final String? noteType;
//   final String? employees;
//   final String? description;
//   final String? clientId;
//   final String? createdBy;
//   final String? updatedBy;
//   final String? createdAt;
//   final String? updatedAt;
//   final GestureTapCallback? onTap;
//   final GestureTapCallback? onDelete;
//   final GestureTapCallback? onEdit;
//   const NoteCard({super.key,
//     this.id,
//     this.relatedId,
//     this.noteTitle,
//     this.noteType,
//     this.employees,
//     this.description,
//     this.clientId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//     this.onTap,
//     this.onEdit,
//     this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final accessController = Get.find<AccessController>();
//     return GestureDetector(
//       onTap: onTap,
//       child: CrmCard(padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Text("id : $id"),
//             Text("relatedId : $relatedId"),
//             Text("noteTitle : $noteTitle"),
//             Text("noteType : $noteType"),
//             Text("employees : $employees"),
//             Text("description : $description"),
//             Text("clientId : $clientId"),
//             Text("createdBy : $createdBy"),
//             Text("updatedBy : $updatedBy"),
//             Text("createdAt : $createdAt"),
//             Text("updatedAt : $updatedAt"),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 if(accessController.can(AccessModule.deal, AccessAction.update)&&accessController.can(AccessModule.salesInvoice, AccessAction.update))
//                 CrmIc(iconPath: ICRes.edit,color: ColorRes.success,onTap: onEdit,width: 50,),
//                 if(accessController.can(AccessModule.deal, AccessAction.delete)&&accessController.can(AccessModule.salesInvoice, AccessAction.delete))
//                 CrmIc(iconPath: ICRes.delete,color: ColorRes.error,onTap: onDelete,width: 50,),
//               ],
//             )
//           ],
//         ),),
//     );
//   }
// }

import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/widget/common_widget.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/access_res.dart';
import '../../../access/controller/access_controller.dart';

class NoteCard extends StatelessWidget {
  final String? noteTitle;
  final String? noteType;
  final String? description;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const NoteCard({
    super.key,
    this.noteTitle,
    this.noteType,
    this.description,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final accessController = Get.find<AccessController>();
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  noteTitle ?? "-",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (noteType != null)
                  CommonWidget.buildChips(noteType!),
              ],
            ),

            const SizedBox(height: 6),

            /// Description
            Text(
              description ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),



            /// Note Type
            // Text(
            //   "Type: ${noteType ?? "-"}",
            //   style: Theme.of(context).textTheme.labelMedium?.copyWith(
            //     color: Colors.grey[600],
            //   ),
            // ),




            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(onEdit != null)
                  CrmIc(
                    iconPath: ICRes.edit,
                    color: ColorRes.success,
                    onTap: onEdit,

                  ),
                SizedBox(width: 12),
               if(onDelete != null)
                  CrmIc(
                    iconPath: ICRes.delete,
                    color: ColorRes.error,
                    onTap: onDelete,

                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
