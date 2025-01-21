import 'package:flutter/material.dart';
import 'package:petmate/commonwidgets/commonbutton.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {

    final horizontalPadding = MediaQuery.of(context).size.width ;
    final verticalPadding = MediaQuery.of(context).size.height ;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: verticalPadding*0.1),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(32), // Optional: Rounded corners
                  ),
                ),
              ),
              const Text("Login",style: TextStyle(fontSize: 50, fontWeight: FontWeight.w400),),
              SizedBox(height: verticalPadding*0.03,),
              commonTextfield(
                hinttext: "Email",
                obstxt: false,
                width: horizontalPadding*0.85 ,
                height: verticalPadding*0.065,
              ),
              SizedBox(height: verticalPadding*0.01,),
              commonTextfield(
                hinttext: "Password",
                obstxt: true,
                width: horizontalPadding*0.85 ,
                height: verticalPadding*0.065,
              ),
              SizedBox(height:verticalPadding*0.03),
              commonButton(
                onNavigate: (){
                },
                buttonName: "login",
                width: horizontalPadding*0.85,
                height: verticalPadding*0.07,
                clr: Colors.greenAccent,
                txtclr: Colors.black,
              ),
              SizedBox(height:verticalPadding*0.04),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding*0.12),
                child: Divider(height: 1,),
              ),
              Text("OR", style: TextStyle(fontSize: 18,),),
              SizedBox(height:verticalPadding*0.04),
              commonButton(
                onNavigate: (){},
                buttonName: "Continue with Google",
                width: horizontalPadding*0.85,
                height: verticalPadding*0.07,
                clr: Colors.white,
                txtclr: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
