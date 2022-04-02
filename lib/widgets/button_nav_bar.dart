// import 'package:beautystore/app/config/key.dart';
// import 'package:beautystore/app/viewmodel/authentication.viewmodel.dart';
// import 'package:provider/provider.dart';
// import 'package:beautystore/app/meta/screens/home/views/blogs/blog.dart';
// import 'package:beautystore/app/meta/screens/home/views/bookings/bookings.dart';
// import 'package:beautystore/app/meta/screens/home/views/profile/profile.dart';
// import 'package:beautystore/app/meta/screens/home/views/services/services.dart';
import 'package:beauty_store/meta/screens/Bookmark/bookmark.dart';
import 'package:beauty_store/meta/screens/booking/bookings.dart';
import 'package:beauty_store/meta/screens/home/home.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<Widget> _screens = [
    const HomeView(),
    const BookMarkView(),
    const Booking(),
    Container(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _index = index;
          setState(() {});
        },
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user), label: "Profile"),
        ],
      ),
      body: IndexedStack(
        children: _screens,
        index: _index,
      ),
    );
  }
}
