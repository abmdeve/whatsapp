import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp/features/app/const/message_type_const.dart';
import 'package:whatsapp/features/chat/domain/entities/message_reply_entity.dart';
import 'package:whatsapp/features/chat/presentation/widget/message_widget/message_type_widget.dart';

import '../../../chat/presentation/widget/message_widget/message_replay_type_widget.dart';
import '../../theme/style.dart';

class MessageLayout extends StatelessWidget {
  final Color? messageColor;
  final Alignment? alignment;

  //final DateTime? createAt;
  final Timestamp? createAt;
  final Function(DragUpdateDetails)? onSwipe;

  //final VoidCallback? onSwipe;

  //final double? rightPadding;
  final String? message;
  final String? messageType;
  final bool? isShowTick;
  final bool? isSeen;
  final VoidCallback? onLongPress;
  final MessageReplyEntity? reply;
  final double? rightPadding;
  final String? recipientName;

  const MessageLayout({
    super.key,
    this.alignment,
    this.message,
    this.messageType,
    this.createAt,
    this.messageColor,
    //this.rightPadding,
    this.isShowTick,
    this.isSeen,
    this.onLongPress,
    this.onSwipe,
    this.reply,
    this.rightPadding,
    this.recipientName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SwipeTo(
        onRightSwipe: onSwipe,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            alignment: alignment,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(
                            left: 5,
                            right: messageType == MessageTypeConst.textMessage
                                ? rightPadding!
                                : 5,
                            top: 5,
                            bottom: 5),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.80),
                        decoration: BoxDecoration(
                            color: messageColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reply?.message == null || reply?.message == ""
                                ? const SizedBox()
                                : Container(
                                    height: reply!.messageType ==
                                            MessageTypeConst.textMessage
                                        ? 70
                                        : 80,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: 4.5,
                                          decoration: BoxDecoration(
                                              color: reply!.username ==
                                                      recipientName
                                                  ? Colors.deepPurpleAccent
                                                  : tabColor,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      bottomLeft:
                                                          Radius.circular(15))),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0, vertical: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${reply!.username == recipientName ? reply!.username : "You"}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: reply!.username ==
                                                              recipientName
                                                          ? Colors
                                                              .deepPurpleAccent
                                                          : tabColor),
                                                ),
                                                MessageReplayTypeWidget(
                                                  message: reply!.message,
                                                  type: reply!.messageType,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            const SizedBox(
                              height: 3,
                            ),
                            MessageTypeWidget(
                              message: message,
                              type: messageType,
                            ),
                          ],
                        )),
                    const SizedBox(height: 3),
                  ],
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(DateFormat.jm().format(createAt!.toDate()),
                          style:
                              const TextStyle(fontSize: 12, color: greyColor)),
                      const SizedBox(
                        width: 5,
                      ),
                      isShowTick == true
                          ? Icon(
                              isSeen == true ? Icons.done_all : Icons.done,
                              size: 16,
                              color: isSeen == true ? Colors.blue : greyColor,
                            )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
