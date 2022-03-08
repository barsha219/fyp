import 'dart:developer';
import 'dart:ffi';

import 'package:beauty_store/meta/screens/home/seeMoreProdu.dart';
import 'package:beauty_store/meta/screens/product.details.dart';
import 'package:beauty_store/models/category_models.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:beauty_store/services/product.service.dart';
import 'package:beauty_store/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // local state
  List<Product>? _products;
  List<Product>? _productDub;
  String? category;
  List<Category>? _categories;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    try {
      _productDub = _products;
      _products = await ProductService().fetchAllProduct();
      _categories = await ProductService().fetchAllProductCategory();
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  searchForProduct(String name) {
    category = name;
    setState(() {});
    if (name == "All") {
      _products = _products;
      setState(() {});
    } else {
      _productDub = _products?.where((element) {
        return element.category == name;
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false, // set it to false
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 22, color: Colors.black54),
        ),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ProductService().fetchAllProduct();
            await ProductService().fetchAllProductCategory();
            _productDub = _products;
            setState(() {});
          },
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Wel-come, " +
                          (AuthService.instance.user?.name).toString(),
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _categories?.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ActionChip(
                        backgroundColor: _categories?[index].name == category
                            ? Colors.blue.shade500
                            : const Color.fromARGB(255, 228, 228, 228),
                        onPressed: () {
                          searchForProduct(_categories![index].name!);
                        },
                        label: Text(_categories?[index].name ?? ""),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Our Products",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SeeMore(),
                                  )),
                              child: const Text(
                                "see more",
                                style: TextStyle(color: Colors.black),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 200,
                        child: FutureBuilder<List<Product>>(
                            future: ProductService().fetchAllProduct(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: Text("No Data Found"));
                              }
                              List<Product> products =
                                  snapshot.data as List<Product>;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  Product product = products[index];
                                  return SizedBox(
                                    width: 120.0,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return ProductDetails(
                                            product: product,
                                          );
                                        }));
                                      },
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.white,
                                            child: Container(
                                              height: 160,
                                              width: 100,
                                              decoration: snapshot.data != null
                                                  ? BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            product.image ??
                                                                ""),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color.fromARGB(
                                                    255, 228, 228, 228)),
                                            child: Text(
                                              product.name ?? "",
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            })),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
