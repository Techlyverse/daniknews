import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daniknews/homepage/homepage.dart';
import 'package:daniknews/services/firestore_api.dart';
import 'package:daniknews/upload/article/preview_article.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'dart:io';

class UploadArticlePage extends StatefulWidget {
  const UploadArticlePage(
      {required this.image,
      required this.title,
      required this.headline,
      required this.description,
      Key? key})
      : super(key: key);

  final File? image;
  final String title;
  final String headline;
  final String description;

  @override
  _UploadArticlePageState createState() => _UploadArticlePageState();
}

class _UploadArticlePageState extends State<UploadArticlePage>
    with SingleTickerProviderStateMixin {
  final firestore = FirebaseFirestore.instance;
  late List<String> category;
  late List<String>? selectedCategories;
  late File fileUpload;
  bool isCategorySelected = false;
  firebase_storage.UploadTask? task;
  late double progress;

  @override
  void initState() {
    super.initState();
    progress = 0;
    selectedCategories = <String>[];
    category = <String>[
      "Unspecified",
      "Bollywood",
      "Business",
      "Education",
      "Sports",
      "Entertainment",
      "International",
      "Politics",
      "Technology",
    ];
  }

  Future uploadArticle(category, image, title, headline, description) async {
    if (widget.image == null &&
        widget.title.isEmpty &&
        widget.headline.isEmpty) {
      return;
    } else {
      task = FirestoreApi.uploadArticle(
        category,
        image,
        title,
        headline,
        description,
      );
      setState(() {});
      if (task == null) return;

      final taskSnapshot = await task!.whenComplete(() {});
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await firestore.collection('articles').doc(title).set({
        'url': downloadUrl,
        'category': FieldValue.arrayUnion(selectedCategories!),
        'headline': widget.headline,
        'description': widget.description,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                height: 280,
                child: Image.file(
                  widget.image!,
                  filterQuality: FilterQuality.low,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 3,
                      offset: Offset(0, 2),
                      color: Colors.black26,
                    )
                  ],
                ),
              ),
              //buildChoiceChips(),
              Wrap(children: allCategory.toList()),

              SizedBox(height: 50),
              task != null
                  ? uploadProgressIndicator(task!)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PreviewArticle(
                                    image: widget.image,
                                    title: widget.title,
                                    headline: widget.headline,
                                    description: widget.description,
                                  ),
                                ),
                              );
                            },
                            child: Text('cancel'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: ElevatedButton(
                            onPressed: (selectedCategories!.isNotEmpty &&
                                    selectedCategories!.length < 4)
                                ? () {
                                    uploadArticle(
                                      selectedCategories,
                                      widget.image,
                                      widget.title,
                                      widget.headline,
                                      widget.description,
                                    );
                                  }
                                : null,
                            child: const Text("Upload"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget uploadProgressIndicator(firebase_storage.UploadTask task) {
    return StreamBuilder<firebase_storage.TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            progress = (snap.bytesTransferred / snap.totalBytes).toDouble();
            final downloadProgress = (progress * 100).toStringAsFixed(2);

            return Column(
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      progress != 1.00
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.amber),
                              backgroundColor: Colors.amberAccent,
                              strokeWidth: 10,
                            )
                          : CircularProgressIndicator(
                              value: progress,
                              valueColor: AlwaysStoppedAnimation(
                                  progress == 1 ? Colors.green : Colors.orange),
                              backgroundColor: Colors.amberAccent,
                              strokeWidth: 10,
                            ),
                      Center(
                        child: progress == 1
                            ? const Icon(
                                Icons.check_rounded,
                                size: 55,
                                color: Colors.green,
                              )
                            : Text(
                                downloadProgress + '%',
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.orange),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  height: 55,
                  width: 250,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                    child: Text('Go to Homepage'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                fit: StackFit.expand,
                children: const [
                  CircularProgressIndicator(
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation(Colors.amber),
                  ),
                  Center(
                    child: Text('Connecting...'),
                  )
                ],
              ),
            );
          }
        });
  }

  Iterable<Widget> get allCategory sync* {
    for (int i = 0; i < category.length; i++) {
      yield Padding(
        padding: EdgeInsets.all(4.0),
        child: FilterChip(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.grey[300],
          label: Text(category[i]),
          labelStyle: TextStyle(fontSize: 16),
          labelPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          selected: selectedCategories!.contains(category[i]),
          selectedColor: Colors.white,
          checkmarkColor: Colors.black87,
          onSelected: (bool isSelected) {
            setState(() {
              if (isSelected) {
                selectedCategories!.add(category[i]);
              } else {
                selectedCategories!.removeWhere((chipLabel) {
                  return chipLabel == category[i];
                });
              }
            });
          },
        ),
      );
    }
  }
}
