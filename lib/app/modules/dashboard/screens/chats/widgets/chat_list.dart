import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/chats/widgets/chat_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewScreen(
      padding: EdgeInsets.all(AppMargin.medium),
      itemCount: 10,
      itemBuilder: (context, i) => ChatCard(),
    );
  }
}
