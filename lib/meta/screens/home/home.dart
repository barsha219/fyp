import 'package:beauty_store/models/product_model.dart';
import 'package:beauty_store/services/product.service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
        child: CustomScrollView(slivers: [
          // const SliverToBoxAdapter(
          //     // child: SizedBox(
          //     //   height: 30,
          //     // ),
          //     ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      children: const [
                        Text(
                          "Our Products",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 150,
                      child: FutureBuilder<List<Product>>(
                          future: ProductService().fetchProduct(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: Text("No Data Found"));
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
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Card(
                                            color: Colors.white,
                                            child: Container(
                                              height: 110,
                                              width: 90,
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
                                    ));
                              },
                            );
                          })),
                ],
              ),
            ),
          )
        ]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(child: Column()),
            ),
          ],
        ),
      ),
    );
  }
}
