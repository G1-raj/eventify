import 'package:eventify/features/auth/login/presentation/login_screen.dart';
import 'package:eventify/features/auth/signup/presentation/signup_screen.dart';
import 'package:eventify/features/organizer/create_event/presentation/create_event_screen.dart';
import 'package:eventify/features/organizer/event_details/presentation/event_details.dart';
import 'package:eventify/features/organizer/organizer_home/presentation/organizer_home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/organizer-home",
  routes: [
    //auth
    GoRoute(
      path: "/login",
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: "/signup",
      builder: (context, state) => SignupScreen(),
    ),

    //organizer screens

    GoRoute(
      path: "/organizer-home",
      builder: (context, state) => OrganizerHomeScreen(),
    ),

    GoRoute(
      path: "/create-event",
      builder: (context, state) => CreateEventScreen(),
    ),

    // GoRoute(
    //   path: "/event-details",
    //   builder: (context, state) => EventDetails(eventName: eventName, eventAddress: eventAddress, eventDateTime: eventDateTime, totalSeats: totalSeats, bookedSeats: bookedSeats, seatPrice: seatPrice, eventStatus: eventStatus, isBookingPaused: isBookingPaused),
    // )
  ]
);