import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteCard extends StatelessWidget {
  final String? id;
  final String? relatedId;
  final String? noteTitle;
  final String? noteType;
  final String? employees;
  final String? description;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;
  const NoteCard({super.key,
    this.id,
    this.relatedId,
    this.noteTitle,
    this.noteType,
    this.employees,
    this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text("id : $id"),
            Text("relatedId : $relatedId"),
            Text("noteTitle : $noteTitle"),
            Text("noteType : $noteType"),
            Text("employees : $employees"),
            Text("description : $description"),
            Text("clientId : $clientId"),
            Text("createdBy : $createdBy"),
            Text("updatedBy : $updatedBy"),
            Text("createdAt : $createdAt"),
            Text("updatedAt : $updatedAt"),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CrmIc(iconPath: ICRes.edit,color: success,onTap: onEdit,width: 50,),
                CrmIc(iconPath: ICRes.delete,color: error,onTap: onDelete,width: 50,),
              ],
            )
          ],
        ),),
    );
  }
}
