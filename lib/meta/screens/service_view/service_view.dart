import 'dart:developer';

import 'package:beauty_store/meta/screens/booking/bookings.dart';
import 'package:beauty_store/models/bookings.dart';
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
  List timeslot = [
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

  final List<String> Copytimeslot = [
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

  init() async {
    String todayDate = date ??
        '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
    setState(() => date = todayDate);
    setState(() => loading = true);
    final response = await BookingService()
        .fetchAllServiceOfThatDate(widget.service.id, date ?? todayDate);
    log("uta bata timeslot k k ako xa... " + response.toString());
    log("seletced date k xa..? " + todayDate.toString());
    if (response.isNotEmpty) {
      for (var res in response) {
        if (timeslot.contains(res.bookingTime)) {
          timeslot.remove(res.bookingTime);
          setState(() {});
        } else {
          setState(() => timeslot = Copytimeslot!);
        }
      }
    } else {
      setState(() => timeslot = Copytimeslot!);
    }
    log('date k k xa actual... ' + timeslot.toString());
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    log(AuthService.instance.user!.id.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
        title: Text(widget.service.name ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(height: 300, child: Image.network(widget.service.image)),
            const SizedBox(height: 20),
            Text(widget.service.name,
                style: Theme.of(context).textTheme.headline6),
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
                      spacing: 12,
                      children: List.generate(
                        timeslot.length,
                        (index) => ActionChip(
                            backgroundColor: timeslot[index] == time
                                ? Colors.amber
                                : Colors.white,
                            label: Text(timeslot[index]),
                            onPressed: () {
                              setState(() => time = timeslot[index]);
                            }),
                      ),
                    ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate:
                        DateTime(DateTime.now().year, DateTime.now().month + 1),
                  ).then((value) async {
                    log(Copytimeslot.toString());
                    setState(() {
                      timeslot = Copytimeslot!;
                    });
                    final mdate = "${value!.year}/${value.month}/${value.day}";
                    date = mdate;
                    await init();
                    setState(() {});
                  });
                },
                child: Text(date ?? 'Selecte Date')),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                title: 'Book',
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  log(widget.service.id);
                  log(AuthService.instance.user!.toMap().toString());
                  await BookingService().addBookings(context, {
                    "serviceId": widget.service.id,
                    "name": AuthService.instance.user?.name,
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
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (builder) => const Booking()),
                  //     (route) => false);
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
