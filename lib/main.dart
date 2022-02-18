import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/meta/screens/authentication/login.dart/login.dart';
import 'package:beauty_store/meta/screens/splash/splash.dart';
// import 'package:beauty_store/meta/screens/authentication/signup.dart/signup.dart';
// import 'package:beauty_store/meta/screens/get_started/get_started.dart';
// import 'package:beauty_store/meta/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView(),
        theme: ThemeData(
            fontFamily: GoogleFonts.ruluko().fontFamily,
            primaryColor: const Color(0xffa6baef),
            scaffoldBackgroundColor: const Color(0xffa6baef),
            colorScheme: const ColorScheme.light().copyWith(
              primary: const Color(0xffa6baef),
            )),
        title: AppConfig.appName,
      );
    });
  }
}
