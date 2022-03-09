// import 'package:beautystore/app/config/key.dart';
// import 'package:beautystore/app/viewmodel/authentication.viewmodel.dart';
// import 'package:provider/provider.dart';
// import 'package:beautystore/app/meta/screens/home/views/blogs/blog.dart';
// import 'package:beautystore/app/meta/screens/home/views/bookings/bookings.dart';
// import 'package:beautystore/app/meta/screens/home/views/profile/profile.dart';
// import 'package:beautystore/app/meta/screens/home/views/services/services.dart';
import 'package:beauty_store/meta/screens/home/home.dart';
import 'package:flutter/material.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({Key? key}) : super(key: key);

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  final List<Widget> _screens = [
    //   // const ServicesView(),
    //   // const FavoriteView(),
    //   // const BookingView(),
    //   // const ProfileView(),
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
            label: "HomeView()",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: "Booking"),
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
