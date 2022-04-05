import 'package:beauty_store/meta/screens/Admin%20View/Add_Product/add_product.dart';
import 'package:beauty_store/meta/screens/Admin%20View/Add_Services/add_service.dart';
import 'package:beauty_store/meta/screens/Admin%20View/Booking/booking_view.dart';
import 'package:beauty_store/meta/screens/Admin%20View/Manage_Category/manage_category.dart';
import 'package:flutter/material.dart';

class AdiminView extends StatefulWidget {
  const AdiminView({Key? key}) : super(key: key);

  @override
  State<AdiminView> createState() => _AdiminViewState();
}

class _AdiminViewState extends State<AdiminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _cardView(
              Icons.book,
              "Manage Category",
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageCategory()))),
          _cardView(
              Icons.book,
              "Add Product",
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddProduct()))),
          _cardView(
              Icons.book,
              "Add Services",
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddService()))),
          _cardView(
              Icons.book,
              "View Bookings",
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewBooking()))),
        ],
      ),
    );
  }

  Widget _cardView(IconData icon, String title, VoidCallback onTap) {
    return Card(
      // color: Colors.blue,
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, size: 40), Text(title)],
        )),
      ),
    );
  }
}