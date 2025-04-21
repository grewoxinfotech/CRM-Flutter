import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';

class InvoiceCard extends StatelessWidget {
  final String? id;
  final String? inquiryId;
  final String? leadTitle;
  final String? leadStage;
  final String? pipeline;
  final String? currency;
  final String? leadValue;
  final String? companyName;
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? telephone;
  final String? email;
  final String? address;
  final String? leadMembers;
  final String? source;
  final String? category;
  final String? files;
  final String? status;
  final String? interestLevel;
  final String? leadScore;
  final String? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const InvoiceCard({
    super.key,
    this.id,
    this.inquiryId,
    this.leadTitle,
    this.leadStage,
    this.pipeline,
    this.currency,
    this.leadValue,
    this.companyName,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.telephone,
    this.email,
    this.address,
    this.leadMembers,
    this.source,
    this.category,
    this.files,
    this.status,
    this.interestLevel,
    this.leadScore,
    this.isConverted,
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
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text("id : ${id.toString()}"),
            Text("inquiryId : ${inquiryId.toString()}"),
            Text("leadTitle : ${leadTitle.toString()}"),
            Text("leadStage : ${leadStage.toString()}"),
            Text("pipeline : ${pipeline.toString()}"),
            Text("currency : ${currency.toString()}"),
            Text("leadValue : ${leadValue.toString()}"),
            Text("companyName : ${companyName.toString()}"),
            Text("firstName : ${firstName.toString()}"),
            Text("lastName : ${lastName.toString()}"),
            Text("phoneCode : ${phoneCode.toString()}"),
            Text("telephone : ${telephone.toString()}"),
            Text("email : ${email.toString()}"),
            Text("address : ${address.toString()}"),
            Text("leadMembers : ${leadMembers.toString()}"),
            Text("source : ${source.toString()}"),
            Text("category : ${category.toString()}"),
            Text("files : ${files.toString()}"),
            Text("status : ${status.toString()}"),
            Text("interestLevel : ${interestLevel.toString()}"),
            Text("leadScore : ${leadScore.toString()}"),
            Text("isConverted : ${isConverted.toString()}"),
            Text("clientId : ${clientId.toString()}"),
            Text("createdBy : ${createdBy.toString()}"),
            Text("updatedBy : ${updatedBy.toString()}"),
            Text("createdAt : ${createdAt.toString()}"),
            Text("updatedAt : ${updatedAt.toString()}"),
            Row(
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
          ],
        ),
      ),
    );
  }
}
