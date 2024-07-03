import 'package:flutter/material.dart';

import '../../app/global/widgets/attach_window_item.dart';
import '../../app/global/widgets/bacgroung_image_widget.dart';
import '../../app/global/widgets/input_single_chat.dart';
import '../../app/global/widgets/message_layout.dart';
import '../../app/global/widgets/user_image.dart';
import '../../app/theme/style.dart';

class SingleChatPage extends StatefulWidget {
  const SingleChatPage({super.key});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final TextEditingController _textMessageController = TextEditingController();
  bool _isDisplaySendButton = false;
  bool _isShowAttachWindow = false;

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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Username",
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
      body: GestureDetector(
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
                  child: ListView(
                    children: [
                      MessageLayout(
                        message: "Hello",
                        alignment: Alignment.centerRight,
                        createAt: DateTime.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageColor: messageColor,
                        onLongPress: () {},
                        //onSwipe: (){},
                      ),
                      MessageLayout(
                        message: "How are you ?",
                        alignment: Alignment.centerRight,
                        createAt: DateTime.now(),
                        isSeen: false,
                        isShowTick: true,
                        messageColor: messageColor,
                        onLongPress: () {},
                        //onSwipe: (){},
                      ),
                      MessageLayout(
                        message: "Hi",
                        alignment: Alignment.centerLeft,
                        createAt: DateTime.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageColor: senderMessageColor,
                        onLongPress: () {},
                        //onSwipe: (){},
                      ),
                      MessageLayout(
                        message: "Doing good, how about you ?",
                        alignment: Alignment.centerLeft,
                        createAt: DateTime.now(),
                        isSeen: false,
                        isShowTick: false,
                        messageColor: senderMessageColor,
                        onLongPress: () {},
                        //onSwipe: (){},
                      ),
                    ],
                  ),
                ),
                InputSingleChat(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ),
    );
  }
}
