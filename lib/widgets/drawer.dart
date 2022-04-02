import 'package:beauty_store/meta/screens/dashboard/dashboard.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(child: Column()),
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              AuthService.instance.logout();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashBoardView()));
            },
          ),
        ],
      ),
    );
  }
}
