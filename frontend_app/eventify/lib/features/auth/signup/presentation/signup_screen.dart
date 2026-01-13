import 'package:eventify/core/widgets/action_button/action_button.dart';
import 'package:eventify/core/widgets/input_field/input_field.dart';
import 'package:eventify/features/auth/signup/data/singup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupControllerProvider);

    ref.listen(signupControllerProvider, (_, next) {
      next.whenOrNull(
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.toString()))
          );
        },
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Signup successful")),
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
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person),
                    textController: userNameController,
                  )
                ),

                SizedBox(
                  height: screenHeight * 0.02,
                ),

                SizedBox(
                  width: screenWidth * 0.8,
                  child: InputField(
                    hintText: "Full name",
                    prefixIcon: Icon(Icons.person),
                    textController: fullNameController,
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
                  height: screenHeight * 0.02,
                ),

                SizedBox(
                  width: screenWidth * 0.8,
                  child: InputField(
                    isPassword: true,
                    hintText: "Confirm password",
                    prefixIcon: Icon(Icons.lock),
                    textController: cnfPasswordController,
                  )
                ),

                SizedBox(
                  height: screenHeight * 0.04,
                ),

                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.05,
                  child: ActionButton(
                    buttonText: "Signup",
                    buttonColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: screenWidth * 0.05,
                    onPress: state.isLoading ? null : () {
                      ref.read(signupControllerProvider.notifier).signup(
                        email: emailController.text, 
                        username: userNameController.text, 
                        fullName: fullNameController.text, 
                        password: passwordController.text, 
                        role: "user"
                      );
                    },
                  )
                ),

                SizedBox(
                  height: screenHeight * 0.06,
                ),

                GestureDetector(
                  onTap: () {
                    context.pop();
                  },

                  child: Text("Already have an account? Login"),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}