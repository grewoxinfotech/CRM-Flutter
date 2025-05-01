import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileCard extends StatelessWidget {
  final String? id;
  final String? url;
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
    this.url,
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
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;
    double cardHeight = 100;
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        height: cardHeight,
        shadowColor: Get.theme.colorScheme.surface,
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          children: [
            Container(
              height: cardHeight,
              width: cardHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(url.toString()),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(AppRadius.large),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(AppPadding.small),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      "$id",
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppRadius.small,
                            ),
                            border: Border.all(color: textPrimary),
                          ),
                          child: Text(
                            role.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: textPrimary,
                            ),
                          ),
                        ),
                        CrmIc(
                          iconPath: ICRes.delete,
                          color: Get.theme.colorScheme.error,
                          onTap: onDelete,
                        ),
                      ],
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
