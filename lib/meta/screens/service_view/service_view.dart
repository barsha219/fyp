import 'dart:developer';
import 'package:beauty_store/models/bookings.dart';
import 'package:beauty_store/models/services.models.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:beauty_store/services/booking.service.dart';
import 'package:beauty_store/services/services.service.dart';
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

  final List<String> copytimeslot = [
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
    List<String> bookingsTimeSlot = [];
    String todayDate = date ??
        '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
    setState(() => date = todayDate);
    setState(() => loading = true);
    final response = await BookingService()
        .fetchAllServiceOfThatDate(widget.service.id ?? "", date ?? todayDate);
    for (var i = 0; i < response.length; i++) {
      bookingsTimeSlot.add(response[i].bookingTime!);
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    // log(AuthService.instance.user!.id.toString());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.service.name ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
                height: 300, child: Image.network(widget.service.image ?? "")),
            const SizedBox(height: 20),
            Text(widget.service.name ?? "",
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
                  // : Wrap(
                  //     spacing: 12,
                  //     children: List.generate(
                  //       timeslot.length,
                  //       (index) {
                  //         // log(timeslot[index].toString());
                  //         bookingsTimeSlot.contains(timeslot[index])
                  //             ?   ActionChip(
                  //                 backgroundColor: timeslot[index] == time
                  //                     ? Colors.amber
                  //                     : Colors.white,
                  //                 label: Text(timeslot[index]),
                  //                 onPressed: () {
                  //                   setState(() => time = timeslot[index]);
                  //                 })
                  //             : null;
                  //       },
                  //     ),
                  //   ),
                  : Wrap(
                      children: [
                        for (var i = 0; i < timeslot.length; i++)
                          !bookingsTimeSlot.contains(timeslot[i])
                              ? ActionChip(
                                  label: Text(timeslot[i]),
                                  onPressed: () {
                                    setState(() {
                                      time = timeslot[i];
                                    });
                                  })
                              : SizedBox.shrink(),
                      ],
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
                    final mdate = "${value!.year}/${value.month}/${value.day}";
                    date = mdate;
                    await init();
                    setState(() {});
                  });
                },
                child: Text(date ?? 'Selecte Date')),
            const SizedBox(
              height: 30,
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
                    "serviceId": widget.service.name,
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
