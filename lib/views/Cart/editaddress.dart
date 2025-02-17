import 'package:flutter/material.dart';
import 'package:petmate/commonwidgets/commontextfield.dart';

class Editaddress extends StatefulWidget {
  const Editaddress({super.key});

  @override
  State<Editaddress> createState() => _EditaddressState();
}

class _EditaddressState extends State<Editaddress> {
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Address"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Details Section
            _sectionTitle("Contact details"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
              child: commonTextfield(context: context,
              hinttext: "FirstName",
              ),
            ),Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
              child: commonTextfield(context: context,
                hinttext: "Mobile No",
              ),
            ),Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
              child: commonTextfield(context: context,
                hinttext: "Email",
              ),
            ),Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
              child: commonTextfield(context: context,
                hinttext: "Your pet's name",
              ),
            ),

            SizedBox(height: screenHeight*0.02),

            // Address Section
            _sectionTitle("Address"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
              child: commonTextfield(context: context,
                hinttext: "Address (Road/Area/Colony)*",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
              child: commonTextfield(context: context,
                hinttext: "House/Building/Flat No.",
              ),
            ),
            Row(
              children: [
                Expanded(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
                  child: commonTextfield(context: context,
                    hinttext: "Pincode*",
                  ),
                ),),
                SizedBox(width: 8),
                Expanded(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
                  child: commonTextfield(context: context,
                    hinttext: "City/Town*",
                  ),
                ),),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*0.01,vertical: screenHeight*0.005),
              child: commonTextfield(context: context,
                hinttext: "State",
              ),
            ),

            SizedBox(height: 16),

            // Save Address Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("SAVE ADDRESS", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  // Reusable Text Field
  Widget _textField(String hint, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        controller: TextEditingController(text: initialValue),
      ),
    );
  }
}
