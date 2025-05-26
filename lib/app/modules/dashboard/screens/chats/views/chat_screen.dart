import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/chats/widgets/chat_message_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = MessageModel.getMessages();

    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(),
        backgroundColor: white,
        title: Text("Jay Babariya"),
        actionsPadding: EdgeInsets.only(right: AppPadding.medium),
        actions: [Icon(Icons.ac_unit_rounded)],
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ViewScreen(
                separatorWidget: SizedBox(height: 2),
                padding: EdgeInsets.symmetric(horizontal:  AppMargin.medium,vertical: AppPadding.small),
                itemCount: messages.length,
                reverse: true,
                itemBuilder:
                    (context, i) => ChatMessageCard(
                      message: messages[i].message!,
                      time: messages[i].time!,
                      isSender: messages[i].isSender!,
                      isFirst: messages[i].isFirst!,
                      isLast: messages[i].isLast!,
                      isSeen: messages[i].isSeen!,
                    ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
            child: CrmTextField(
              contentPadding: EdgeInsets.all(AppPadding.medium),
              hintText: "Messaging",
              suffixIcon: CrmIc(iconPath: Ic.send, width: 20),
            ),
          ),
          AppSpacing.verticalMedium,
        ],
      ),
    );
  }
}

class MessageModel {
  final String? message;
  final String? time;
  final bool? isSender;
  final bool? isFirst;
  final bool? isLast;
  final bool? isSeen;

  MessageModel({
    this.message,
    this.time,
    this.isSender,
    this.isFirst,
    this.isLast,
    this.isSeen,
  });

  static List<MessageModel> getMessages() {
    return [
      MessageModel(
        message: "hii...",
        isSender: false,
        isFirst: true,
        isLast: true,
        isSeen: true,

        time: "05:25am",
      ),
      MessageModel(
        message: "hii?",
        isSender: true,
        isFirst: true,
        isLast: false,
        isSeen: true,

        time: "05:25am",
      ),
      MessageModel(
        message: "what do you do?",
        isSender: true,
        isFirst: false,
        isLast: false,
        isSeen: false,

        time: "05:25am",
      ),
      MessageModel(
        message: "bol ne bhai",
        isSender: true,
        isFirst: false,
        isLast: true,
        isSeen: true,

        time: "05:25am",
      ),
      MessageModel(
        message: "kai nai moj ma",
        isSender: false,
        isFirst: true,
        isLast: false,
        isSeen: false,

        time: "05:25am",
      ),
      MessageModel(
        message: "tu bol",
        isSender: false,
        isFirst: false,
        isLast: true,
        isSeen: true,

        time: "05:25am",
      ),
      MessageModel(
        message: "bus shanti.",
        isSender: true,
        isFirst: true,
        isLast: true,
        isSeen: false,

        time: "05:25am",
      ),
    ];
  }
}
