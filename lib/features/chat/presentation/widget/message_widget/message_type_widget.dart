import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/features/app/const/message_type_const.dart';
import 'package:whatsapp/features/app/global/widgets/user_image.dart';
import 'package:whatsapp/features/app/theme/style.dart';

import 'message_audio_widget.dart';
import 'message_video_widget.dart';

class MessageTypeWidget extends StatelessWidget {
  final String? type;
  final String? message;

  const MessageTypeWidget({super.key, this.type, this.message});

  @override
  Widget build(BuildContext context) {
    if (type == MessageTypeConst.textMessage) {
      return Text(
        "$message",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    } else if (type == MessageTypeConst.photoMessage) {
      return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: UserImage(
          imageUrl: message,
        ),
      );
    } else if (type == MessageTypeConst.videoMessage) {
      return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: CachedVideoMessageWidget(
          url: message!,
        ),
      );
    } else if (type == MessageTypeConst.gifMessage) {
      return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: CachedNetworkImage(
          imageUrl: message!,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    } else if (type == MessageTypeConst.audioMessage) {
      return MessageAudioWidget(
        audioUrl: message,
      );
    } else {
      return Text(
        "$message",
        maxLines: 2,
        style: TextStyle(
          color: greyColor,
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return const Placeholder();
  }
}
