import 'dart:developer';

import 'package:beauty_store/meta/screens/product.details.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:beauty_store/widgets/cacheImageView.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookMarkView extends StatefulWidget {
  const BookMarkView({Key? key}) : super(key: key);

  @override
  State<BookMarkView> createState() => _BookMarkViewState();
}

class _BookMarkViewState extends State<BookMarkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favourites"),
          // elevation: 0,
          centerTitle: true,
          // backgroundColor: Colors.blueAccent,
        ),
        body: ValueListenableBuilder(
            valueListenable: Hive.box("product").listenable(),
            builder: (context, box, snapshot) {
              log(box.toString());

              if (Hive.box("product").isEmpty) {
                return const Center(
                    child: Text("No Favourites Yet",
                        style: TextStyle(fontSize: 20)));
                // style: Theme.of(context).textTheme.headline6,

              }
              return ListView.builder(
                itemCount: Hive.box("product").length,
                itemBuilder: (context, index) {
                  log(Hive.box("product").getAt(index).toString());
                  final data =
                      Product.fromJson(Hive.box("product").getAt(index));
                  log(data.toString());

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 18),
                    title: Text(data.name ?? ""),
                    leading: CacheImageViewer(
                        image: data.image ?? "", height: 80, width: 45),
                    trailing: IconButton(
                        onPressed: () {
                          Hive.box("product").deleteAt(index);
                          setState(() {});
                        },
                        icon: const Icon(Icons.favorite)),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(product: data),
                        )),
                  );
                },
              );
            }));
  }
}
