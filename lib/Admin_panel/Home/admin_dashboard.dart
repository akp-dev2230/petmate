import 'package:flutter/material.dart';
import 'package:petmate/background.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: backGround(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Current Products",
                    style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: screenHeight*0.02),
                Text("Available doctors",
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          )
      ),
    );
  }
}
