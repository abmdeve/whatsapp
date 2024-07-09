import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:whatsapp/features/chat/presentation/cubit/chat/chat_state.dart';

import '../../../app/const/page_const.dart';
import '../../../app/global/widgets/list_tile_content.dart';
import '../../../app/theme/style.dart';

class ChatPage extends StatefulWidget {
  final String uid;

  const ChatPage({super.key, required this.uid});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ChatCubit>(context)
        .getMyChat(chat: ChatEntity(senderUid: widget.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            final myChat = state.chatContacts;

            if (myChat.isEmpty) {
              return Center(
                child: Text(
                  "NO CONVERSATION YET!",
                  style: TextStyle(color: textColor),
                ),
              );
            }

            return ListView.builder(
                itemCount: myChat.length,
                itemBuilder: (context, index) {
                  final chat = myChat[index];
                  return ListTileContent(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PageConst.singleChatPage,
                        arguments: MessageEntity(
                          senderUid: chat.senderUid,
                          recipientUid: chat.recipientUid,
                          senderName: chat.senderName,
                          recipientName: chat.recipientName,
                          senderProfile: chat.senderProfile,
                          recipientProfile: chat.recipientProfile,
                        ),
                      );
                    },
                    title: "${chat.recipientName}",
                    subTitleWidget: Text(
                      "${chat.recentTextMessage}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailingWidget: Text(
                      DateFormat.jm().format(chat.createAt!.toDate()),
                      style: const TextStyle(color: greyColor, fontSize: 13),
                    ),
                  );
                });
          }

          return Center(
            child: CircularProgressIndicator(
              color: tabColor,
            ),
          );
        },
      ),
    );
  }
}
