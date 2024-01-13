import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daniknews/services/video/video_api.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<CategoryChip> categoryChip = [
    CategoryChip(category: "Bollywood", imagePath: 'assets/bollywood.jpg'),
    CategoryChip(category: "Business", imagePath: 'assets/business.jpg'),
    CategoryChip(category: "Education", imagePath: 'assets/education.jpg'),
    CategoryChip(
        category: "Entertainment", imagePath: 'assets/entertainment.jpg'),
    CategoryChip(
        category: "International", imagePath: 'assets/international.jpg'),
    CategoryChip(category: "Politics", imagePath: 'assets/politics.jpg'),
    CategoryChip(category: "Sports", imagePath: 'assets/sports.jpg'),
    CategoryChip(category: "Technology", imagePath: 'assets/technology.jpg'),
  ];

  late List<Stream<QuerySnapshot>> listStream;
  CollectionReference video = FirebaseFirestore.instance.collection('videos');
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    listStream = <Stream<QuerySnapshot>>[];
    for (int i = 0; i < categoryChip.length; i++) {
      listStream.add(video
          .where('category', arrayContains: categoryChip[i].category)
          .snapshots());
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: videoCard(),
    );
  }

  Widget videoCard() {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
        itemCount: listStream.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          childAspectRatio: 1,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          return StreamBuilder<QuerySnapshot>(
              stream: listStream[index],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Text("error happened in server");
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Text("data is empty or deleted");
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoApi(
                                      category: categoryChip[index].category),
                                ),
                              );
                            },
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                categoryChip[index].imagePath,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  categoryChip[index].category,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              });
        },
      );
    });
  }
}

class CategoryChip {
  CategoryChip({required this.category, required this.imagePath});
  final String category;
  final String imagePath;
}
