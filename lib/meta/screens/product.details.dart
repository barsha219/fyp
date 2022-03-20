import 'package:beauty_store/models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white70),
        elevation: 0,
        title: Text(
          widget.product.name ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var box = Hive.box("product").get(widget.product.id);
                if (box == null) {
                  // for storing products
                  await Hive.box("product")
                      .put(widget.product.id, widget.product.toJson());
                } else {
                  // deleting the bookmarks
                  await Hive.box("product").delete(widget.product.id);
                }
                setState(() {});
              },
              icon: Hive.box("product").containsKey(widget.product.id)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                elevation: 0,
                color: Colors.white.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(widget.product.image ?? ""),
                            ),
                          )),
                      const SizedBox(height: 12.0),
                      Text(
                        widget.product.name ?? "",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Rs. " + widget.product.price.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        widget.product.description ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
