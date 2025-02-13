import 'package:flutter/material.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({super.key});

  @override
  State<Pharmacy> createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PetStoreScreen(),
    );
  }
}

class PetStoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Icon(Icons.pets, color: Colors.green),
            SizedBox(width: 8),
            Text("PetMate", style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deworming Week Banner
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.purple[300],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Deworming Week",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("10th Feb - 16th Feb", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        productCard("Medfly Defender", "₹240 Onwards", 60),
                        productCard("Drontal Plus", "₹796 Onwards", 10),
                        productCard("Intas Eazy Pet", "₹335 Onwards", 6),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {},
                      child: Text("Explore More >", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

            // Categories Grid
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Paw-pular Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                categoryCard("Dewormer", "Up To 60% Off"),
                categoryCard("Anti Tick & Flea", ""),
                categoryCard("Supplements", ""),
                categoryCard("Antibiotics", ""),
                categoryCard("Wound Care", ""),
                categoryCard("Homeopathy", ""),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget productCard(String title, String price, int discount) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.all(8),
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("Up to $discount% off",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  Widget categoryCard(String title, String offer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.pets, size: 40, color: Colors.green),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          if (offer.isNotEmpty)
            Text(offer, style: TextStyle(color: Colors.red, fontSize: 12)),
        ],
      ),
    );
  }
}


