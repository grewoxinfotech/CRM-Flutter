import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileCard extends StatelessWidget {
  final String? id;
  final String? name;
  final String? role;
  final String? description;
  final String? file;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;
  const FileCard({super.key,
    this.id,
    this.name,
    this.role,
    this.description,
    this.file,
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
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text("id : $id"),
            Text("name : $name"),
            Text("role : $role"),
            Text("description : $description"),
            Text("file : $file"),
            Text("clientId : $clientId"),
            Text("createdBy : $createdBy"),
            Text("updatedBy : $updatedBy"),
            Text("createdAt : $createdAt"),
            Text("updatedAt : $updatedAt"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CrmIc(iconPath: ICRes.edit,color: ColorRes.success,onTap: onEdit,width: 50,),
                CrmIc(iconPath: ICRes.delete,color: ColorRes.error,onTap: onDelete,width: 50,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
