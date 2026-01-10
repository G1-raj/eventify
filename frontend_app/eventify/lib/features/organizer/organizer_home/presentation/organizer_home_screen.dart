import 'package:flutter/material.dart';

class OrganizerHomeScreen extends StatelessWidget {
  const OrganizerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(255, 255, 255, 1),

      body: Center(
        child: Text("Home screen"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}