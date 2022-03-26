import 'dart:developer';

import 'package:beauty_store/models/services.models.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:beauty_store/services/booking.service.dart';
import 'package:beauty_store/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatefulWidget {
  final Services service;
  const ServiceView({Key? key, required this.service}) : super(key: key);

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  final data = [
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
  }

  @override
  Widget build(BuildContext context) {
    log(AuthService.instance.user!.id.toString());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.network(widget.service.image),
            const SizedBox(height: 20),
            Text(widget.service.name,
                style: Theme.of(context).textTheme.headline6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 12,
                children: List.generate(
                  data.length,
                  (index) => ActionChip(
                      backgroundColor:
                          data[index] == time ? Colors.amber : Colors.white,
                      label: Text(data[index]),
                      onPressed: () {
                        setState(() => time = data[index]);
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
                    lastDate: DateTime(DateTime.now().year + 1),
                  ).then((value) async {
                    final mdate = "${value!.year}/${value.month}/${value.day}";
                    date = mdate;
                    // BookingService()
                    //     .fetchAllServiceOfThatDate(widget.service.id, mdate);
                  });
                },
                child: const Text('Selecte Date')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                title: 'Book',
                onTap: () async {
                  await BookingService().addBookings(context, {
                    "serviceId": widget.service.id,
                    "name": AuthService.instance.user?.name,
                    "bookedBy": AuthService.instance.user?.id,
                    "bookingDate": date,
                    "bookingTime": time,
                  });
                  setState(() => data.remove(time));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
