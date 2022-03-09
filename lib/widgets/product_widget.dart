// fetching comics
import 'package:beauty_store/meta/screens/product.details.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:beauty_store/widgets/cacheImageView.dart';
import 'package:snapshot/snapshot.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
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
              decoration: List<Product> != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(product.image ?? ""),
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 228, 228, 228)),
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
    );
  }
}
