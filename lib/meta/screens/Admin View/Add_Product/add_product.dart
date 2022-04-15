import 'dart:developer';
import 'dart:io';

import 'package:beauty_store/models/category_models.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:beauty_store/services/product.service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? file;
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  String? selectedCategory;

  bool isloading = false;
  List<Category>? categories;

//  displays the product name and image and cetegory
  @override
  void initState() {
    super.initState();
    init();
  }

  List<Product>? products;

  init() async {
    setState(() {
      isloading = true;
    });
    try {
      categories = await ProductService().fetchAllProductCategory();
      products = await ProductService().fetchAllProduct();
      setState(() {});
      setState(() {
        isloading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                    'Add Product',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: name,
                                    style: const TextStyle(fontSize: 15),
                                    decoration: const InputDecoration(
                                      hintText: 'Product Name',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    keyboardType: TextInputType.phone,
                                    controller: price,
                                    style: const TextStyle(fontSize: 15),
                                    decoration: const InputDecoration(
                                      hintText: 'Product Price',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: description,
                                    minLines:
                                        6, // any number (It works as the rows for the textarea)
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    style: const TextStyle(fontSize: 15),
                                    decoration: const InputDecoration(
                                      hintText: 'Description',
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    children: List.generate(
                                        categories?.length ?? 0,
                                        (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: ActionChip(
                                                  backgroundColor:
                                                      categories?[index].name ==
                                                              selectedCategory
                                                          ? Colors.blue.shade200
                                                          : Colors
                                                              .teal.shade100,
                                                  label: Text(
                                                      categories?[index].name ??
                                                          ''),
                                                  onPressed: () {
                                                    selectedCategory =
                                                        categories?[index]
                                                                .name ??
                                                            '';
                                                    msetState(() {});
                                                  }),
                                            )),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      file = File((await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery))!
                                          .path);
                                      msetState(() {});
                                    },
                                    icon: const Icon(Icons.upload),
                                    label: const Text('Selet Image'),
                                  ),
                                  if (file != null) Image.file(file!),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (name.text.trim().isEmpty &&
                                            price.text.isEmpty &&
                                            description.text.trim().isEmpty &&
                                            file == null) {
                                          Fluttertoast.showToast(
                                              msg: "Name is Required");
                                        } else if (price.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "Price Required");
                                        } else if (description.text.length <
                                            10) {
                                          Fluttertoast.showToast(
                                              msg: "Description Required");
                                        } else if (file == null) {
                                          Fluttertoast.showToast(
                                              msg: "Image Required");
                                        } else {
                                          try {
                                            msetState(() {
                                              isloading = true;
                                            });
                                            final image = await ProductService()
                                                .addProduct(
                                              name: name.text,
                                              category: selectedCategory!,
                                              description: description.text,
                                              price: price.text,
                                              file: file!,
                                            );
                                            // setState(() {
                                            //   products = [
                                            //     ...?products,
                                            //     Product(
                                            //       name: name.text,
                                            //       category: selectedCategory,
                                            //       description: description.text,
                                            //       price: int.parse(price.text),
                                            //       image: image,
                                            //       // int var =int.parse(_section_id.text);
                                            //     )
                                            //   ];
                                            // });
                                            init();
                                            name.clear();
                                            selectedCategory = null;
                                            description.clear();
                                            price.clear();
                                            name.clear();
                                            msetState(() => file = null);
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Product Added Successfully");
                                            Navigator.pop(context);
                                            setState(() {
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
                            ),
                          );
                        }));
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              )),
        ],
        title: const Text("Add Product"),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.amber,
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: products?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                  title: Text(products?[index].name ?? ''),
                  leading: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                        height: 100,
                        width: 50,
                        child: Image.network(products![index].image!)),
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        setState(() {
                          isloading = true;
                        });
                        try {
                          await ProductService()
                              .deleteProduct(products?[index].id ?? "");
                          products!.remove(products?[index]);
                          setState(() {});
                          setState(() {
                            isloading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Product Deleted Successfully");
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      icon: isloading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.delete))),
            ),
    );
  }
}
