import 'package:beauty_store/models/services.models.dart';
import 'package:beauty_store/services/services.service.dart';
import 'package:beauty_store/widgets/services_widget.dart';
import 'package:flutter/material.dart';

class SeeMoreServices extends StatefulWidget {
  const SeeMoreServices({Key? key}) : super(key: key);

  @override
  State<SeeMoreServices> createState() => _SeeMoreServicesState();
}

class _SeeMoreServicesState extends State<SeeMoreServices> {
  @override
  void initState() {
    init();
    super.initState();
  }

  List<Services>? _services;
  init() async {
    _services = await ServicesItems().fetchAllServices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffa6baef),
      appBar: AppBar(
        elevation: 0,
        title: const Text("All Services"),
        backgroundColor: const Color(0xffa6baef),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 0),
        itemCount: _services?.length ?? 0,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(6),
          child: ServiceWidget(services: _services![index]),
        ),
      ),
    );
  }
}
