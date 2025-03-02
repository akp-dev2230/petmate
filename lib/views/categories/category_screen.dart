import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import 'package:petmate/commonwidgets/commoncatg.dart';
import 'package:petmate/views/categories/category_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final categoryImage = [
    "assets/images/dogfood.png",
    "assets/images/catfood.png",
    "assets/images/pharmacy.png",
    "assets/images/toys.png",
    "assets/images/Clothing.png",
    "assets/images/walkingessentials.png",
    "assets/images/feeders.png",
    "assets/images/hygiene.png",
  ];
  final categoryName = ["Dog Food", "Cat Food", "Pharmacy", "Toys", "Clothing",
    "Walk Essentials", "Bowls & Feeders", "Cleaning & Hygiene"];

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text(
          "Shop By Store",
        ),
      ),
      body: backGround(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: screenHeight*0.1),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: categoryName.length,
          itemBuilder: (BuildContext context, int index) {
            return FadeInUp(
              delay: Duration(milliseconds: 10*index),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: commonCatg(
                  width: screenWidth * 0.90,
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight * 0.1 : screenHeight * 0.25,
                  image: categoryImage[index],
                  text: categoryName[index],
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryItem(categoryName: categoryName[index]),),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
