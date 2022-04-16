import 'dart:developer';
import 'package:beauty_store/models/bookings.dart';
import 'package:beauty_store/services/booking.service.dart';
import 'package:beauty_store/services/services.service.dart';
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
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    inis();
  }

  inis() async {
    setState(() {
      isloading = true;
    });
    bookings = await BookingService().getUserBookings();
    setState(() {});
    setState(() {
      isloading = false;
    });
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
        centerTitle: true,
        elevation: 0,
        // leading: IconButton(
        //     onPressed: () => navigate(), icon: const Icon(Icons.backpack)),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await inis();
          },
          child: renderBody(bookings)),
    );
  }

  renderBody(List<Bookings>? bookings) {
    if (bookings == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    } else if (bookings.isEmpty) {
      return const Center(
          child: Text(
        "No Bookings Found",
        style: TextStyle(fontSize: 20),
      ));
    } else {
      return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            Bookings booking = bookings[index];
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
                  // Text("serviceId: ${booking.serviceId}"),
                  // const SizedBox(height: 6),
                  Text("Customer Name: ${booking.name}"),
                  const SizedBox(height: 6),
                  Text("Phone Number: ${booking.contactNumber}"),
                  const SizedBox(height: 6),
                  Text("Service Id: ${booking.serviceName}"),
                  const SizedBox(height: 6),
                  Text("Booked For: ${booking.bookingTime}"),
                  const SizedBox(height: 6),
                  Text("Service Price: ${booking.price}"),
                  const SizedBox(height: 6),
                  Text("Booked Date: ${booking.bookingDate}"),
                  const SizedBox(height: 6),
                  Text(
                      "Booked Time: ${timeago.format(DateTime.parse(booking.createdAt!))}"),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await ServicesItems().deleteBooking(booking.sId ?? "");
                        Fluttertoast.showToast(
                            msg: "Your booking has been cancled");
                        setState(() => bookings.remove(booking));
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
          );
    }
  }
}
