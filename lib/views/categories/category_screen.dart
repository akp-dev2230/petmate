import 'package:flutter/material.dart';
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
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: const Text(
          "Shop By Store",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: categoryName.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
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
          );
        },
      ),
    );
  }
}
