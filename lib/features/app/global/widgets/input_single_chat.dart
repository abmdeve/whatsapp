import 'package:flutter/material.dart';

import '../../theme/style.dart';

class InputSingleChat extends StatelessWidget {
  final TextEditingController textMessageController;
  final bool isDisplaySendButton;
  final bool isRecording;
  final Function(String) onChanged;
  final VoidCallback? onAttachedFileClicked;
  final VoidCallback? onCameraClicked;
  final VoidCallback? onEmojiClicked;
  final VoidCallback? onTap;
  final VoidCallback? onSendMessage;

  const InputSingleChat({
    super.key,
    required this.textMessageController,
    required this.isDisplaySendButton,
    required this.isRecording,
    required this.onChanged,
    this.onAttachedFileClicked,
    this.onCameraClicked,
    this.onEmojiClicked,
    this.onTap,
    this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          //TODO INPUT EMOJI ATTACH_FILE PHOTO
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 5,
              ),
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(25),
              ),
              height: 50,
              child: TextField(
                style: TextStyle(color: textColor),
                onTap: onTap,
                controller: textMessageController,
                onChanged: onChanged,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: GestureDetector(
                    onTap: onEmojiClicked,
                    child: const Icon(
                      Icons.emoji_emotions,
                      color: greyColor,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Wrap(
                      children: [
                        Transform.rotate(
                          angle: -0.5,
                          child: GestureDetector(
                            onTap: onAttachedFileClicked,
                            child: const Icon(
                              Icons.attach_file,
                              color: greyColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: onCameraClicked,
                          child: const Icon(
                            Icons.camera_alt,
                            color: greyColor,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                  hintText: "Message",
                  hintStyle: const TextStyle(color: greyColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          //TODO BUTTON SEND MESSAGE
          GestureDetector(
            onTap: onSendMessage,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: tabColor,
              ),
              child: Center(
                child: Icon(
                  isDisplaySendButton
                      ? Icons.send_outlined
                      : isRecording
                          ? Icons.close
                          : Icons.mic,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
