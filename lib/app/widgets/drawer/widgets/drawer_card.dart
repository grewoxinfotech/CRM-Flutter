import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';

class DrawerCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? iconData;
  final String? title;
  final Color? color;
  final bool? isSelected;

  const DrawerCard({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.title,
    required this.color,
    this.isSelected,
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
                      Icon(iconData, color: color, size: 18),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
