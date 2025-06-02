import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class ChatMessageCard extends StatefulWidget {
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
  State<ChatMessageCard> createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {
  bool _showMeta = false;

  void _toggleMeta() {
    setState(() {
      _showMeta = !_showMeta;
    });

    // Auto hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showMeta = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius;

    if (widget.isSender) {
      borderRadius = BorderRadius.only(
        topLeft: const Radius.circular(AppRadius.large),
        bottomLeft: const Radius.circular(AppRadius.large),
        bottomRight: Radius.circular(
          widget.isFirst ? AppRadius.medium : AppRadius.small,
        ),
        topRight: Radius.circular(
          widget.isLast ? AppRadius.medium : AppRadius.small,
        ),
      );
    } else {
      borderRadius = BorderRadius.only(
        bottomLeft: Radius.circular(
          widget.isFirst ? AppRadius.medium : AppRadius.small,
        ),
        topLeft: Radius.circular(
          widget.isLast ? AppRadius.medium : AppRadius.small,
        ),
        topRight: const Radius.circular(AppRadius.large),
        bottomRight: const Radius.circular(AppRadius.large),
      );
    }

    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onHorizontalDragEnd: (_) => _toggleMeta(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.3,
          ),
          child: CrmCard(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            boxShadow: [],
            color: widget.isSender ? AppColors.primary : Colors.white,
            borderRadius: borderRadius,
            child: Column(
              crossAxisAlignment:
                  widget.isSender
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isSender ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_showMeta) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        widget.isSender
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      if (widget.isSender) ...[
                        const SizedBox(width: 8),
                        Icon(
                          widget.isSeen ? Icons.done_all : Icons.check,
                          size: 14,
                          color:
                              widget.isSeen
                                  ? Colors.blue
                                  : Colors.grey.shade800,
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
