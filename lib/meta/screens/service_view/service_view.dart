import 'dart:developer';
import 'package:beauty_store/meta/screens/booking/bookings.dart';
import 'package:beauty_store/models/services.models.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:beauty_store/services/booking.service.dart';
import 'package:beauty_store/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ServiceView extends StatefulWidget {
  final Services service;
  const ServiceView({Key? key, required this.service}) : super(key: key);

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  final List timeslot = [
    '10am',
    '11am',
    '12pm',
    '1pm',
    '2pm',
    '3pm',
    '4pm',
    '5pm',
    '6pm'
  ];

  String? time;
  String? date;

  @override
  void initState() {
    super.initState();

    init();
  }

  bool loading = false;
  List<String> bookingsTimeSlot = [];

  init() async {
    bookingsTimeSlot = [];
    setState(() {});
    String todayDate = date ??
        '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
    setState(() => date = todayDate);
    setState(() => loading = true);
    final response = await BookingService()
        .fetchAllServiceOfThatDate(widget.service.id ?? "", date ?? todayDate);
    log(response.toString());
    for (var i = 0; i < response.length; i++) {
      bookingsTimeSlot.add(response[i].bookingTime!);
      setState(() {});
      log(bookingsTimeSlot.toString());
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    // log(AuthService.instance.user!.id.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white70),
        // elevation: 0,
        centerTitle: true,
        title: Text(
          widget.service.serviceName ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              // height: 500,
              child: Image.network(widget.service.image ?? ""),
            ),
            const SizedBox(height: 20),
            Text(widget.service.serviceName ?? "",
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 20),
            Text("Rs. " + widget.service.price.toString(),
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : Wrap(
                      children: [
                        for (var i = 0; i < timeslot.length; i++)
                          !bookingsTimeSlot.contains(timeslot[i])
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: ActionChip(
                                      backgroundColor: timeslot[i] == time
                                          ? Colors.amber
                                          : Colors.white,
                                      label: Text(timeslot[i]),
                                      onPressed: () {
                                        setState(() {
                                          time = timeslot[i];
                                        });
                                      }),
                                )
                              : const SizedBox.shrink(),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                          DateTime.now().year, DateTime.now().month + 1),
                    ).then((value) async {
                      final mdate =
                          "${value!.year}/${value.month}/${value.day}";
                      date = mdate;
                      await init();
                      setState(() {});
                    });
                  },
                  child: Text(date ?? 'Selecte Date')),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                title: 'Book',
                disabled: date == null || time == null,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  // log(widget.service.id);
                  // log(AuthService.instance.user!.toMap().toString());
                  await BookingService().addBookings(context, {
                    "serviceId": widget.service.id,
                    "serviceName": widget.service.serviceName,
                    "name": AuthService.instance.user?.name,
                    "price": widget.service.price,
                    "bookedBy": AuthService.instance.user?.id,
                    "bookingDate": date,
                    "bookingTime": time,
                    "contactNumber": AuthService.instance.user?.phoneNumber,
                  });
                  setState(() => timeslot.remove(time));
                  setState(() => date = null);
                  setState(() {
                    loading = false;
                  });
                  Fluttertoast.showToast(
                      msg: "Your Booking has been Confirmed");
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Booking()));
                },
                loading: loading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
