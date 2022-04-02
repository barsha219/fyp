import 'package:beauty_store/meta/screens/Bookmark/bookmark.dart';
import 'package:beauty_store/meta/screens/booking/booking_card_view.dart';
import 'package:beauty_store/models/bookings.dart';
import 'package:beauty_store/services/booking.service.dart';
import 'package:beauty_store/widgets/button_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  List<Bookings>? bookings;
  @override
  void initState() {
    super.initState();
    inis();
  }

  inis() async {
    bookings = await BookingService().getUserBookings();
    setState(() {});
  }

  // navigate() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (_) => const Layout()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //     onPressed: () => navigate(), icon: const Icon(Icons.backpack)),
          ),
      body: RefreshIndicator(
        onRefresh: () async {
          await inis();
        },
        child: bookings == null || bookings!.isEmpty
            ? const Center(child: Text('Noo Booking found'))
            : ListView.builder(
                itemCount: bookings?.length,
                itemBuilder: (context, index) => BookingCardView(
                      bookings: bookings![index],
                    )

                // ListTile(
                //   title: Text(timeago
                //       .format(DateTime.parse(bookings![index].createdAt!))),
                // ),
                ),
      ),
    );
  }
}
