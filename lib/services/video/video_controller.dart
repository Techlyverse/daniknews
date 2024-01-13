import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoController extends StatefulWidget {
  const VideoController({Key? key, required this.videoPlayerController})
      : super(key: key);
  final VideoPlayerController videoPlayerController;

  @override
  _VideoControllerState createState() => _VideoControllerState();
}

class _VideoControllerState extends State<VideoController> {
  @override
  void initState() {
    widget.videoPlayerController
      ..initialize()
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: videoCard(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: sideButtonBar(),
          )
        ],
      ),
    );
  }

  Widget videoCard() {
    return InkWell(
      onTap: () {
        setState(() {
          if (widget.videoPlayerController.value.isPlaying) {
            widget.videoPlayerController.pause();
          } else {
            widget.videoPlayerController.play();
          }
        });
      },
      child: VideoPlayer(widget.videoPlayerController),
    );
  }

  Widget sideButtonBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.thumb_up_outlined,
              color: Colors.white,
            ),
          ),
          const Text(
            "12",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.thumb_down_outlined,
              color: Colors.white,
            ),
          ),
          const Text(
            "5",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.comment_outlined,
              color: Colors.white,
            ),
          ),
          const Text(
            "3",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.white,
            ),
          ),
          const Text(
            "share",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
