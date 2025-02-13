import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petmate/views/Clinic/clinic.dart';
import 'package:petmate/views/Pharmacy/pharmacy.dart';
import 'package:petmate/views/Userinfo/accountinfo.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';
import 'package:petmate/views/categories/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final drawerIconList = [Icons.home, Icons.category, Icons.local_offer, Icons.local_pharmacy, Icons.person];
  final drawerIconName = ['Home', 'Categories', 'Offer Zone', 'Pharmacy', 'Account'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Colors.black),
            SizedBox(width: 5),
            Text("Nature Huts, 140603", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: Text('Menu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: drawerIconName.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: Icon(drawerIconList[index]),
                  title: Text(drawerIconName[index], style: Theme.of(context).textTheme.bodyLarge,),
                  onTap: (){},
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Logout', style: Theme.of(context).textTheme.bodyLarge,),
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                });
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for Food, Treats, Pharmacy",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryChip(label: "All"),
                  CategoryChip(label: "Dogs", isSelected: true),
                  CategoryChip(label: "Cats"),
                  CategoryChip(label: "Small Pets"),
                ],
              ),
            ),
            SizedBox(height: 10),
            PromotionBanner(),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("Paw-pular Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            CategoryGrid(),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: isSelected ? Colors.lightGreenAccent : Colors.grey[200],
      label: Text(label),
    );
  }
}

// PromotionBanner Widget
class PromotionBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.orange.shade100,
        ),
        child: Column(
          children: [
            Image.asset("assets/images/bansalbhand.jpg"), // Replace with actual image
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Stock up & Save! Up to 50% OFF",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CategoryGrid Widget
class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return CategoryCard();
      },
    );
  }
}

// CategoryCard Widget
class CategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/bansalbhand.jpg"), // Replace with actual images
          SizedBox(height: 5),
          Text("Category", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
