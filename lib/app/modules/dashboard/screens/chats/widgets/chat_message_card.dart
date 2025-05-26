import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class ChatMessageCard extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;
  final bool isFirst;
  final bool isLast;
  final bool isSeen;

  const ChatMessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.isSender,
    required this.isFirst,
    required this.isLast,
    required this.isSeen,
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius;

    if (isSender) {
      borderRadius = BorderRadius.only(
        topLeft: const Radius.circular(AppRadius.large),
        bottomLeft: const Radius.circular(AppRadius.large),
        bottomRight: Radius.circular(
          isFirst ? AppRadius.large : AppRadius.small,
        ),
        topRight: Radius.circular(isLast ? AppRadius.large : AppRadius.small),
      );
    } else {
      borderRadius = BorderRadius.only(
        bottomLeft: Radius.circular(
          isFirst ? AppRadius.large : AppRadius.small,
        ),
        topLeft: Radius.circular(isLast ? AppRadius.large : AppRadius.small),
        topRight: const Radius.circular(AppRadius.large),
        bottomRight: const Radius.circular(AppRadius.large),
      );
    }

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: CrmCard(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          boxShadow: [],
          color: isSender ? primary : white,
          borderRadius: borderRadius,
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  color: isSender ? white : textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
