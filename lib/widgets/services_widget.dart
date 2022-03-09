// import 'package:flutter/material.dart';

// class PaarlourServices extends StatelessWidget {
//   const PaarlourServices({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//               child: Container(
//                 padding: const EdgeInsets.all(6),
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: Colors.white.withOpacity(0.3),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 4),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Our Services",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                           TextButton(
//                               onPressed: () => Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const SeeMore(),
//                                   )),
//                               child: const Text(
//                                 "see more",
//                                 style: TextStyle(color: Colors.black),
//                               )),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                         height: 180,
//                         child: FutureBuilder<List<Product>>(
//                             future: ProductService().fetchAllProduct(),
//                             builder: (context, snapshot) {
//                               if (!snapshot.hasData) {
//                                 return const Center(
//                                     child: Text("No Data Found"));
//                               }
//                               List<Product> products =
//                                   snapshot.data as List<Product>;
//                               return ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: products.length,
//                                 itemBuilder: (context, index) {
//                                   Product product = products[index];
//                                   return SizedBox(
//                                     width: 120.0,
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.push(context,
//                                             MaterialPageRoute(builder: (_) {
//                                           return ProductDetails(
//                                             product: product,
//                                           );
//                                         }));
//                                       },
//                                       child: Column(
//                                         children: [
//                                           Card(
//                                             color: Colors.white,
//                                             child: Container(
//                                               height: 140,
//                                               width: 100,
//                                               decoration: snapshot.data != null
//                                                   ? BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5.0),
//                                                       image: DecorationImage(
//                                                         image: NetworkImage(
//                                                             product.image ??
//                                                                 ""),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     )
//                                                   : null,
//                                             ),
//                                           ),
//                                           Container(
//                                             width: double.infinity,
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal: 6),
//                                             padding: const EdgeInsets.all(4),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 color: const Color.fromARGB(
//                                                     255, 228, 228, 228)),
//                                             child: Text(
//                                               product.name ?? "",
//                                               textAlign: TextAlign.center,
//                                               softWrap: true,
//                                               maxLines: 1,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                             })),
//                   ],
//                 ),
//               ),
//             ),
//   }
// }