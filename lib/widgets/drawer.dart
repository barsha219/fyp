import 'package:beauty_store/meta/screens/Admin%20View/admin_view.dart';
import 'package:beauty_store/meta/screens/dashboard/dashboard.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:beauty_store/user_Profile/user_profile.dart';
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
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                auth.user?.profilePic ?? const CircleAvatar(),
              ],
            )),
          ),
          if (auth.user?.isAdmin ?? false)
            ListTile(
              title: const Text("Admin"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdiminView()));
              },
            ),
          ListTile(
            title: const Text("Profile"),
            onTap: () {
              // AuthService.instance.logout();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfileView()));
            },
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
