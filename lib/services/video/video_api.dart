import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daniknews/services/video/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApi extends StatefulWidget {
  VideoApi({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  _VideoApiState createState() => _VideoApiState();
}

class _VideoApiState extends State<VideoApi> {
  PageController pageController = PageController();
  CollectionReference video = FirebaseFirestore.instance.collection('videos');

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: videoCard());
  }

  Widget videoCard() {
    return StreamBuilder<QuerySnapshot>(
        stream:
            video.where('category', arrayContains: widget.category).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.docs.isEmpty && snapshot.hasError) {
            return const Text("no data found");
          } else {
            return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  VideoPlayerController controller = VideoPlayerController
                      .network(snapshot.data!.docs[index]['url']);

                  return VideoController(videoPlayerController: controller);
                });
          }
        });
  }
}
