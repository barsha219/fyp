import 'package:beauty_store/models/bookings.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class BookingCardView extends StatelessWidget {
  final Bookings bookings;

  const BookingCardView({Key? key, required this.bookings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.34),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${bookings.name}"),
          const SizedBox(height: 6),
          Text("Phone Number: ${bookings.contactNumber}"),
          const SizedBox(height: 6),
          Text("Booked For: ${bookings.bookingTime}"),
          const SizedBox(height: 6),
          Text("Service Name: ${bookings.serviceId}"),
          const SizedBox(height: 6),
          Text("Booked Date: ${bookings.bookingDate}"),
          const SizedBox(height: 6),
          Text(
              "Booked Time: ${timeago.format(DateTime.parse(bookings.createdAt!))}")
        ],
      ),
    );
  }
}
