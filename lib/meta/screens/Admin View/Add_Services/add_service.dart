import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:beauty_store/models/services.models.dart';
import 'package:beauty_store/services/services.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  bool isloading = false;
  List<Services>? services;

  @override
  void initState() {
    super.initState();
    init();
  }

  final TextEditingController controller = TextEditingController();

  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Services"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) =>
                        StatefulBuilder(builder: (context, msetState) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Add Services",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: controller,
                                      style: const TextStyle(fontSize: 15),
                                      onChanged: (value) {},
                                      decoration: const InputDecoration(
                                          hintText: "Add Service Name"),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        file = File((await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery))!
                                            .path);
                                        msetState(() {});
                                      },
                                      icon: const Icon(Icons.upload),
                                      label: const Text("Select Image"),
                                    ),
                                    if (file != null) Image.file(file!),
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (controller.text.trim().isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Service name required");
                                          } else {
                                            msetState(() {
                                              isloading = true;
                                            });
                                            try {
                                              final image =
                                                  await ServicesItems()
                                                      .addService(
                                                          name: controller.text,
                                                          imageUrl: file!);
                                              setState(() => services = [
                                                    ...?services,
                                                    Services(
                                                        name: controller.text,
                                                        image: image)
                                                  ]);
                                              controller.clear();
                                              msetState(() => file = null);
                                              Navigator.pop(context);
                                              msetState(() {
                                                isloading = false;
                                              });
                                            } catch (e) {
                                              log(e.toString());
                                            }
                                          }
                                        },
                                        child: isloading
                                            ? const SizedBox(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.black,
                                                ),
                                                height: 20,
                                                width: 20,
                                              )
                                            : const Text("Confirm"))
                                  ]),
                            ),
                          );
                        }));
              },
              icon: const Icon(
                Icons.upload,
                size: 30,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: services?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: const EdgeInsets.all(8),
              title: Text(services![index].name ?? ""),
              leading: SizedBox(
                height: 60,
                child: Image.network(services![index].image ?? ""),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    try {
                      await ServicesItems()
                          .deleteService(services?[index].id ?? "");
                      services!.remove(services?[index]);
                      setState(() {});
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  icon: const Icon(Icons.delete)),
            );
          }),
    );
  }

  @override
  void init() async {
    if (mounted) {
      services = await ServicesItems().fetchAllServices();
      setState(() {});
    }
  }
}
