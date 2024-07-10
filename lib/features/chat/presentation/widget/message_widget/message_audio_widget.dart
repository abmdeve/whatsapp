import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:whatsapp/features/app/theme/style.dart';

class MessageAudioWidget extends StatefulWidget {
  final String? audioUrl;

  const MessageAudioWidget({super.key, this.audioUrl});

  @override
  State<MessageAudioWidget> createState() => _MessageAudioWidgetState();
}

class _MessageAudioWidgetState extends State<MessageAudioWidget> {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () async {
            if (isPlaying) {
              await audioPlayer.pause();
              setState(() {
                isPlaying = false;
              });
            } else {
              await audioPlayer.setUrl(widget.audioUrl!).then((value) async {
                setState(() {
                  isPlaying = true;
                });
                await audioPlayer.play().then((value) async {
                  setState(() {
                    isPlaying = false;
                  });
                  await audioPlayer.stop();
                });
              });
            }
          },
          icon: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            size: 30,
            color: greyColor,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        isPlaying
            ? StreamBuilder<Duration>(
                stream: audioPlayer.positionStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 190,
                      height: 2,
                      child: LinearProgressIndicator(
                        value: snapshot.data!.inMicroseconds.toDouble() /
                            audioPlayer.duration!.inMicroseconds.toDouble(),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: greyColor,
                      ),
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 190,
                      height: 2,
                      child: LinearProgressIndicator(
                        value: 0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: greyColor,
                      ),
                    );
                  }
                },
              )
            : Container(
                margin: EdgeInsets.only(top: 20),
                width: 190,
                height: 2,
                child: LinearProgressIndicator(
                  value: 0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  backgroundColor: greyColor,
                ),
              ),
      ],
    );
  }
}
