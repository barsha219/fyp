import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../widgets/primary_button.dart';
import '../authentication/login.dart/login.dart';
import '../authentication/signup.dart/signup.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
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
            SizedBox(height: 40),
            PrimaryButton(
              title: "Login",
              mini: true,
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ),
              ),
            ),
            SizedBox(height: 12),
            PrimaryButton(
              title: "Signup",
              mini: true,
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
