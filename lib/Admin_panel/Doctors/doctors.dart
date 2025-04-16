import 'package:flutter/material.dart';
import 'package:petmate/background.dart';

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        centerTitle: true,
      ),
      body: backGround(
          child: Column(
            children: [
            ],
          )
      ),
    );
  }
}
