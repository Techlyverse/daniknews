import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? image;

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed to print image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          image != null ? Image.file(image!) : FlutterLogo(),
          const SizedBox(
            height: 200,
            child: Text("news")//NewsTagPage(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImageFromGallery();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
