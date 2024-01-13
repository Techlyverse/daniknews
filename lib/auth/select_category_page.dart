import 'dart:ui';
import 'package:daniknews/main.dart';
import 'package:daniknews/services/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../homepage/homepage.dart';

class SelectCategories extends StatefulWidget {
  const SelectCategories({Key? key}) : super(key: key);

  @override
  _SelectCategoriesState createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  late List<CategoryChip> _categories;
  late List<String>? myCategories;

  @override
  void initState() {
    super.initState();
    myCategories = UserPreferences.getCategories() ?? [];
    _categories = <CategoryChip>[
      CategoryChip('Bollywood', Icon(Icons.add, color: Colors.white)),
      CategoryChip('Business', Icon(Icons.update)),
      CategoryChip('Education', Icon(Icons.person)),
      CategoryChip('Entertainment', Icon(Icons.portrait)),
      CategoryChip('International', Icon(Icons.favorite)),
      CategoryChip('Politics', Icon(Icons.messenger)),
      CategoryChip('Sports', Icon(Icons.share)),
      CategoryChip('Technology', Icon(Icons.height)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).orientation == Orientation.portrait
                ? MediaQuery.of(context).size.height - 80
                : null,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Choose your Interests",
                      style: TextStyle(fontSize: 26),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Wrap(
                        children: allCategory.toList(),
                      ),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await addAllCategory();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: 300,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    //SizedBox(height: 40)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Iterable<Widget> get allCategory sync* {
    for (CategoryChip category in _categories) {
      yield Padding(
        padding: EdgeInsets.all(4.0),
        child: FilterChip(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.grey[300],
          label: Text(category.chipLabel),
          labelStyle: TextStyle(fontSize: 16),
          labelPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          selected: myCategories!.contains(category.chipLabel),
          selectedColor: Colors.red[50],
          checkmarkColor: reddish,
          onSelected: (bool isSelected) {
            setState(() {
              if (isSelected) {
                myCategories!.add(category.chipLabel);
                UserPreferences.setCategories(myCategories!);
              } else {
                myCategories!.removeWhere((String chipLabel) {
                  return chipLabel == category.chipLabel;
                });
                UserPreferences.setCategories(myCategories!);
              }
            });
          },
        ),
      );
    }
  }

  addAllCategory() {
    myCategories!.clear();
    for (var element in _categories) {
      myCategories!.add(element.chipLabel);
    }
    UserPreferences.setCategories(myCategories!);
  }
}

class CategoryChip {
  CategoryChip(this.chipLabel, this.Icon);
  final String chipLabel;
  final Icon;
}
