import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
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

  const NoteTile({
    super.key,
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
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Note Data"),
            SizedBox(height: 10,),
            Text("id : ${id.toString()}"),
            Text("relatedId : ${relatedId.toString()}"),
            Text("noteTitle : ${noteTitle.toString()}"),
            Text("noteType : ${noteType.toString()}"),
            Text("employees : ${employees.toString()}"),
            Text("description : ${description.toString()}"),
            Text("clientId : ${clientId.toString()}"),
            Text("createdBy : ${createdBy.toString()}"),
            Text("updatedBy : ${updatedBy.toString()}"),
            Text("createdAt : ${createdAt.toString()}"),
            Text("updatedAt : ${updatedAt.toString()}"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CrmIc(
                    iconPath: ICRes.delete,
                    onTap: onDelete,
                    color: ColorRes.error,
                  ),
                  CrmIc(
                    iconPath: ICRes.edit,
                    onTap: onEdit,
                    color: ColorRes.success,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
