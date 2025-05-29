import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DrawerCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? iconData;
  final String? title;
  final Color? color;
  final Color? iconColor;
  final bool? isSelected;
  final bool? showArrowRight;

  const DrawerCard({
    super.key,
    required this.title,
    this.onTap,
    this.iconData,
    this.color,
    this.iconColor,
    this.isSelected,
    this.showArrowRight = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Container(
          height: 45,
          color: (isSelected == true) ? color!.withAlpha(50) : null,
          child: Row(
            children: [
              Container(
                width: 5,
                decoration: BoxDecoration(
                  color: (isSelected == true) ? color : null,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(AppPadding.small),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  iconData,
                                  color: iconColor ?? color,
                                  size: 18,
                                ),
                                AppSpacing.horizontalSmall,
                                Text(
                                  title!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                        (isSelected == true)
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      (showArrowRight == true)
                          ? Icon(
                            LucideIcons.chevronRight,
                            size: 16,
                            color: AppColors.divider,
                          )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
