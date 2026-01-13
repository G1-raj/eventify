import 'package:eventify/core/widgets/action_button/action_button.dart';
import 'package:eventify/core/widgets/input_field/input_field.dart';
import 'package:eventify/features/auth/signup/data/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});


  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);

    ref.listen(loginControllerProvider, (_, next) {
      next.whenOrNull(
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.toString()))
          );
        },
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login successful")),
          );
        }
      );
    });

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
                child: InputField(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  textController: emailController,
                )
               ),

               SizedBox(
                height: screenHeight * 0.02,
               ),

               SizedBox(
                width: screenWidth * 0.8,
                child: InputField(
                  isPassword: true,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  textController: passwordController,
                )
               ),

               SizedBox(
                height: screenHeight * 0.04,
               ),

               SizedBox(
                width: screenWidth * 0.5,
                height: screenHeight * 0.05,
                child: ActionButton(
                  onPress: state.isLoading ? null : () {
                    ref.read(loginControllerProvider.notifier).login(
                      email: emailController.text, 
                      password: passwordController.text
                    );
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
                  print("PUsh to signup screen");
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