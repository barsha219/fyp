import 'package:beauty_store/meta/screens/service_view/service_view.dart';
import 'package:beauty_store/models/product_models.dart';
import 'package:beauty_store/models/services.models.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final Services services;

  const ServiceWidget({Key? key, required this.services}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ServiceView(
            service: services,
          );
        }));
      },
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: Container(
              height: 150,
              width: 100,
              decoration: List<Product> != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: NetworkImage(services.image ?? ""),
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
              services.serviceName ?? "",
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
