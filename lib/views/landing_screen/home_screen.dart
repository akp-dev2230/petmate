import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:petmate/background.dart';
import 'package:petmate/views/categories/category_screen.dart';
import 'package:petmate/commonwidgets/commoncatg.dart';
import '../categories/category_item.dart';
import '../../widgets/doctors_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categoryImage = [
    "assets/images/Dogfood.jpeg",
    "assets/images/catfood.jpeg",
    "assets/images/Pharmacy.jpeg",
    "assets/images/toys.jpeg",
  ];

  final categoryName = [
    "Dog Food",
    "Cat Food",
    "Pharmacy",
    "Toys",
  ];

  final doctorIcons = [
    Icons.person,
    Icons.person,
    Icons.person,
  ];

  final doctorName=[
    "Pathologist",
    "Dermatologist",
    "Nutritionist"
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // This AppBar ("Welcome") remains unless explicitly removed
      appBar: AppBar(
        title: const Text("Welcome To Petmate"),
        centerTitle: true,
      ),
      body: backGround(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text(
                    "Paw-pular Categories",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: screenWidth * 0.01,
                      mainAxisSpacing: screenHeight * 0.006,
                      childAspectRatio: 1,
                    ),
                    itemCount: categoryName.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FadeInUp(
                        delay: Duration(milliseconds: 100 * index),
                        child: commonCatg(
                          width: screenWidth * 0.25,
                          height: screenHeight * 0.15,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: FadeInUp(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryScreen()));
                          },
                          child: const Text(
                            'View more',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text(
                    "Our Expert Doctors",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const DoctorsList(specialty: "Veterinarian"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
