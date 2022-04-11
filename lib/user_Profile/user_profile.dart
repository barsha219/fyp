import 'package:beauty_store/services/auth.service.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController? _name;
  TextEditingController? _address;
  TextEditingController? _phoneNumber;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: auth.user!.name);
    _phoneNumber = TextEditingController(text: auth.user!.phoneNumber);
    _address = TextEditingController(text: auth.user!.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SizedBox(
        height: 300,
        child: Card(
          child: Column(
            children: [
              // const Text(
              //   "Profile",
              //   style: TextStyle(
              //     fontSize: 40,
              //   ),
              // ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _name,
                  onSubmitted: (value) async {
                    await auth.updateUserProfile({
                      "name": value,
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Color(0xffa6baef))),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _phoneNumber,
                  onSubmitted: (value) async {
                    await auth.updateUserProfile({
                      "phoneNumber": value,
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Color(0xffa6baef))),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _address,
                  onSubmitted: (value) async {
                    await auth.updateUserProfile({
                      "address": value,
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Color(0xffa6baef))),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Center(
                    child: Text(
                      auth.user?.email ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // color: Colors.white,
                    boxShadow: const [
                      BoxShadow(color: Color(0xffa6baef), spreadRadius: 1),
                    ],
                  ),
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
