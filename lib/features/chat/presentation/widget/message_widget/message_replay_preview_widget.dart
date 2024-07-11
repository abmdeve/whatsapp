import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/app/const/message_type_const.dart';
import 'package:whatsapp/features/app/theme/style.dart';
import 'package:whatsapp/features/chat/presentation/cubit/message/message_cubit.dart';

import 'message_replay_type_widget.dart';

class MessageReplayPreviewWidget extends StatelessWidget {
  final VoidCallback? onCancelReplayListener;

  const MessageReplayPreviewWidget({super.key, this.onCancelReplayListener});

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<MessageCubit>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: provider.messageReplay.messageType == MessageTypeConst.textMessage
          ? 70
          : 100,
      decoration: BoxDecoration(
        color: appBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor.withOpacity(4),
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 3.5,
              decoration: BoxDecoration(
                color: provider.messageReplay.isMe == true
                    ? tabColor
                    : Colors.deepPurpleAccent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${provider.messageReplay.isMe == true ? "You" : provider.messageReplay.username}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: provider.messageReplay.isMe == true
                                    ? tabColor
                                    : Colors.deepPurpleAccent),
                          ),
                        ),
                        GestureDetector(
                          onTap: onCancelReplayListener,
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    provider.messageReplay.messageType ==
                            MessageTypeConst.textMessage
                        ? Text(
                            "${provider.messageReplay.message}",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 12,
                                color: greyColor,
                                overflow: TextOverflow.ellipsis),
                          )
                        : Row(
                            children: [
                              MessageReplayTypeWidget(
                                message: provider.messageReplay.message,
                                type: provider.messageReplay.messageType,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
