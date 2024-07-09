import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp/features/app/const/message_type_const.dart';
import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp/features/chat/presentation/cubit/message/message_state.dart';

import '../../../app/global/widgets/attach_window_item.dart';
import '../../../app/global/widgets/bacgroung_image_widget.dart';
import '../../../app/global/widgets/input_single_chat.dart';
import '../../../app/global/widgets/message_layout.dart';
import '../../../app/global/widgets/user_image.dart';
import '../../../app/theme/style.dart';

class SingleChatPage extends StatefulWidget {
  final MessageEntity message;

  const SingleChatPage({super.key, required this.message});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final TextEditingController _textMessageController = TextEditingController();
  bool _isDisplaySendButton = false;
  bool _isShowAttachWindow = false;

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<MessageCubit>(context).getMessages(
        message: MessageEntity(
      senderUid: widget.message.senderUid,
      recipientUid: widget.message.recipientUid,
    ));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: textColor,
              ),
            ),
            const UserImage(
              size: 35,
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.message.recipientName}",
              style: TextStyle(color: textColor),
            ),
            Text(
              "Online",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                  color: textColor),
            ),
          ],
        ),
        actions: const [
          Icon(
            Icons.videocam,
            size: 25,
            color: textColor,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.call,
            size: 25,
            color: textColor,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.more_vert,
            size: 25,
            color: textColor,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: BlocBuilder<MessageCubit, MessageState>(builder: (context, state) {
        if (state is MessageLoaded) {
          final messages = state.messages;
          return GestureDetector(
            onTap: () {
              setState(() {
                _isShowAttachWindow = false;
              });
            },
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          if (message.senderUid == widget.message.senderUid) {
                            return MessageLayout(
                              message: message.message,
                              alignment: Alignment.centerRight,
                              createAt: message.createAt,
                              isSeen: false,
                              isShowTick: true,
                              messageColor: senderMessageColor,
                              onLongPress: () {},
                              //onSwipe: (){},
                            );
                          } else {
                            return MessageLayout(
                              message: message.message,
                              alignment: Alignment.centerLeft,
                              createAt: message.createAt,
                              isSeen: false,
                              isShowTick: false,
                              messageColor: messageColor,
                              onLongPress: () {},
                              //onSwipe: (){},
                            );
                          }
                        },
                      ),
                    ),
                    InputSingleChat(
                      onSendMessage: (){
                        _sendMessage();
                      },
                      onTap: () {
                        setState(() {
                          _isShowAttachWindow = false;
                        });
                      },
                      textMessageController: _textMessageController,
                      isDisplaySendButton: _isDisplaySendButton,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _isDisplaySendButton = true;
                          });
                        } else {
                          setState(() {
                            _isDisplaySendButton = false;
                          });
                        }
                      },
                      onAttachedFileClicked: () {
                        setState(() {
                          _isShowAttachWindow = !_isShowAttachWindow;
                        });
                      },
                    ),
                  ],
                ),
                _isShowAttachWindow == true
                    ? Positioned(
                        bottom: 65,
                        top: 340,
                        left: 15,
                        right: 15,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.20,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 20),
                          decoration: BoxDecoration(
                            //color: Colors.grey,
                            color: bottomAttachContainerColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AttachWindowItem(
                                    icon: Icons.document_scanner,
                                    color: Colors.deepPurpleAccent,
                                    title: "Document",
                                    onTap: () {},
                                  ),
                                  AttachWindowItem(
                                    icon: Icons.camera_alt,
                                    color: Colors.pinkAccent,
                                    title: "Camera",
                                    onTap: () {},
                                  ),
                                  AttachWindowItem(
                                    icon: Icons.image,
                                    color: Colors.purpleAccent,
                                    title: "Gallery",
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AttachWindowItem(
                                    icon: Icons.headphones,
                                    color: Colors.deepOrange,
                                    title: "Audio",
                                    onTap: () {},
                                  ),
                                  AttachWindowItem(
                                    icon: Icons.location_on,
                                    color: Colors.green,
                                    title: "Location",
                                    onTap: () {},
                                  ),
                                  AttachWindowItem(
                                    icon: Icons.account_circle,
                                    color: Colors.deepPurpleAccent,
                                    title: "Contacts",
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AttachWindowItem(
                                    icon: Icons.bar_chart,
                                    color: tabColor,
                                    title: "Poll",
                                    onTap: () {},
                                  ),
                                  AttachWindowItem(
                                    icon: Icons.gif_box_outlined,
                                    color: Colors.indigoAccent,
                                    title: "Gif",
                                    onTap: () {},
                                  ),
                                  AttachWindowItem(
                                    icon: Icons.videocam,
                                    color: Colors.lightGreen,
                                    title: "Video",
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: tabColor,
          ),
        );
      }),
    );
  }

  void _sendMessage() {
    BlocProvider.of<MessageCubit>(context).sendMessage(
      chat: ChatEntity(
        senderUid: widget.message.senderUid,
        recipientUid: widget.message.recipientUid,
        senderName: widget.message.senderName,
        recipientName: widget.message.recipientName,
        senderProfile: widget.message.senderProfile,
        recipientProfile: widget.message.recipientProfile,
        createAt: Timestamp.now(),
        totalUnReadMessages: 0,
      ),
      message: MessageEntity(
        senderUid: widget.message.senderUid,
        recipientUid: widget.message.recipientUid,
        senderName: widget.message.senderName,
        recipientName: widget.message.recipientName,
        messageType: MessageTypeConst.textMessage,
        repliedTo: "",
        repliedMessageType: "",
        repliedMessage: "",
        isSeen: false,
        createAt: Timestamp.now(),
        message: _textMessageController.text,
      ),
    ).then((value) => {
      setState(() {
        _textMessageController.clear();
      }),
    });
  }
}
