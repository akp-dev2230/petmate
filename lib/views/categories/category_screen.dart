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
    "assets/images/Dogfood.jpeg",
    "assets/images/catfood.jpeg",
    "assets/images/Pharmacy.jpeg",
    "assets/images/toys.jpeg",
    "assets/images/Clothing.jpeg",
    "assets/images/walkingessentials.jpeg",
    "assets/images/Feeders.jpeg",
    "assets/images/Hygiene.jpeg",
  ];

  final categoryName = [
    "Dog Food",
    "Cat Food",
    "Pharmacy",
    "Toys",
    "Clothing",
    "Walk Essentials",
    "Bowls & Feeders",
    "Cleaning & Hygiene"
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text("Shop By Store"),
      ),
      body: backGround(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: screenWidth * 0.04,
              mainAxisSpacing: screenHeight * 0.02,
              childAspectRatio: 0.85, // Adjust this value to control card height/width ratio
            ),
            itemCount: categoryName.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeInUp(
                delay: Duration(milliseconds: 100 * index),
                child: commonCatg(
                  width: screenWidth * 0.45, // Adjusted for grid
                  height: screenHeight * 0.35, // Adjusted for grid
                  image: categoryImage[index],
                  text: categoryName[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryItem(categoryName: categoryName[index]),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}