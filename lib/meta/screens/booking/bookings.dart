import 'dart:developer';

import 'package:beauty_store/meta/screens/Bookmark/bookmark.dart';
import 'package:beauty_store/models/bookings.dart';
import 'package:beauty_store/services/booking.service.dart';
import 'package:beauty_store/services/services.service.dart';
import 'package:beauty_store/widgets/button_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        title: const Text("Bookings"),
        elevation: 0,
        // leading: IconButton(
        //     onPressed: () => navigate(), icon: const Icon(Icons.backpack)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await inis();
        },
        child: bookings == null || bookings!.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Bookings found',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  ElevatedButton(
                      onPressed: () => inis(), child: const Text('Refesh')),
                ],
              ))
            : ListView.builder(
                itemCount: bookings?.length,
                itemBuilder: (context, index) {
                  Bookings booking = bookings![index];
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
                        Text("Name: ${booking.name}"),
                        const SizedBox(height: 6),
                        Text("Phone Number: ${booking.contactNumber}"),
                        const SizedBox(height: 6),
                        Text("Booked For: ${booking.bookingTime}"),
                        const SizedBox(height: 6),
                        Text("Service Name: ${booking.serviceId}"),
                        const SizedBox(height: 6),
                        Text("Booked Date: ${booking.bookingDate}"),
                        const SizedBox(height: 6),
                        Text(
                            "Booked Time: ${timeago.format(DateTime.parse(booking.createdAt!))}"),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await ServicesItems()
                                  .deleteBooking(booking.sId ?? "");
                              Fluttertoast.showToast(
                                  msg: "Your booking has been cancled");
                              setState(() => bookings?.remove(booking));
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  );
                }

                // ListTile(
                //   title: Text(timeago
                //       .format(DateTime.parse(bookings![index].createdAt!))),
                // ),
                ),
      ),
    );
  }
}
