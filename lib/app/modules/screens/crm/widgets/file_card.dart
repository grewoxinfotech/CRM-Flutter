import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FileCard extends StatelessWidget {
  final FileModel? file;

  const FileCard({Key? key,this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      padding: EdgeInsets.all(14),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: CrmIc(icon: LucideIcons.image, color: AppColors.primary),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "N/A",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "N/A",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            child: CrmIc(
              icon: LucideIcons.moreVertical,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
