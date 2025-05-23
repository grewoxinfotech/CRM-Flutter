import 'package:flutter/material.dart';

class CrmIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color? color;
  final bool defaultActive;

  const CrmIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.color,
    this.defaultActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate responsive sizes but with smaller proportions
    final buttonWidth = (screenWidth - 64) / 3.5;
    final buttonHeight = buttonWidth * 0.65;
    final iconSize = buttonWidth * 0.22;
    final fontSize = buttonWidth * 0.12;

    return Container(
      width: buttonWidth,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: defaultActive 
            ? (color ?? Theme.of(context).primaryColor).withOpacity(1)
            : (color ?? Theme.of(context).primaryColor).withOpacity(0.8),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: (color ?? Theme.of(context).primaryColor).withOpacity(0.15),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
          if (defaultActive)
            BoxShadow(
              color: (color ?? Theme.of(context).primaryColor).withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: [
              // Centered content
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: iconSize,
                        color: Colors.white,
                      ),
                      SizedBox(height: buttonHeight * 0.08),
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: defaultActive ? FontWeight.w600 : FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              // Active indicator
              if (defaultActive)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
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
