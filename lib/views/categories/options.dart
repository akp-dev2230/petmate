import 'package:flutter/material.dart';
import 'package:petmate/commonwidgets/commonbutton.dart';
import 'package:petmate/commonwidgets/commoncatg.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.location_on, color: Colors.black),
            SizedBox(width: 5),
            Text("Nature Huts, 140603", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:screenWidth*0.02, vertical:screenWidth*0.02 ),
                  child: const Text("Shop By Store",
                    style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,),),
                ),
                commonCatg(
                  horizontal:screenWidth*0.03,
                  vertical: screenHeight*0.02,
                  width: screenWidth*0.935,
                  height: screenHeight*0.1,
                  image: AssetImage("assets/images/dogfood.png"),
                  text: "Dog Food",
                  onTap: () {}
                ),
                commonCatg(
                    horizontal:screenWidth*0.03,
                    vertical: screenHeight*0.02,
                    width: screenWidth*0.935,
                    height: screenHeight*0.1,
                    image: AssetImage("assets/images/catfood.png"),
                    text: "Cat Food",
                    onTap: () {}
                ),
                commonCatg(
                    horizontal:screenWidth*0.03,
                    vertical: screenHeight*0.02,
                    width: screenWidth*0.935,
                    height: screenHeight*0.1,
                    image: AssetImage("assets/images/pharmacy.png"),
                    text: "Pharmacy",
                    onTap: () {}
                ),
                commonCatg(
                    horizontal:screenWidth*0.03,
                    vertical: screenHeight*0.02,
                    width: screenWidth*0.935,
                    height: screenHeight*0.1,
                    image: AssetImage("assets/images/toys.png"),
                    text: "Toys",
                    onTap: () {}
                ),
                commonCatg(
                    horizontal:screenWidth*0.03,
                    vertical: screenHeight*0.02,
                    width: screenWidth*0.935,
                    height: screenHeight*0.1,
                    image: AssetImage("assets/images/Clothing.png"),
                    text: "Clothing",
                    onTap: () {}
                ),
                commonCatg(
                    horizontal:screenWidth*0.03,
                    vertical: screenHeight*0.02,
                    width: screenWidth*0.935,
                    height: screenHeight*0.1,
                    image: AssetImage("assets/images/walkingessentials.png"),
                    text: "Walk Essentials",
                    onTap: () {}
                ),
                commonCatg(
                    horizontal:screenWidth*0.03,
                    vertical: screenHeight*0.02,
                    width: screenWidth*0.935,
                    height: screenHeight*0.1,
                    image: AssetImage("assets/images/feeders.png"),
                    text: "Bowls & Feeders",
                    onTap: () {}
                ),
                commonCatg(
                    horizontal:screenWidth*0.03,
                    vertical: screenHeight*0.02,
                    width: screenWidth*0.935,
                    height: screenHeight*0.1,
                    image: AssetImage("assets/images/hygiene.png"),
                    text: "Cleaning & Hygiene",
                    onTap: () {}
                ),
              ],
        ),
      ),
    );
  }
}
