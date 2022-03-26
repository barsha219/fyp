import 'package:beauty_store/meta/screens/Bookmark/bookmark.dart';
import 'package:beauty_store/services/booking.service.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  void initState() {
    super.initState();
    inis();
  }

  inis() async {
    await BookingService().getUserBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) => const ListTile(),
      ),
    );
  }
}
