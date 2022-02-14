import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/meta/screens/dashboard/dashboard.dart';
import 'package:beauty_store/meta/screens/get_started/get_started.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GetStartedView(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConfig.appName,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10),
            const Text(AppConfig.appSlogan),
          ],
        ),
      ),
    );
  }
}
