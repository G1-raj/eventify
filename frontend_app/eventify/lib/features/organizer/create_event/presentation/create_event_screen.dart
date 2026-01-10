import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),

      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Text("Create Event", style: GoogleFonts.handjet(
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),),
        centerTitle: true,
        elevation: 0,
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

class EventDetailInput extends StatelessWidget {
  const EventDetailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}