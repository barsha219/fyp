import 'dart:developer';
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
  final TextEditingController con_price = TextEditingController();

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
                                    TextField(
                                      keyboardType: TextInputType.phone,
                                      controller: con_price,
                                      style: const TextStyle(fontSize: 15),
                                      onChanged: (value) {},
                                      decoration: const InputDecoration(
                                          hintText: "Add Service Price"),
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
                                          if (controller.text.trim().isEmpty &&
                                              con_price.text.trim().isEmpty &&
                                              file == null) {
                                            Fluttertoast.showToast(
                                                msg: "Service name required");
                                          } else if (con_price.text
                                              .trim()
                                              .isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Price Required");
                                          } else if (file == null) {
                                            Fluttertoast.showToast(
                                                msg: "Image Required");
                                          } else {
                                            msetState(() {
                                              isloading = true;
                                            });
                                            try {
                                              final image =
                                                  await ServicesItems()
                                                      .addService(
                                                          name: controller.text,
                                                          price: con_price.text,
                                                          imageUrl: file!);
                                              init();
                                              controller.clear();
                                              con_price.clear();
                                              msetState(() => file = null);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Service Added Successfully");
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
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: services?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  title: Text(services![index].name ?? ""),
                  leading: SizedBox(
                    height: 60,
                    width: 90,
                    child: Image.network(services![index].image ?? ""),
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        try {
                          await ServicesItems()
                              .deleteService(services?[index].id ?? "");
                          services!.remove(services?[index]);
                          setState(() {});
                          setState(() {
                            isloading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Service Deleted Successfully");
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
    setState(() {
      isloading = true;
    });
    if (mounted) {
      services = await ServicesItems().fetchAllServices();
      setState(() {});
      setState(() {
        isloading = false;
      });
    }
  }
}
