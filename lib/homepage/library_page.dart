import 'dart:io';
import 'package:daniknews/services/firebase_api.dart';
import 'package:daniknews/services/user_preferences.dart';
import 'package:daniknews/upload/article/write_article_page.dart';
import 'package:daniknews/upload/video/upload_video_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import '../auth/select_category_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late List<String> myCategory;
  FirebaseAuth auth = FirebaseAuth.instance;
  File? image;
  late String? title;

  Future<void> selectImageFromGallery() async {
    title = 'noTitle';
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadVideoPage(image, title!),
        ),
      );

      setState(() {
        image = File(selectedImage.path);
        title = selectedImage.path.split('/image_picker').last;
      });
    }
    ;
    return;
  }

  Future<void> selectVideoFromGallery() async {
    title = 'noTitle';
    var selectedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (selectedVideo != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadVideoPage(image, title!),
        ),
      );

      setState(() {
        image = File(selectedVideo.path);
        title = selectedVideo.path.split('/image_picker').last;
      });
    }
    ;
    return;
  }

  @override
  void initState() {
    myCategory = UserPreferences.getCategories() ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
        actions: [
          IconButton(
              onPressed: () async {
                await logOut(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height - 150,
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(auth.currentUser!.photoURL!),
                    radius: 50,
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: [
                      Text("04", style: TextStyle(fontSize: 18)),
                      Text("video")
                    ],
                  ),
                  Column(
                    children: [
                      Text("12", style: TextStyle(fontSize: 18)),
                      Text("articles")
                    ],
                  ),
                  Column(
                    children: [
                      Text("₹  8", style: TextStyle(fontSize: 18)),
                      Text("earn")
                    ],
                  ),
                  SizedBox(width: 5),
                ],
              ),
              Text(
                auth.currentUser!.displayName!,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 100),
              SizedBox(
                width: size.width / 2 - 25,
                height: 45,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectCategories(),
                      ),
                    );
                  },
                  child: const Text("change category"),
                ),
              ),
              const SizedBox(height: 100),
              Text(myCategory.toString()),
              Expanded(flex: 1, child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width / 2 - 25,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        //await selectImageFromGallery();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WriteArticlePage(
                              desc: '',
                              head: '',
                            ),
                          ),
                        );
                      },
                      child: Text('upload Article'),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 2 - 25,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        await selectVideoFromGallery();
                      },
                      child: Text('upload Video'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
