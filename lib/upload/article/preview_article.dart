import 'dart:io';
import 'package:daniknews/homepage/homepage.dart';
import 'package:daniknews/main.dart';
import 'package:daniknews/upload/article/upload_article_page.dart';
import 'package:daniknews/upload/article/write_article_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class PreviewArticle extends StatefulWidget {
  const PreviewArticle(
      {Key? key,
      required this.image,
      required this.title,
      required this.headline,
      required this.description})
      : super(key: key);

  final File? image;
  final String title;
  final String headline;
  final String description;

  @override
  _PreviewArticleState createState() => _PreviewArticleState();
}

class _PreviewArticleState extends State<PreviewArticle> {
  File? image;
  late String? title;
  var timeStamp = DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> pickImage() async {
    final tempImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (tempImage != null) {
      setState(() {
        image = File(tempImage.path);
        title = tempImage.path.split('/image_picker').last;
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //const SizedBox(height: 100),
              Container(
                height: 280,
                width: size.width,
                margin: EdgeInsets.all(16.0),
                child: size.width > 800
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          image == null
                              ? ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.red,
                                    padding: EdgeInsets.all(20.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_circle_outline,
                                        size: 160,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: size.width / 2 - 20,
                                      ),
                                      Text(
                                        "add images of news for better understanding",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        'Add image of news',
                                        style: TextStyle(
                                            fontSize: 18, color: reddish),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  width: size.width / 2 - 20,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.file(image!,
                                          filterQuality: FilterQuality.low),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () {
                                            pickImage();
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 1,
                                        spreadRadius: 2,
                                        offset: Offset(0, 1),
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
                                ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              width: size.width / 2 - 60,
                              child: heading()),
                        ],
                      )
                    : image == null
                        ? ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.red,
                                padding: EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Icon(
                                  Icons.add_circle_outline,
                                  size: 160,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "add images of news for better understanding",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  'Add image of news',
                                  style:
                                      TextStyle(fontSize: 18, color: reddish),
                                )
                              ],
                            ),
                          )
                        : Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.file(image!,
                                    filterQuality: FilterQuality.low),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      pickImage();
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                )
                              ],
                            ),
                          ),
              ),
              Container(
                //height: 350,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.all(12),
                //color: Colors.lightGreenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    size.width > 800
                        ? SizedBox(
                            height: 0.0,
                          )
                        : heading(),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Description", style: TextStyle(fontSize: 16)),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WriteArticlePage(
                                  head: widget.headline,
                                  desc: widget.description,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    width: size.width / 2 - 20,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
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
                    width: size.width / 2 - 20,
                    child: ElevatedButton(
                      onPressed: () {
                        if (image != null && title!.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadArticlePage(
                                  image: image,
                                  title: timeStamp.toString(),
                                  headline: widget.headline,
                                  description: widget.description),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("please add image to continue"),
                              backgroundColor: reddish,
                            ),
                          );
                        }
                      },
                      child: Text('Next'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Headline", style: TextStyle(fontSize: 16)),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WriteArticlePage(
                            head: widget.headline,
                            desc: widget.description,
                          )),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.black54,
              ),
            )
          ],
        ),
        Text(
          widget.headline,
          style: TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
