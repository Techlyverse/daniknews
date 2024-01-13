import 'package:daniknews/services/user_preferences.dart';
import 'package:daniknews/services/video/video_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late List<String> myCategory;
  PageController pageController = PageController();

  @override
  void initState() {
    myCategory = UserPreferences.getCategories() ?? [];
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoCard();
  }

  Widget videoCard() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .where("category", arrayContainsAny: myCategory)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return buildError();
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Text("no data found");
          }
          else {
            return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  VideoPlayerController controller =
                      VideoPlayerController.network(
                    snapshot.data!.docs[index]['url'],
                  );

                  return VideoController(videoPlayerController: controller);
                });
          }
        });
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: Image.asset(
              'assets/oops.png',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 50),
          const Text("Oops server have some error"),
          const Text("Don't worry, we will back shortly")
        ],
      ),
    );
  }
}
