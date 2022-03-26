import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/meta/screens/home/home.dart';
import 'package:beauty_store/meta/screens/splash/splash.dart';
import 'package:beauty_store/widgets/button_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox("product");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashView(),
          theme: ThemeData(
              fontFamily: GoogleFonts.ruluko().fontFamily,
              primaryColor: const Color(0xffa6baef),
              scaffoldBackgroundColor: const Color(0xffa6baef),
              colorScheme: const ColorScheme.light().copyWith(
                primary: const Color(0xffa6baef),
              )),
          title: AppConfig.appName);
    });
  }
}
