import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/const/page_const.dart';
import '../../../app/global/widgets/list_tile_content.dart';
import '../../../app/theme/style.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTileContent(
              onTap: () {
                Navigator.pushNamed(context, PageConst.singleChatPage);
              },
              title: "Username",
              subTitleWidget: const Text(
                "Last message hi",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailingWidget: Text(
                DateFormat.jm().format(DateTime.now()),
                style: const TextStyle(color: greyColor, fontSize: 13),
              ),
            );
          }),
    );
  }
}
