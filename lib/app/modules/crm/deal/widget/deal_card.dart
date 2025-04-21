import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealCard extends StatelessWidget {
  final String? id;
  final String? dealTitle;
  final String? currency;
  final String? value;
  final String? pipeline;
  final String? stage;
  final String? status;
  final String? label;
  final String? closedDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? source;
  final String? companyName;
  final String? website;
  final String? address;
  final String? products;
  final String? files;
  final String? assignedTo;
  final String? clientId;
  final String? isWon;
  final String? companyId;
  final String? contactId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final Color? color;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const DealCard({
    super.key,
    this.id,
    this.color,
    this.dealTitle,
    this.currency,
    this.value,
    this.pipeline,
    this.stage,
    this.status,
    this.label,
    this.closedDate,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.source,
    this.companyName,
    this.website,
    this.address,
    this.files,
    this.assignedTo,
    this.clientId,
    this.isWon,
    this.companyId,
    this.contactId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onDelete,
    this.onEdit,
    this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        width: 500,
        height: 90,
        padding: const EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(15),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 75,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dealTitle.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            companyName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "$value.00",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            source.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(color: Get.theme.colorScheme.outline, height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            CrmIc(
                              iconPath: ICRes.task,
                              color: color,
                              width: 15,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              status.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          CrmIc(
                            iconPath: ICRes.calendar,
                            color: color,
                            width: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            createdAt.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
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
