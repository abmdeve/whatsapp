import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CachedVideoMessageWidget extends StatefulWidget {
  final String url;

  const CachedVideoMessageWidget({super.key, required this.url});

  @override
  State<CachedVideoMessageWidget> createState() =>
      _CachedVideoMessageWidgetState();
}

class _CachedVideoMessageWidgetState extends State<CachedVideoMessageWidget> {
  @override
  Widget build(BuildContext context) {
    late VideoPlayerController videoPlayerController;
    bool isPlay = false;

    @override
    void initState() {
      super.initState();
      // Add code after super
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.url))
            ..initialize().then((value) {
              videoPlayerController.setVolume(1);
            });
    }

    @override
    void dispose() {
      // Add code before the super
      videoPlayerController.dispose();
      super.dispose();
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon: Icon(
                isPlay ? Icons.pause_circle : Icons.play_circle,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
