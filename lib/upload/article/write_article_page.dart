import 'package:daniknews/homepage/homepage.dart';
import 'package:daniknews/upload/article/preview_article.dart';
import 'package:flutter/material.dart';

class WriteArticlePage extends StatefulWidget {
  const WriteArticlePage({super.key, required this.desc, required this.head});
  final String? head;
  final String? desc;

  @override
  _WriteArticlePageState createState() => _WriteArticlePageState();
}

class _WriteArticlePageState extends State<WriteArticlePage> {
  final TextEditingController headline = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    description.text = widget.desc!;
    headline.text = widget.head!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('write article'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                    (Route<dynamic> route) => false);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                if (headline.text.isNotEmpty) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreviewArticle(
                          image: null,
                          title: '',
                          headline: headline.text,
                          description: description.text,
                        ),
                      ),
                      (Route<dynamic> route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('headline can not be empty'),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text("done"),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  maxLength: 90,
                  controller: headline,
                  keyboardType: TextInputType.multiline,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  style: const TextStyle(fontSize: 22),
                  decoration: const InputDecoration(
                    hintText: "Headline",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  minLines: 1,
                  maxLines: 40,
                  maxLength: 1500,
                  controller: description,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      hintText: "Description", border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
