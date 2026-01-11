import 'package:eventify/core/widgets/action_button/action_button.dart';
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

                  SizedBox(
                    width: screenWidth * 0.8,
                    child: EventDetailInput(
                      inputTitle: "Event Name",
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  SizedBox(
                    width: screenWidth * 0.8,
                    child: EventDetailInput(
                      inputTitle: "Event Address",
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  SizedBox(
                    width: screenWidth * 0.8,
                    child: EventDetailInput(
                      inputTitle: "Event Date and Time",
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  SizedBox(
                    width: screenWidth * 0.8,
                    child: EventDetailInput(
                      inputTitle: "Event Seats",
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  SizedBox(
                    width: screenWidth * 0.8,
                    child: EventDetailInput(
                      inputTitle: "Seat price",
                    ),
                  ),

                   SizedBox(
                    height: screenHeight * 0.04,
                  ),

                  SizedBox(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.05,
                    child: ActionButton(
                      buttonText: "Create Event", 
                      textColor: Color.fromRGBO(255, 255, 255, 1), 
                      fontSize: screenWidth * 0.05, 
                      buttonColor: Colors.blue
                    ),
                  )
                  
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
  final String inputTitle;
  const EventDetailInput(
    {
      super.key,
      required this.inputTitle
    }
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(inputTitle, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),)
        ),

        SizedBox(
          height: 3,
        ),

        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey, width: 1)
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey, width: 1)
            ),

            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey, width: 1)
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.red, width: 1)
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.blue, width: 1)
            ),
          ),
        ),
      ],
    );
  }
}