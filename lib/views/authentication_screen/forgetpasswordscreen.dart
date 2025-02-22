import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmate/commonwidgets/commonbutton.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';
import 'package:petmate/controllers/auth_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  final AuthController authController = AuthController();
  TextEditingController emailController = TextEditingController();

  void forgotPassword() async{
    try{
      await authController.sendPasswordResetLink(
        email: emailController.text
      );
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
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).orientation == Orientation.portrait ? screenWidth*0.10 : screenWidth*0.15,
          vertical: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.05 : screenHeight*0.10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forget Password ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.01 : screenHeight*0.03,),
            commonTextfield(
              controller: emailController,
              preFixIcon: Icons.email_outlined,
              hinttext: "Email",
              context: context,
            ),
            SizedBox(height:MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.03 : screenHeight*0.05),
            commonButton(
              width: screenWidth*0.85,
              height: MediaQuery.of(context).orientation == Orientation.portrait ? screenHeight*0.07 : screenHeight*0.15,
              buttonName: "Continue",
              onNavigate: (){
                if(emailController.text.isNotEmpty){
                  forgotPassword();
                  Navigator.pop(context);
                }else{
                  Get.snackbar("","",
                    titleText: const Text("email can't be empty", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),),
                    backgroundColor: Colors.white,
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
