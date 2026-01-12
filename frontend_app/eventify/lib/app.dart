import 'package:eventify/features/organizer/organizer_home/presentation/organizer_home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OrganizerHomeScreen(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: EventDetails(
//         eventName: "Karan Aujla Concert", 
//         eventAddress: "South delhi", 
//         eventDateTime: "2026-12-02:12:45", 
//         totalSeats: 80, 
//         bookedSeats: 12, 
//         seatPrice: 3000, 
//         eventStatus: "UPCOMING", 
//         isBookingPaused: false
//       )
//     );
//   }
// }