import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/Admin_panel/authentication/admin_signup.dart';
import 'package:petmate/background.dart';
import 'package:petmate/commonwidgets/commonbutton.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';
import 'package:petmate/controllers/auth_controller.dart';
import 'package:petmate/views/authentication_screen/loginscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final AuthController authController = AuthController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool obsbool = true;

  void signUp() async{
    try{
      await authController.signupMethod(
        email: emailController.text,
        password: passController.text,
      ).then((value){
        Get.off(const LoginScreen());
      });
    }catch(e){
      Get.snackbar("","",
        titleText: const Text("Error", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
        messageText: Text("$e", style: const TextStyle(fontSize: 16, color: Colors.black),),
        backgroundColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: backGround(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth * 0.10 : screenWidth * 0.15,
                vertical: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight * 0.05 : screenHeight * 0.10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth * 0.30 : screenWidth * 0.20,
                      height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight * 0.14 : screenHeight * 0.40,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/PETMATE3.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight * 0.03 : screenHeight * 0.07,),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: screenHeight*0.04,
                          width: screenWidth*0.25,
                          decoration: BoxDecoration(
                              color: Color(0xFF073763),
                              borderRadius: BorderRadius.circular(18)
                          ),
                          child: const Center(
                            child:  Text("User Signup",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white
                              ),),
                          )
                      ),
                      Container(
                          height: screenHeight*0.04,
                          width: screenWidth*0.25,
                          decoration: BoxDecoration(
                              color: Color(0xFF073763),
                              borderRadius: BorderRadius.circular(18)
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminSignup()));
                            },
                            child: const Center(
                              child:  Text("Admin Signup",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),),
                            ),
                          )
                      ),
                    ],
                  ),*/
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight * 0.05 : screenHeight * 0.07,),
                  Text(
                    "Sign up ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.01 : screenHeight*0.03,),
                  commonTextfield(
                    controller: emailController,
                    preFixIcon: Icons.email_outlined,
                    hinttext: "Email",
                    context: context
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.01 : screenHeight*0.03,),
                  commonTextfield(
                    controller: passController,
                    context: context,
                    obstxt: obsbool,
                    preFixIcon: CupertinoIcons.lock,
                    hinttext: "Password",
                    suFFixIcon: obsbool ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    suffIconPressed: () {
                      setState(() {
                        obsbool = !obsbool;
                      });
                    },
                  ),
                  SizedBox(height:MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.03 : screenHeight*0.05),
                  commonButton(
                    width: screenWidth * 0.85,
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight * 0.07 : screenHeight * 0.15,
                    buttonName: "Sign Up",
                    onNavigate: ()=>signUp(),
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.04 : screenHeight*0.06),
                  const Divider(height: 1, color: Colors.black,),
                  SizedBox(height:MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.02 : screenHeight*0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an account?  ", style: Theme.of(context).textTheme.bodySmall,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
