import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String? id;
  final String? project;
  final String? startDate;
  final String? endDate;
  final String? projectMembers;
  final String? completion;
  final String? status;
  final String? clientId;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const PaymentCard({
    super.key,
    this.id,
    this.project,
    this.startDate,
    this.endDate,
    this.projectMembers,
    this.completion,
    this.status,
    this.clientId,
    this.createdBy,
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
      child: CrmCard(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text("id : $id"),
            Text("project : $project"),
            Text("startDate : $startDate"),
            Text("endDate : $endDate"),
            Text("projectMembers : $projectMembers"),
            Text("completion : $completion"),
            Text("status : $status"),
            Text("clientId : $clientId"),
            Text("createdBy : $createdBy"),
            Text("createdAt : $createdAt"),
            Text("updatedAt : $updatedAt"),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CrmIc(
                  iconPath: ICRes.edit,
                  color: ColorRes.success,
                  onTap: onEdit,
                  width: 50,
                ),
                CrmIc(
                  iconPath: ICRes.delete,
                  color: ColorRes.error,
                  onTap: onDelete,
                  width: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
