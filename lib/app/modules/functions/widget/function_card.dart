import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        child: CrmCard(
          padding: EdgeInsets.all(AppPadding.medium),
          gradient: LinearGradient(
            colors: [color!.withAlpha(160), color!.withAlpha(255)],
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
          ),
          boxShadow: [],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon ?? FontAwesomeIcons.at, color: white, size: 18),
              AppSpacing.horizontalSmall,
              Expanded(
                child: Text(
                  title.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: white,
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
