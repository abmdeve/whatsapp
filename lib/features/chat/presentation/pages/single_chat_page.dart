import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp/features/app/const/message_type_const.dart';
import 'package:whatsapp/features/app/global/widgets/show_image_picked_widget.dart';
import 'package:whatsapp/features/app/global/widgets/show_video_picked_widget.dart';
import 'package:whatsapp/features/chat/domain/entities/chat_entity.dart';
import 'package:whatsapp/features/chat/domain/entities/message_entity.dart';
import 'package:whatsapp/features/chat/presentation/cubit/message/message_cubit.dart';
import 'package:whatsapp/features/chat/presentation/cubit/message/message_state.dart';
import 'package:whatsapp/features/chat/presentation/widget/chat_utils.dart';
import 'package:whatsapp/storage/storage_provider.dart';

import '../../../app/const/app_const.dart';
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

  FlutterSoundRecorder? _soundRecorder;
  bool _isRecording = false;
  bool _isRecordInit = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _soundRecorder = FlutterSoundRecorder();
    _openAudioRecording();
    BlocProvider.of<MessageCubit>(context).getMessages(
        message: MessageEntity(
      senderUid: widget.message.senderUid,
      recipientUid: widget.message.recipientUid,
    ));
    super.initState();
  }

  Future<void> _scrollToBottom() async {
    if (_scrollController.hasClients) {
      await Future.delayed(Duration(milliseconds: 100));
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _openAudioRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder!.openRecorder();
    _isRecordInit = true;
  }

  File? _image;

  Future selectImage() async {
    setState(() => _image = null);

    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          debugPrint("NO IMAGE HAS BEEN SELECTED");
        }
      });
    } catch (e) {
      toast("SOME ERROR OCCUR SEE $e");
    }
  }

  File? _video;

  Future selectVideo() async {
    setState(() => _image = null);

    try {
      final pickedFile =
          await ImagePicker.platform.pickVideo(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _video = File(pickedFile.path);
        } else {
          debugPrint("NO VIDEO HAS BEEN SELECTED");
        }
      });
    } catch (e) {
      toast("SOME ERROR OCCUR SEE $e");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });
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
                    //TODO 4418
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          if (message.senderUid == widget.message.senderUid) {
                            return MessageLayout(
                              messageType: message.messageType,
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
                              messageType: message.messageType,
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
                      onSendMessage: () {
                        //_sendMessage();
                        _sendTextMessage();
                      },
                      onCameraClicked: () {
                        selectImage().then((value) {
                          if (_image != null) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timestamp) {
                              showImagePickedBottomModalSheet(context,
                                  recipientName: widget.message.recipientName,
                                  file: _image, onTap: () {
                                _sendImageMessage();
                                Navigator.pop(context);
                              });
                            });
                          }
                        });
                      },
                      onTap: () {
                        setState(() {
                          _isShowAttachWindow = false;
                        });
                      },
                      textMessageController: _textMessageController,
                      isDisplaySendButton: _isDisplaySendButton,
                      isRecording: _isRecording,
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
                        top: 320,
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
                                    onTap: () {
                                      _sendGifMessage();
                                    },
                                  ),
                                  AttachWindowItem(
                                    icon: Icons.videocam,
                                    color: Colors.lightGreen,
                                    title: "Video",
                                    onTap: () {
                                      selectVideo().then((value) {
                                        if (_video != null) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timestamp) {
                                            showVideoPickedBottomModalSheet(
                                                context,
                                                recipientName: widget
                                                    .message.recipientName,
                                                file: _video, onTap: () {
                                              _sendVideoMessage();
                                              Navigator.pop(context);
                                            });
                                          });
                                        }
                                      });
                                      setState(() {
                                        _isShowAttachWindow = false;
                                      });
                                    },
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

  _sendTextMessage() async {
    if (_isDisplaySendButton) {
      _sendMessage(
        message: _textMessageController.text,
        type: MessageTypeConst.textMessage,
      );
    } else {
      final temporaryDir = await getTemporaryDirectory();
      final audioPath = '${temporaryDir.path}/flutter_sound.acc';
      if (!_isRecordInit) {
        return;
      }
      if (_isRecording == true) {
        await _soundRecorder!.stopRecorder();
        StorageProviderRemoteDataSource.uploadMessageFile(
          file: File(audioPath),
          onComplete: (value) {},
          uid: widget.message.senderUid,
          otherUid: widget.message.recipientUid,
          type: MessageTypeConst.audioMessage,
        ).then((audioUrl) {
          _sendMessage(
            message: audioUrl,
            type: MessageTypeConst.audioMessage,
          );
        });
      } else {
        await _soundRecorder!.startRecorder(
          toFile: audioPath,
        );
      }

      setState(() {
        _isRecording = !_isRecording;
      });
    }
  }

  void _sendImageMessage() {
    StorageProviderRemoteDataSource.uploadMessageFile(
      file: _image!,
      onComplete: (value) {},
      uid: widget.message.senderUid,
      otherUid: widget.message.recipientUid,
      type: MessageTypeConst.photoMessage,
    ).then((photoImage) {
      _sendMessage(
        message: photoImage,
        type: MessageTypeConst.photoMessage,
      );
    });
  }

  void _sendVideoMessage() {
    StorageProviderRemoteDataSource.uploadMessageFile(
      file: _video!,
      onComplete: (value) {},
      uid: widget.message.senderUid,
      otherUid: widget.message.recipientUid,
      type: MessageTypeConst.videoMessage,
    ).then((videoUrl) {
      _sendMessage(
        message: videoUrl,
        type: MessageTypeConst.videoMessage,
      );
    });
  }

  Future _sendGifMessage() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      String fixedUrl = "https://media.giphy.com/media/${gif.id}/giphy.gif";
      _sendMessage(
        message: fixedUrl,
        type: MessageTypeConst.gifMessage,
      );
    }
  }

  void _sendMessage({
    required String message,
    required String type,
    String? repliedMessage,
    String? repliedTo,
    String? repliedMessageType,
  }) {
    _scrollToBottom();

    ChatUtils.sendMessage(
      context,
      messageEntity: widget.message,
      message: message,
      type: type,
      repliedTo: repliedTo,
      repliedMessageType: repliedMessageType,
      repliedMessage: repliedMessage,
    ).then((value) => {
          setState(() {
            _textMessageController.clear();
          }),
        });

    _scrollToBottom();
  }
}
