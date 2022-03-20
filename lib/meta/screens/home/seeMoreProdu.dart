import 'package:beauty_store/models/product_models.dart';
import 'package:beauty_store/services/product.service.dart';
import 'package:beauty_store/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class SeeMore extends StatefulWidget {
  const SeeMore({Key? key}) : super(key: key);

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  @override
  void initState() {
    init();
    super.initState();
  }

  List<Product>? _products;
  init() async {
    _products = await ProductService().fetchAllProduct();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffa6baef),
      appBar: AppBar(
        elevation: 0,
        title: const Text("All Products"),
        backgroundColor: const Color(0xffa6baef),
      ),
      body:
          // _products == null || _products.isEmpty
          //     ? SizedBox(x
          //         height: MediaQuery.of(context).size.height / 2,
          //         child: const Center(child: CircularProgressIndicator()),
          //       )
          GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 0),
        itemCount: _products?.length ?? 0,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(6),
          child: ProductWidget(product: _products![index]),
        ),
      ),
    );
  }
}
