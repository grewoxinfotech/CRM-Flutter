import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FunctionCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final IconData? icon;
  final Color? color;

  const FunctionCard({
    super.key,
    this.icon,
    this.color,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: EdgeInsets.all(AppPadding.medium),
        border: Border.all(color:AppColors. divider),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              (title != null)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
          children: [
            Icon(icon ?? LucideIcons.filePlus, color: color, size: 18),
            if (title != null) ...[
              AppSpacing.horizontalSmall,
              Expanded(
                child: Text(
                  title.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
