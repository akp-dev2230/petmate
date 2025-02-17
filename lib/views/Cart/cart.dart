import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}
final List<Map<String, dynamic>> cartItems = [
  {
    "name": "Pedigree Chicken and Vegetables Adult Dog Dry Food",
    "size": "20kg",
    "image": "assets/images/bansalbhand.jpg",
    "price": 3612,
    "originalPrice": 3900,
    "savings": 288
  },
];

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Cart"),
          leading: Icon(Icons.arrow_back),
          actions: [
            Icon(Icons.search, size: screenHeight*0.032),
            SizedBox(width: screenWidth*0.02),
            Stack(
              children: [
                Icon(Icons.shopping_cart_outlined, size: screenHeight*0.032),
                const Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.green,
                    child: Text("2", style: TextStyle(fontSize: 10, color: Colors.white)),
                  ),
                )
              ],
            )
          ]
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.015),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),  // Adjust the radius as needed
                bottomRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.orange.shade200, // Border color
                  width: 2.0, // Border width
                ),
              )
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.orange),
                SizedBox(width: screenWidth*0.02),
                Text("Delivering to "),
                Text("140603", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.edit, color: Colors.orange),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth*0.04, vertical: screenHeight*0.03),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth*0.025, vertical: screenHeight*0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(item["image"], height: 80, width: 80, fit: BoxFit.cover),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outline),
                                      onPressed: () {},
                                    ),
                                    Text("1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline),
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(width: screenWidth*0.03),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: screenHeight*0.005),
                                  Text("Size - ${item["size"]}", style: TextStyle(color: Colors.grey)),
                                  SizedBox(height: screenHeight*0.005),
                                  Text("₹${item["price"]}",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  SizedBox(height: screenHeight*0.005),
                                ],
                              ),
                            ),
                            IconButton(icon: Icon(Icons.delete_outline, size: screenWidth*0.06,), onPressed: () {}),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.local_shipping_outlined, color: Colors.grey),
                            SizedBox(width: 8),
                            Text("Delivery by", style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 4),
                            Text("Mon, 24th Feb", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth*0.035, vertical: screenHeight*0.02),
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 1)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Price Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Divider(),
                _priceDetailRow("Total MRP", "₹6400"),
                _priceDetailRow("Discount on MRP", "- ₹609", color: Colors.green),
                _priceDetailRow("Coupon Discount", "- ₹0"),
                _priceDetailRow("Delivery Fee", "₹49 FREE", color: Colors.green),
                _priceDetailRow("Platform Fee", "₹10.6"),
                const Divider(),
                _priceDetailRow("Total Amount", "₹5797", isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _priceDetailRow(String title, String value, {Color color = Colors.black, bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color)),
      ],
    ),
  );
}
