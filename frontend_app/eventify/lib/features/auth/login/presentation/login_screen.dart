import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.2,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),

              child: Center(child: Text("Eventify", style: GoogleFonts.fasthand(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: screenWidth * 0.06,
              ),)),
             ),

             SizedBox(
              height: screenHeight * 0.06,
             )
            ],
          ),
        ),
      ),
    );
  }
}