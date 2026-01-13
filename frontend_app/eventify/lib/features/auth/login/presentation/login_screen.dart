import 'package:eventify/core/widgets/action_button/action_button.dart';
import 'package:eventify/core/widgets/input_field/input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Form(
          key: _formKey,
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
               ),

               SizedBox(
                width: screenWidth * 0.8,
                child: const InputField(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                )
               ),

               SizedBox(
                height: screenHeight * 0.02,
               ),

               SizedBox(
                width: screenWidth * 0.8,
                child: const InputField(
                  isPassword: true,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                )
               ),

               SizedBox(
                height: screenHeight * 0.04,
               ),

               SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.05,
                child: ActionButton(
                  onPress: () {
                    context.pushReplacement("/organizer-home");
                  },
                  buttonText: "Login",
                  buttonColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: screenWidth * 0.05,
                )
               ),

               SizedBox(
                height: screenHeight * 0.07,
               ),

               GestureDetector(
                onTap: () {
                  context.push("/signup");
                },

                child: Text("Don't have account? Signup"),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}