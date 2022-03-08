// fetching comics
import 'package:beauty_store/meta/screens/product.details.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:beauty_store/widgets/cacheImageView.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          // width: MediaQuery.of(context).size.width * 0.42,
          width: 90,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Expanded(
                child: CacheImageViewer(
                  image: product.image ?? "",
                  width: MediaQuery.of(context).size.width * 32,
                  height: MediaQuery.of(context).size.height * 0.64,
                  // width: 90,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                product.name ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
