import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('articles').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bug_report,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Oops, Something went wrong'),
                  )
                ],
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return OrientationBuilder(
                    builder: (context, orientation) {
                      return Container(
                        width: orientation == Orientation.portrait ? null : 500,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.docs[index]['url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 18),
                              childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 18),
                              title: Text(
                                snapshot.data!.docs[index]['headline'],
                                style: const TextStyle(fontSize: 18),
                              ),
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['description'],
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: FlutterLogo(
                                    size: 25,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("the times of india"),
                                Expanded(
                                  child: SizedBox(),
                                ),
                                Icon(
                                  Icons.favorite,
                                  size: 22,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.share,
                                  size: 22,
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.messenger_outline,
                                  size: 22,
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Divider(thickness: 1),
                          ],
                        ),
                      );
                    },
                  );
                });
          }
        },
      ),
    );
  }
}
