import 'dart:developer';

import 'package:beauty_store/models/category_models.dart';
import 'package:beauty_store/services/product.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({Key? key}) : super(key: key);

  @override
  State<ManageCategory> createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  @override
  void initState() {
    super.initState();
    init();
  }

  bool isloading = false;
  List<Category>? categories;

  init() async {
    setState(() {
      isloading = true;
    });
    categories = await ProductService().fetchAllProductCategory();
    setState(() => isloading = false);
  }

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Categories"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) =>
                        StatefulBuilder(builder: (context, msetState) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Add Category',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  style: const TextStyle(fontSize: 15),
                                  onChanged: (value) {},
                                  controller: controller,
                                  decoration: const InputDecoration(
                                      hintText: 'Enter Name'),
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (controller.text.trim().isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "Enter category");
                                      } else {
                                        try {
                                          msetState(() {
                                            isloading = true;
                                          });
                                          await ProductService()
                                              .addCategory(controller.text);
                                          await init();
                                          controller.clear();
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
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text('Submit'))
                              ],
                            ),
                          );
                        }));
              },
              icon: const Icon(
                Icons.upload,
                size: 30,
              )),
        ],
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : ListView.builder(
              itemCount: categories?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(categories?[index].name ?? ""),
                trailing: IconButton(
                    onPressed: () async {
                      setState(() {
                        isloading = true;
                      });
                      try {
                        await ProductService()
                            .deleteCategory(categories?[index].id ?? "");
                        categories!.remove(categories?[index]);
                        setState(() {});
                        setState(() {
                          isloading = false;
                        });
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    icon: isloading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(Icons.delete)),
              ),
            ),
    );
  }
}
