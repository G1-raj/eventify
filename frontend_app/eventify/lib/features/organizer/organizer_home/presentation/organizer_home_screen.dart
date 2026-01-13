import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrganizerHomeScreen extends StatelessWidget {
  const OrganizerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(255, 255, 255, 1),

      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 16, 8),
            child: SizedBox(
              width: double.infinity, // 👈 forces full width
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hi 👋",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Govind",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.push(
                      "/event-details", 
                      extra: {
                        "imageUrl": null,
                        "eventName": "Karan Aujla Concert",
                        "eventAddress": "South Delhi",
                        "eventDateTime": "2026-12-02 12:55",
                        "totalSeats": 500,
                        "bookedSeats": 320,
                        "seatPrice": 1500.0,
                        "eventStatus": "UPCOMING",
                        "isBookingPaused": false,
                      }
                    );
                  },
                  child: EventCard(
                    eventName: "Karan Aujla Concert",
                    eventAddress: "South Delhi",
                    eventDateTime: "2026-12-02:12:55",
                    eventStatus: "UPCOMING",
                  ),
                );
              },
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push("/create-event");
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}


class EventCard extends StatelessWidget {
  final String? imageUrl;
  final String eventName;
  final String eventAddress;
  final String eventStatus;
  final String eventDateTime;

  const EventCard({
    super.key,
    this.imageUrl,
    required this.eventName,
    required this.eventAddress,
    required this.eventStatus,
    required this.eventDateTime,
  });

  Color _statusColor() {
    switch (eventStatus) {
      case "UPCOMING":
        return Colors.green;
      case "CANCELLED":
        return Colors.red;
      case "COMPLETED":
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  Widget _buildImageSection() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Container(
        width: 110,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: const Center(
          child: Text(
            "NAN",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Image.network(
      imageUrl!,
      width: 110,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.95,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // IMAGE / NAN SECTION
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(14),
            ),
            child: _buildImageSection(),
          ),

          const SizedBox(width: 12),

          // DETAILS SECTION
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    eventName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          eventAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            eventDateTime,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor().withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          eventStatus,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _statusColor(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
