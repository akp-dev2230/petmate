import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/background.dart';
import 'package:petmate/commonwidgets/commonbutton.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';
import 'package:petmate/controllers/auth_controller.dart';
import 'package:petmate/views/authentication_screen/forgetpasswordscreen.dart';
import 'package:petmate/views/authentication_screen/signupscreen.dart';
import 'package:petmate/views/landing_screen/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthController authController = AuthController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool obsbool = true;
  
  void login() async{
    try{
      await authController.loginMethod(
        email: emailController.text,
        password: passController.text,
      ).then((value){
        if(value != null){
          Get.off(const HomeScreen());
          Get.snackbar("","",
            titleText: const Text("Login Successfully", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
            backgroundColor: Colors.white,
          );
        }
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

    final screenWidth = MediaQuery.of(context).size.width ;
    final screenHeight = MediaQuery.of(context).size.height ;

    return Scaffold(
      body: backGround(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.10 : screenWidth*0.15,
                vertical: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.05 : screenHeight*0.10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.30 : screenWidth*0.20,
                      height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.14 : screenHeight*0.40,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/PETMATE3.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(32), // Optional: Rounded corners
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.05 : screenHeight*0.07),
                  Text(
                    "Login ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.01 : screenHeight*0.03,),
                  commonTextfield(
                    controller: emailController,
                    preFixIcon: CupertinoIcons.mail,
                    hinttext: "Email",
                    context: context,
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.01 : screenHeight*0.03,),
                  commonTextfield(
                    controller: passController,
                    obstxt: obsbool,
                    preFixIcon: CupertinoIcons.lock,
                    hinttext: "Password",
                    suFFixIcon: obsbool ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    suffIconPressed: (){
                      setState(() {
                        obsbool = !obsbool;
                      });
                    },
                    context: context,
                  ),
                  SizedBox(height:MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.03 : screenHeight*0.05),
                  commonButton(
                    width: screenWidth*0.85,
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.07 : screenHeight*0.15,
                    buttonName: "Login",
                    onNavigate: ()=>login(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPasswordScreen()));
                        },
                        child: Text(
                          "Forget Password ?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 1, color: Colors.black,),
                  Center(
                    child: Text(
                      "OR",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.04 : screenHeight*0.06),
                  commonButton(
                    width: screenWidth*0.85,
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.07 : screenHeight*0.15,
                    buttonName: "Continue with Google",
                    onNavigate: (){},
                  ),
                  SizedBox(height:MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.02 : screenHeight*0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Don't have an account?  ", style: Theme.of(context).textTheme.bodySmall,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));
                        },
                        child: const Text(
                          "Sign up",
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
