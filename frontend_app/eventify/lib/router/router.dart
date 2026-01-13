import 'package:eventify/features/auth/login/presentation/login_screen.dart';
import 'package:eventify/features/auth/signup/presentation/signup_screen.dart';
import 'package:eventify/features/organizer/create_event/presentation/create_event_screen.dart';
import 'package:eventify/features/organizer/event_details/presentation/event_details.dart';
import 'package:eventify/features/organizer/organizer_home/presentation/organizer_home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: "/login",
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

    GoRoute(
      path: "/event-details",
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return EventDetails(
          imageUrl: data["imageUrl"],
          eventName: data["eventName"], 
          eventAddress: data["eventAddress"], 
          eventDateTime: data["eventDateTime"], 
          totalSeats: data["totalSeats"], 
          bookedSeats: data["bookedSeats"], 
          seatPrice: data["seatPrice"], 
          eventStatus: data["eventStatus"], 
          isBookingPaused: data["isBookingPaused"]
        );
      }
    )
  ]
);